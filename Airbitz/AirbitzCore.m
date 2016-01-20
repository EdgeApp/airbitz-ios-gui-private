#import "ABC.h"
#import "Wallet.h"
#import "Transaction.h"
#import "TxOutput.h"
#import "User.h"
#import "Util.h"
#import "LocalSettings.h"
#import "Keychain.h"

#import "AirbitzCore.h"
#import "AppGroupConstants.h"

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


- (ABCConditionCode)abcSignIn:(NSString *)username password:(NSString *)password otp:(NSString *)otp;
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
        }
    }

//        if (ABCConditionCodeInvalidOTP == lastConditionCode)
//            bOTPError = YES;
//
    return ccode;
}


- (ABCConditionCode)abcSignIn:(NSString *)username password:(NSString *)password otp:(NSString *)otp
        complete:(void (^)(void)) completionHandler
        error:(void (^)(ABCConditionCode ccode, NSString *errorString)) errorHandler
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        ABCConditionCode ccode = [self abcSignIn:username password:password otp:otp];
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

- (ABCConditionCode)abcSignInWithPIN:(NSString *)username pin:(NSString *)pin;
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
            [User login:username password:NULL];
        }
    }
    else
    {
        error.code = (tABC_CC) ABCConditionCodeError;
        ccode = [self setLastErrors:error];
    }
    return ccode;

}

- (ABCConditionCode)abcSignInWithPIN:(NSString *)username pin:(NSString *)pin
        complete:(void (^)(void)) completionHandler
        error:(void (^)(ABCConditionCode ccode, NSString *errorString)) errorHandler
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void)
    {
        ABCConditionCode ccode = [self abcSignInWithPIN:username pin:pin];
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


- (bool)PINLoginExists:(NSString *)username
{
    bool exists = NO;

    if (username && 0 < username.length)
    {
        tABC_Error error;
        ABC_PinLoginExists([username UTF8String], &exists, &error);
        if (ABC_CC_Ok != error.code)
        {
            [self printABC_Error:&error];
        }
        [self setLastErrors:error];

    }
    return exists;
}

#pragma internal routines

- (void)printABC_Error:(const tABC_Error *)pError
{
    if (pError)
    {
        if (pError->code != ABC_CC_Ok)
        {
            NSString *log;

            log = [NSString stringWithFormat:@"Code: %d, Desc: %s, Func: %s, File: %s, Line: %d\n",
                                             pError->code,
                                             pError->szDescription,
                                             pError->szSourceFunc,
                                             pError->szSourceFile,
                                             pError->nSourceLine];
            ABC_Log([log UTF8String]);
        }
        if (pError->code == ABC_CC_DecryptError
                || pError->code == ABC_CC_DecryptFailure)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_MAIN_RESET object:self];
        }
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



@end