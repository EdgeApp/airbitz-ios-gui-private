
#import "AirbitzCore.h"
#import "ABCConditionCode.h"
#import <Foundation/Foundation.h>
#import "Wallet.h"

@interface BitidSignature : NSObject
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *signature;
@end

//@interface ABCError : NSObject
///** The condition code code */
//@property (nonatomic)    ABCConditionCode code;
///** String containing a description of the error */
//@property (nonatomic, strong) NSString *strDescription;
///** String containing the function in which the error occurred */
//@property (nonatomic, strong) NSString *strSourceFunc;
///** String containing the source file in which the error occurred */
//@property (nonatomic, strong) NSString *strSourceFile;
///** Line number in the source file in which the error occurred */
//@property (nonatomic)    int sourceLine;
//
//@end


@interface AirbitzCore : NSObject
{

    NSDictionary                                    *localeAsCurrencyNum;
    long long                                       logoutTimeStamp;

    BOOL                                            bInitialized;
    BOOL                                            bDataFetched;
    long                                            iLoginTimeSeconds;
    NSOperationQueue                                *loadedQueue;
    NSOperationQueue                                *exchangeQueue;
    NSOperationQueue                                *dataQueue;
    NSOperationQueue                                *walletsQueue;
    NSOperationQueue                                *genQRQueue;
    NSOperationQueue                                *txSearchQueue;
    NSOperationQueue                                *miscQueue;
    NSOperationQueue                                *watcherQueue;
    NSLock                                          *watcherLock;
    NSMutableDictionary                             *watchers;
    NSMutableDictionary                             *currencyCodesCache;
    NSMutableDictionary                             *currencySymbolCache;

    NSTimer                                         *exchangeTimer;
    NSTimer                                         *dataSyncTimer;
    NSTimer                                         *notificationTimer;
    BOOL                                            bOtpError;
    ABCConditionCode                                lastConditionCode;
    NSString                                        *lastErrorString;
    BOOL                                            bOTPError;
    NSString                                        *otpKey;

}

@property (nonatomic, strong) NSMutableArray            *arrayWallets;
@property (nonatomic, strong) NSMutableArray            *arrayArchivedWallets;
@property (nonatomic, strong) NSMutableArray            *arrayWalletNames;
@property (nonatomic, strong) NSMutableArray            *arrayUUIDs;
@property (nonatomic, strong) Wallet                    *currentWallet;
@property (nonatomic, strong) NSArray                   *arrayCurrencyCodes;
@property (nonatomic, strong) NSArray                   *arrayCurrencyNums;
@property (nonatomic, strong) NSArray                   *arrayCurrencyStrings;
@property (nonatomic, strong) NSArray                   *arrayCategories;
@property (nonatomic)         int                       currentWalletID;
@property (nonatomic)         BOOL                      bAllWalletsLoaded;
@property (nonatomic)         int                       numWalletsLoaded;
@property (nonatomic)         int                       numTotalWallets;
@property (nonatomic)         int                       currencyCount;
@property (nonatomic)         int                       numCategories;

/*
 * abcSignIn
 * @param NSString* username: username to login
 * @param NSString* password: password of user
 * @param NSString* otp: One Time Password token (optional) send nil if logging in w/o OTP
 *
 * (Optional. If used, method returns immediately with ABCCConditionCodeOk)
 * @param completionHandler: completion handler code block
 * @param errorHandler: error handler code block which is called with the following args
 *                          @param ABCConditionCode       ccode: ABC error code
 *
 * @return ABCConditionCode
 */
- (ABCConditionCode)abcSignIn:(NSString *)username password:(NSString *)password otp:(NSString *)otp;
- (ABCConditionCode)abcSignIn:(NSString *)username password:(NSString *)password otp:(NSString *)otp
        complete:(void (^)(void)) completionHandler
           error:(void (^)(ABCConditionCode ccode, NSString *errorString)) errorHandler;

/*
 * signInWithPINAsync
 * @param NSString* username: username to login
 * @param NSString* pin: user's 4 digit PIN
 *
 * (Optional. If used, method returns immediately with ABCCConditionCodeOk)
 * @param completionHandler: completion handler code block
 * @param errorHandler: error handler code block which is called with the following args
 *                          @param ABCConditionCode       ccode: ABC error code
 * @return ABCConditionCode
 */
- (ABCConditionCode)abcSignInWithPIN:(NSString *)username pin:(NSString *)pin;
- (ABCConditionCode)abcSignInWithPIN:(NSString *)username pin:(NSString *)pin
        complete:(void (^)(void)) completionHandler
           error:(void (^)(ABCConditionCode ccode, NSString *errorString)) errorHandler;


/*
 * checkRecoveryAnswersAsync
 * @param NSString* strAnswers: concatenated string of recovery answers
 * @param NSString* username: username
 * @param completionHandler: completion handler code block which is called with the following args
 *                          @param ABCConditionCode       ccode: ABC error code
 *                          @param BOOL               bABCValid: YES if answers are correct
 *                          @param NSString         *strAnswers: NSString answers
 * @return void
 */
- (void)checkRecoveryAnswersAsync:(NSString *)username answers:(NSString *)strAnswers
        complete:(void (^)(ABCConditionCode ccode,
        BOOL bABCValid)) completionHandler;

/*
 * getRecoveryQuestionsChoicesAsync
 * @param completionHandler: completion handler code block which is called with the following args
 *                          @param ABCConditionCode ccode: ABC error code
 *                          @param NSMutableString  arrayCategoryString:  array of string based questions
 *                          @param NSMutableString  arrayCategoryNumeric: array of numeric based questions
 *                          @param NSMutableString  arrayCategoryMust:    array of questions of which one must have an answer
 * @return void
 */
-(void)getRecoveryQuestionsChoicesAsync:(void (^)(ABCConditionCode ccode,
        NSMutableArray *arrayCategoryString,
        NSMutableArray *arrayCategoryNumeric,
        NSMutableArray *arrayCategoryMust)) completionHandler;


/*
 * errorMap
 * @param  ABCConditionCode: error code to look up
 * @return NSString*       : text description of error
 */
- (NSString *)conditionCodeMap:(const ABCConditionCode) code;


/*
 * getLocalAccounts
 * @param  NSArray**       : array of strings of account names
 * @return ABCConditionCode: error code to look up
 */
- (ABCConditionCode)getLocalAccounts:(NSArray **) arrayAccounts;

/*
 * uploadLogsAsync
 * @param NSString* username: username
 * @param completionHandler: completion handler code block which is called with the following args
 *                          @param ABCConditionCode       ccode: ABC error code
 * @return void
 */
- (void)uploadLogsAsync:(NSString *)username complete:(void (^)(ABCConditionCode ccode)) completionHandler;


- (ABCConditionCode) getLastConditionCode;
- (NSString *) getLastErrorString;

////////////////////////////////////////////////////
// Old routines that shouldn't be exported to App //
////////////////////////////////////////////////////

- (void)postToSyncQueue:(void(^)(void))cb;
- (void)postToLoadedQueue:(void(^)(void))cb;
- (void)postToWalletsQueue:(void(^)(void))cb;
- (void)postToGenQRQueue:(void(^)(void))cb;
- (void)postToTxSearchQueue:(void(^)(void))cb;
- (void)postToMiscQueue:(void(^)(void))cb;
- (void)postToWatcherQueue:(void(^)(void))cb;




@end