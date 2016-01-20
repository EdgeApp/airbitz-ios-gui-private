//
//  CoreBridge.h
//  AirBitz
//

#import "ABC.h"
#import "Wallet.h"
#import "Transaction.h"
#import "FadingAlertView.h"
#import "Theme.h"
#import "AirbitzCore.h"

#define CONFIRMED_CONFIRMATION_COUNT 6
#define PIN_REQUIRED_PERIOD_SECONDS     120

@interface CoreBridge : AirbitzCore

- (void)initAll;
- (void)freeAll;
- (void)startQueues;
- (void)stopQueues;

- (void)clearSyncQueue;
- (void)clearTxSearchQueue;

- (int)dataOperationCount;

// New methods
- (void)refreshWallets;
- (void)rotateWalletServer:(NSString *)walletUUID refreshData:(BOOL)bData notify:(void(^)(void))cb;
- (void)reorderWallets: (NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
- (void)makeCurrentWallet:(Wallet *)wallet;
- (void)makeCurrentWalletWithIndex:(NSIndexPath *)indexPath;
- (void)makeCurrentWalletWithUUID:(NSString *)strUUID;
- (Wallet *)selectWalletWithUUID:(NSString *)strUUID;
- (long) saveLogoutDate;
- (BOOL)didLoginExpire:(NSString *)username;
- (void)addCategory:(NSString *)strCategory;
- (void)loadCategories;
- (void)saveCategories:(NSMutableArray *)saveArrayCategories;
- (void)uploadLogs:(NSString *)userText notify:(void(^)(void))cb error:(void(^)(void))cberror;
- (void)walletRemove:(NSString *)uuid notify:(void(^)(void))cb error:(void(^)(void))cberror;
- (NSArray *)getLocalAccounts:(NSString **)strError;
- (BOOL)accountExistsLocal:(NSString *)username;
- (tABC_CC)accountDeleteLocal:(NSString *)account;

- (void)updateWidgetQRCode;


- (Wallet *)getWallet: (NSString *)walletUUID;
- (Transaction *)getTransaction: (NSString *)walletUUID withTx:(NSString *) szTxId;
- (int64_t)getTotalSentToday:(Wallet *)wallet;

- (bool)setWalletAttributes: (Wallet *) wallet;

- (NSMutableArray *)searchTransactionsIn: (Wallet *) wallet query:(NSString *)term addTo:(NSMutableArray *) arrayTransactions;
- (void)storeTransaction:(Transaction *)transaction;

- (int) currencyDecimalPlaces;
- (int) maxDecimalPlaces;
- (int64_t) cleanNumString:(NSString *) value;
- (NSString *)formatCurrency:(double) currency withCurrencyNum:(int)currencyNum;
- (NSString *)formatCurrency:(double) currency withCurrencyNum:(int)currencyNum withSymbol:(bool)symbol;
- (NSString *)formatSatoshi:(int64_t) bitcoin;
- (NSString *)formatSatoshi:(int64_t) bitcoin withSymbol:(bool) symbol;
- (NSString *)formatSatoshi:(int64_t) bitcoin withSymbol:(bool) symbol cropDecimals:(int) decimals;
- (NSString *)formatSatoshi:(int64_t) bitcoin withSymbol:(bool) symbol forceDecimals:(int) forcedecimals;
- (NSString *)formatSatoshi:(int64_t) bitcoin withSymbol:(bool) symbol cropDecimals:(int) decimals forceDecimals:(int) forcedecimals;
- (int64_t) denominationToSatoshi: (NSString *) amount;
- (NSString *)conversionString: (Wallet *) wallet;
- (NSString *)conversionStringFromNum:(int) currencyNum withAbbrev:(bool) abbrev;
- (NSArray *)getRecoveryQuestionsForUserName:(NSString *)strUserName
                                   isSuccess:(BOOL *)bSuccess
                                    errorMsg:(NSMutableString *)error;
- (BOOL)recoveryAnswers:(NSString *)strAnswers areValidForUserName:(NSString *)strUserName status:(tABC_Error *)error;
- (BOOL)needsRecoveryQuestionsReminder:(Wallet *)wallet;
- (bool)PINLoginExists;
- (bool)PINLoginExists:(NSString *)username;
- (void)deletePINLogin;
- (void)setupLoginPIN;
- (void)PINLoginWithPIN:(NSString *)PIN error:(tABC_Error *)pError;
- (BOOL)recentlyLoggedIn;
- (void)login;
- (void)logout;
- (BOOL)passwordOk:(NSString *)password;
- (BOOL)passwordExists;
- (BOOL)passwordExists:(NSString *)username;
- (BOOL)allWatchersReady;
- (BOOL)watcherIsReady:(NSString *)UUID;
- (void)connectWatchers;
- (void)disconnectWatchers;
- (void)startWatchers;
- (void)startWatcher:(NSString *)walletUUID;
- (void)stopWatchers;
- (void)deleteWatcherCache;
- (void)restoreConnectivity;
- (void)lostConnectivity;
- (void)prioritizeAddress:(NSString *)address inWallet:(NSString *)walletUUID;
- (bool)isTestNet;
- (NSString *)coreVersion;
- (NSString *)currencyAbbrevLookup:(int) currencyNum;
- (NSString *)currencySymbolLookup:(int)currencyNum;
- (int)getCurrencyNumOfLocale;
- (bool)setDefaultCurrencyNum:(int)currencyNum;
- (void)setupNewAccount;
- (NSString *)sweepKey:(NSString *)privateKey intoWallet:(NSString *)walletUUID withCallback:(tABC_Sweep_Done_Callback)callback;
- (void)otpSetError:(tABC_CC)cc;
- (BOOL)otpHasError;
- (void)otpClearError;
- (NSString *) bitidParseURI:(NSString *)uri;
- (BOOL) bitidLogin:(NSString *)uri;
- (BitidSignature *) bitidSign:(NSString *)uri msg:(NSString *)msg;

void ABC_BitCoin_Event_Callback(const tABC_AsyncBitCoinInfo *pInfo);
void ABC_Sweep_Complete_Callback(tABC_CC cc, const char *szID, uint64_t amount);

@end
