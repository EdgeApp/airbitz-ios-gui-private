#import "ABC.h"
#import "Wallet.h"
#import "Transaction.h"
#import "TxOutput.h"
#import "User.h"
#import "Keychain.h"

#import "AirbitzCore.h"
#import "AppGroupConstants.h"
#import "ABCUser.h"

#import <pthread.h>
#import <Foundation/Foundation.h>


@implementation BitidSignature
- (id)init
{
    self = [super init];
    return self;
}
@end

@interface AirbitzCore ()
{
}

@end

@implementation AirbitzCore


- (void)postToSyncQueue:(void(^)(void))cb;
{
    [dataQueue addOperationWithBlock:cb];
}

- (void)postToLoadedQueue:(void(^)(void))cb;
{
    [loadedQueue addOperationWithBlock:cb];
}

- (void)postToWalletsQueue:(void(^)(void))cb;
{
    [walletsQueue addOperationWithBlock:cb];
}

- (void)postToGenQRQueue:(void(^)(void))cb;
{
    [genQRQueue addOperationWithBlock:cb];
}

- (void)postToTxSearchQueue:(void(^)(void))cb;
{
    [txSearchQueue addOperationWithBlock:cb];
}

- (void)postToMiscQueue:(void(^)(void))cb;
{
    [miscQueue addOperationWithBlock:cb];
}

- (void)postToWatcherQueue:(void(^)(void))cb;
{
    [watcherQueue addOperationWithBlock:cb];
}


- (ABCConditionCode)signIn:(NSString *)username password:(NSString *)password otp:(NSString *)otp;
{
    tABC_Error error;
    ABCConditionCode ccode = ABCConditionCodeOk;

    if (!username || !password)
    {
        error.code = (tABC_CC) ABCConditionCodeNULLPtr;
        ccode = [self setLastErrors:error];
    }
    else
    {
        if (otp)
        {
            ABC_OtpKeySet([username UTF8String], (char *) [otp UTF8String], &error);
            ccode = [self setLastErrors:error];
        }

        if (ABCConditionCodeOk == ccode)
        {
            ABC_SignIn([username UTF8String],
                    [password UTF8String], &error);
            if ((error.code == ABC_CC_Ok) && (otp != nil))
                otpKey = otp;

            ccode = [self setLastErrors:error];

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
                [self setupLoginPIN];
            });

            [self postlogin:username password:password];
        }
    }

//        if (ABCConditionCodeInvalidOTP == lastConditionCode)
//            bOTPError = YES;
//
    return ccode;
}


- (ABCConditionCode)signIn:(NSString *)username password:(NSString *)password otp:(NSString *)otp
        complete:(void (^)(void)) completionHandler
        error:(void (^)(ABCConditionCode ccode, NSString *errorString)) errorHandler
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        ABCConditionCode ccode = [self signIn:username password:password otp:otp];
        NSString *errorString = [self getLastErrorString];

        dispatch_async(dispatch_get_main_queue(), ^(void) {
            if (ABCConditionCodeOk == ccode)
                completionHandler();
            else
                errorHandler(ccode, errorString);
        });
    });
    return ABCConditionCodeOk;
}

- (ABCConditionCode)signInWithPIN:(NSString *)username pin:(NSString *)pin;
{
    tABC_Error error;
    ABCConditionCode ccode;

    if (!username || !pin)
    {
        error.code = (tABC_CC) ABCConditionCodeNULLPtr;
        return [self setLastErrors:error];
    }

    if ([self PINLoginExists:username])
    {
        ABC_PinLogin([username UTF8String],
                [pin UTF8String],
                &error);
        ccode = [self setLastErrors:error];
        if (ABC_CC_Ok == ccode)
        {
            ABCUser *user = [[ABCUser alloc] init];
            user.airbitzCore = self;
            abcUser = user;

            [abcUser login:username password:nil];
            [self postlogin:username];
        }
    }
    else
    {
        error.code = (tABC_CC) ABCConditionCodeError;
        ccode = [self setLastErrors:error];
    }
    return ccode;

}

- (ABCConditionCode)signInWithPIN:(NSString *)username pin:(NSString *)pin
        complete:(void (^)(void)) completionHandler
        error:(void (^)(ABCConditionCode ccode, NSString *errorString)) errorHandler
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
    {
        ABCConditionCode ccode = [self signInWithPIN:username pin:pin];
        NSString *errorString = [self getLastErrorString];
        dispatch_async(dispatch_get_main_queue(), ^(void)
        {
            if (ABCConditionCodeOk == ccode)
                completionHandler();
            else
                errorHandler(ccode, errorString);
        });
    });
    return ABCConditionCodeOk;
}

- (BOOL)isLoggedIn
{
    return (0 < self.name.length);
}

- (ABCConditionCode) getLastConditionCode;
{
    return lastConditionCode;
}

- (NSString *) getLastErrorString;
{
    return lastErrorString;
}

- (void)uploadLogsAsync:(NSString *)username complete:(void (^)(ABCConditionCode ccode)) completionHandler
{
    [self postToMiscQueue:^{
        tABC_Error error;
        ABC_UploadLogs([[User Singleton].name UTF8String], NULL, &error);

        dispatch_async(dispatch_get_main_queue(), ^(void) {
            completionHandler((ABCConditionCode) error.code);
        });
    }];
}


- (NSString *)conditionCodeMap:(ABCConditionCode) cc;
{
    switch (cc)
    {
        case ABCConditionCodeAccountAlreadyExists:
            return NSLocalizedString(@"This account already exists.", nil);
        case ABCConditionCodeAccountDoesNotExist:
            return NSLocalizedString(@"We were unable to find your account. Be sure your username is correct.", nil);
        case ABCConditionCodeBadPassword:
            return NSLocalizedString(@"Invalid user name or password", nil);
        case ABCConditionCodeWalletAlreadyExists:
            return NSLocalizedString(@"Wallet already exists.", nil);
        case ABCConditionCodeInvalidWalletID:
            return NSLocalizedString(@"Wallet does not exist.", nil);
        case ABCConditionCodeURLError:
        case ABCConditionCodeServerError:
            return NSLocalizedString(@"Unable to connect to Airbitz server. Please try again later.", nil);
        case ABCConditionCodeNoRecoveryQuestions:
            return NSLocalizedString(@"No recovery questions are available for this user", nil);
        case ABCConditionCodeNotSupported:
            return NSLocalizedString(@"This operation is not supported.", nil);
        case ABCConditionCodeInsufficientFunds:
            return NSLocalizedString(@"Insufficient funds", nil);
        case ABCConditionCodeSpendDust:
            return NSLocalizedString(@"Amount is too small", nil);
        case ABCConditionCodeSynchronizing:
            return NSLocalizedString(@"Synchronizing with the network.", nil);
        case ABCConditionCodeNonNumericPin:
            return NSLocalizedString(@"PIN must be a numeric value.", nil);
        case ABCConditionCodeError:
        case ABCConditionCodeNULLPtr:
        case ABCConditionCodeNoAvailAccountSpace:
        case ABCConditionCodeDirReadError:
        case ABCConditionCodeFileOpenError:
        case ABCConditionCodeFileReadError:
        case ABCConditionCodeFileWriteError:
        case ABCConditionCodeFileDoesNotExist:
        case ABCConditionCodeUnknownCryptoType:
        case ABCConditionCodeInvalidCryptoType:
        case ABCConditionCodeDecryptError:
        case ABCConditionCodeDecryptFailure:
        case ABCConditionCodeEncryptError:
        case ABCConditionCodeScryptError:
        case ABCConditionCodeSysError:
        case ABCConditionCodeNotInitialized:
        case ABCConditionCodeReinitialization:
        case ABCConditionCodeJSONError:
        case ABCConditionCodeMutexError:
        case ABCConditionCodeNoTransaction:
        case ABCConditionCodeParseError:
        case ABCConditionCodeNoRequest:
        case ABCConditionCodeNoAvailableAddress:
        default:
            return NSLocalizedString(@"An error has occurred.", nil);
    }
}

- (void)logout
{
    [self stopAsyncTasks];

    tABC_Error Error;
    tABC_CC result = ABC_ClearKeyCache(&Error);

    if (ABC_CC_Ok != result)
    {
        [Util printABC_Error:&Error];
    }
}






- (bool)PINLoginExists:(NSString *)username
{
    bool exists = NO;

    if (username && 0 < username.length)
    {
        tABC_Error error;
        ABC_PinLoginExists([username UTF8String], &exists, &error);
        [self setLastErrors:error];

    }
    return exists;
}



/////////////////////////
#pragma internal routines
/////////////////////////

- (void)postlogin:(NSString *)username password:(NSString *)password
{
    _name = username;
    _password = password;

//    NSString *username = [User Singleton].name;
//    if (username && 0 < username.length)
//    {
//        [LocalSettings controller].cachedUsername = [User Singleton].name;
//    }
//
//    [LocalSettings saveAll];

    bDataFetched = NO;
    bOtpError = NO;
    [self startPrimaryWallet];
    [self postToWatcherQueue: ^
    {
        [self postToLoadedQueue:^
        {
            [self startAsyncTasks];
        }];
    }];

    iLoginTimeSeconds = [self saveLogoutDate];
    [self loadCategories];
}



- (void)setupLoginPIN
{
    NSString *name = self.name;
    if (name && 0 < name.length)
    {
        const char *username = [name UTF8String];
        NSString *pass = [User Singleton].password;
        const char *password = (nil == pass ? NULL : [pass UTF8String]);

        // retrieve the user's settings to check whether PIN logins are disabled
        tABC_CC cc = ABC_CC_Ok;
        tABC_Error Error;
        tABC_AccountSettings *pSettings = NULL;

        cc = ABC_LoadAccountSettings(username,
                password,
                &pSettings,
                &Error);
        if (cc == ABC_CC_Ok) {
            if (!pSettings->bDisablePINLogin)
            {
                // attempt to setup the PIN package on disk
                tABC_Error error;
                tABC_CC result = ABC_PinSetup(username,
                        password,
                        &error);
                if (ABC_CC_Ok != result)
                {
                    [Util printABC_Error:&error];
                }
            }
        } else {
            [Util printABC_Error:&Error];
        }
        ABC_FreeAccountSettings(pSettings);
    }
}



- (void)logError:(const tABC_Error)error
{
    if (error.code != ABC_CC_Ok)
    {
        NSString *log;
        
        log = [NSString stringWithFormat:@"Code: %d, Desc: %s, Func: %s, File: %s, Line: %d\n",
               error.code,
               error.szDescription,
               error.szSourceFunc,
               error.szSourceFile,
               error.nSourceLine];
        ABC_Log([log UTF8String]);
    }
}

- (ABCConditionCode)setLastErrors:(tABC_Error)error;
{
    lastConditionCode = (ABCConditionCode) error.code;
    if (ABCConditionCodeOk == lastConditionCode)
    {
        lastErrorString = @"";
    }
    else
    {
        lastErrorString = [self errorMap:error];
        if (ABC_CC_Ok != error.code)
        {
            [self logError:error];
            if (error.code == ABC_CC_DecryptError
                    || error.code == ABC_CC_DecryptFailure)
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:ABC_NOTIFICATION_LOGOUT_ACCOUT object:self];
            }
        }
    }
    return lastConditionCode;
}

- (NSString *)errorMap:(tABC_Error)error;
{
    if (ABCConditionCodeInvalidPinWait == error.code)
    {
        NSString *description = [NSString stringWithUTF8String:error.szDescription];
        if ([@"0" isEqualToString:description]) {
            return NSLocalizedString(@"Invalid PIN.", nil);
        } else {
            return [NSString stringWithFormat:
                    NSLocalizedString(@"Too many failed login attempts. Please try again in %@ seconds.", nil),
                    description];
        }
    }
    else
    {
        return [self conditionCodeMap:(ABCConditionCode) error.code];
    }

}

- (void)loadSettings
{
    tABC_Error error;
    tABC_AccountSettings *pSettings = NULL;
    tABC_CC result = ABC_LoadAccountSettings([self.name UTF8String],
            [self.password UTF8String],
            &pSettings,
            &error);

    self.denomination = 100000000;
    self.denominationType = ABC_DENOMINATION_UBTC;
    self.denominationLabel = @"bits";
    self.denominationLabelShort = @"Ƀ ";

    if (ABC_CC_Ok == result)
    {
        self.minutesAutoLogout = pSettings->minutesAutoLogout;
        self.defaultCurrencyNum = pSettings->currencyNum;
        if (pSettings->bitcoinDenomination.satoshi > 0)
        {
            self.denomination = pSettings->bitcoinDenomination.satoshi;
            self.denominationType = pSettings->bitcoinDenomination.denominationType;

            switch (self.denominationType) {
                case ABC_DENOMINATION_BTC:
                    self.denominationLabel = @"BTC";
                    self.denominationLabelShort = @"Ƀ ";
                    break;
                case ABC_DENOMINATION_MBTC:
                    self.denominationLabel = @"mBTC";
                    self.denominationLabelShort = @"mɃ ";
                    break;
                case ABC_DENOMINATION_UBTC:
                    self.denominationLabel = @"bits";
                    self.denominationLabelShort = @"ƀ ";
                    break;

            }
        }
        self.firstName = pSettings->szFirstName ? [NSString stringWithUTF8String:pSettings->szFirstName] : nil;
        self.lastName = pSettings->szLastName ? [NSString stringWithUTF8String:pSettings->szLastName] : nil;
        self.nickName = pSettings->szNickname ? [NSString stringWithUTF8String:pSettings->szNickname] : nil;
        self.fullName = pSettings->szFullName ? [NSString stringWithUTF8String:pSettings->szFullName] : nil;
        self.strPIN   = pSettings->szPIN ? [NSString stringWithUTF8String:pSettings->szPIN] : nil;
        self.bNameOnPayments = pSettings->bNameOnPayments;

        self.bSpendRequirePin = pSettings->bSpendRequirePin;
        self.spendRequirePinSatoshis = pSettings->spendRequirePinSatoshis;
        self.bDisablePINLogin = pSettings->bDisablePINLogin;
    }
    else
    {
        [Util printABC_Error:&error];
    }
    ABC_FreeAccountSettings(pSettings);
}

- (void)stopAsyncTasks
{
    [self stopQueues];

    unsigned long wq, dq, gq, txq, eq, mq, lq;

    // XXX: prevents crashing on logout
    while (YES)
    {
        wq = (unsigned long)[walletsQueue operationCount];
        dq = (unsigned long)[dataQueue operationCount];
        gq = (unsigned long)[genQRQueue operationCount];
        txq = (unsigned long)[txSearchQueue operationCount];
        eq = (unsigned long)[exchangeQueue operationCount];
        mq = (unsigned long)[miscQueue operationCount];
        lq = (unsigned long)[loadedQueue operationCount];

//        if (0 == (wq + dq + gq + txq + eq + mq + lq))
        if (0 == (wq + gq + txq + eq + mq + lq))
            break;

        ABLog(0,
                @"Waiting for queues to complete wq=%lu dq=%lu gq=%lu txq=%lu eq=%lu mq=%lu lq=%lu",
                wq, dq, gq, txq, eq, mq, lq);
        [NSThread sleepForTimeInterval:.2];
    }

    [self stopWatchers];
    [self cleanWallets];
}

- (void)cleanWallets
{
    self.arrayWallets = nil;
    self.arrayArchivedWallets = nil;
    self.arrayWalletNames = nil;
    self.arrayUUIDs = nil;
    self.currentWallet = nil;
    self.currentWalletID = 0;
    self.numWalletsLoaded = 0;
    self.numTotalWallets = 0;
    self.bAllWalletsLoaded = NO;
}

- (void)refreshWallets
{
    [self refreshWallets:nil];
}



- (void)startWatchers
{
    NSMutableArray *arrayWallets = [[NSMutableArray alloc] init];
    [self loadWalletUUIDs: arrayWallets];
    for (NSString *uuid in arrayWallets) {
        [self startWatcher:uuid];
    }
    if (bDataFetched) {
        [self connectWatchers];
    }
}

- (void)connectWatchers
{
    if ([User isLoggedIn]) {
        NSMutableArray *arrayWallets = [[NSMutableArray alloc] init];
        [self loadWalletUUIDs:arrayWallets];
        for (NSString *uuid in arrayWallets)
        {
            [self connectWatcher:uuid];
        }
    }
}

- (void)connectWatcher:(NSString *)uuid
{
//    dispatch_async(dispatch_get_main_queue(),^{
    [self postToWatcherQueue: ^{
        if ([User isLoggedIn]) {
            tABC_Error Error;
            ABC_WatcherConnect([uuid UTF8String], &Error);

            [Util printABC_Error:&Error];
            [self watchAddresses:uuid];
        }
    }];
//    });
}

- (void)disconnectWatchers
{
    if ([User isLoggedIn])
    {
        NSMutableArray *arrayWallets = [[NSMutableArray alloc] init];
        [self loadWalletUUIDs: arrayWallets];
        for (NSString *uuid in arrayWallets) {
            [self postToWatcherQueue: ^{
                const char *szUUID = [uuid UTF8String];
                tABC_Error Error;
                ABC_WatcherDisconnect(szUUID, &Error);
                [Util printABC_Error:&Error];
            }];
        }
    }
}

- (void)stopWatchers
{
    NSMutableArray *arrayWallets = [[NSMutableArray alloc] init];
    [self loadWalletUUIDs: arrayWallets];
    // stop watchers
    [self postToWatcherQueue: ^{
        for (NSString *uuid in arrayWallets) {
            tABC_Error Error;
            ABC_WatcherStop([uuid UTF8String], &Error);
        }
        // wait for threads to finish
        for (NSString *uuid in arrayWallets) {
            NSOperationQueue *queue = [self watcherGet:uuid];
            if (queue == nil) {
                continue;
            }
            // Wait until operations complete
            [queue waitUntilAllOperationsAreFinished];
            // Remove the watcher from the dictionary
            [self watcherRemove:uuid];
        }
        // Destroy watchers
        for (NSString *uuid in arrayWallets) {
            tABC_Error Error;
            ABC_WatcherDelete([uuid UTF8String], &Error);
            [Util printABC_Error:&Error];
        }
    }];

    while ([watcherQueue operationCount]);
}

- (void)stopQueues
{
    if (exchangeTimer) {
        [exchangeTimer invalidate];
        exchangeTimer = nil;
    }
    if (dataSyncTimer) {
        [dataSyncTimer invalidate];
        dataSyncTimer = nil;
    }
    if (dataQueue)
        [dataQueue cancelAllOperations];
    if (walletsQueue)
        [walletsQueue cancelAllOperations];
    if (genQRQueue)
        [genQRQueue cancelAllOperations];
    if (txSearchQueue)
        [txSearchQueue cancelAllOperations];
    if (exchangeQueue)
        [exchangeQueue cancelAllOperations];
    if (miscQueue)
        [miscQueue cancelAllOperations];
    if (loadedQueue)
        [loadedQueue cancelAllOperations];

}

- (int)dataOperationCount
{
    int total = 0;
    total += dataQueue == nil     ? 0 : [dataQueue operationCount];
    total += exchangeQueue == nil ? 0 : [exchangeQueue operationCount];
    total += walletsQueue == nil  ? 0 : [walletsQueue operationCount];
    total += genQRQueue == nil  ? 0 : [genQRQueue operationCount];
    total += txSearchQueue == nil  ? 0 : [txSearchQueue operationCount];
    total += loadedQueue == nil  ? 0 : [loadedQueue operationCount];
    total += watcherQueue == nil  ? 0 : [watcherQueue operationCount];
    return total;
}

- (void)clearSyncQueue
{
    [dataQueue cancelAllOperations];
}

- (void)clearTxSearchQueue;
{
    [txSearchQueue cancelAllOperations];
}

- (void)clearMiscQueue;
{
    [miscQueue cancelAllOperations];
}













//////////////// OLD Core Bridge














@end