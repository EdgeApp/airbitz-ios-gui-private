//
//  Theme.h
//  
//
//  Created by Paul Puey on 5/2/15.
//
//

#import <Foundation/Foundation.h>
#import "CommonTypes.h"

@interface Theme : NSObject

//@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *password;

// User Settings
@property (nonatomic) UIColor *colorTextLink;
@property (nonatomic) UIColor *colorSendButton;
@property (nonatomic) UIColor *colorRequestButton;
@property (nonatomic) UIColor *colorSendButtonDisabled;
@property (nonatomic) UIColor *colorRequestButtonDisabled;
@property (nonatomic) CGFloat sendRequestButtonDisabled;
@property (nonatomic) UIColor *colorTextBright;
@property (nonatomic) UIColor *colorTextDark;
@property (nonatomic) UIColor *colorRequestTopTextField;
@property (nonatomic) UIColor *colorRequestTopTextFieldPlaceholder;
@property (nonatomic) UIColor *colorRequestBottomTextField;
@property (nonatomic) UIColor *colorButtonGreen;

@property (nonatomic) BOOL    bTranslucencyEnable;

@property (nonatomic) NSString *appFont;
@property (nonatomic) NSString *backButtonText;
@property (nonatomic) NSString *exitButtonText;
@property (nonatomic) NSString *helpButtonText;
@property (nonatomic) NSString *infoButtonText;
@property (nonatomic) NSString *doneButtonText;
@property (nonatomic) NSString *cancelButtonText;
@property (nonatomic) NSString *exportButtonText;
@property (nonatomic) NSString *renameButtonText;
@property (nonatomic) NSString *deleteAccountWarning;
@property (nonatomic) NSString *renameWalletWarningText;
@property (nonatomic) NSString *walletBalanceHeaderText;
@property (nonatomic) NSString *walletNameHeaderText;
@property (nonatomic) NSString *transactionCellNoTransactionsText;
@property (nonatomic) NSString *transactionCellNoTransactionsFoundText;
@property (nonatomic) NSString *walletHeaderButtonHelpText;
@property (nonatomic) NSString *walletHasBeenArchivedText;
@property (nonatomic) NSString *fiatText;
@property (nonatomic) NSString *walletsPopupHelpText;
@property (nonatomic) NSString *selectWalletTransferPopupHeaderText;
@property (nonatomic) NSString *invalidAddressPopupText;
@property (nonatomic) NSString *enterBitcoinAddressPopupText;
@property (nonatomic) NSString *enterBitcoinAddressPlaceholder;
@property (nonatomic) NSString *enterPrivateKeyPopupText;
@property (nonatomic) NSString *enterPrivateKeyPlaceholder;
@property (nonatomic) NSString *smsText;
@property (nonatomic) NSString *emailText;
@property (nonatomic) NSString *sendScreenHelpText;
@property (nonatomic) NSString *creatingWalletText;
@property (nonatomic) NSString *createAccountAndTransferFundsText;
@property (nonatomic) NSString *createPasswordForAccountText;
@property (nonatomic) NSString *settingsText;
@property (nonatomic) NSString *categoriesText;
@property (nonatomic) NSString *signupText;
@property (nonatomic) NSString *changePasswordText;
@property (nonatomic) NSString *changePINText;
@property (nonatomic) NSString *twoFactorText;
@property (nonatomic) NSString *importText;
@property (nonatomic) NSString *passwordRecoveryText;
@property (nonatomic) NSString *debugOptionsHeaderText;
@property (nonatomic) NSString *PrevButtonText;
@property (nonatomic) NSString *NextButtonText;
@property (nonatomic) NSString *locationAlert;
@property (nonatomic) NSString *LocationWarningTitle;
@property (nonatomic) NSString *OkCancelButtonTitle;
@property (nonatomic) NSString *LocationNSMutalableString;
@property (nonatomic) NSString *addressLocationDict;
@property (nonatomic) NSString *changeNavBarTitle;
@property (nonatomic) NSString *LevelcategoryKey;
@property (nonatomic) NSString *categoryCellText;
@property (nonatomic) NSString *resultscategoryText;
@property (nonatomic) NSString *presentAddAnimationText;
@property (nonatomic) NSString *presentingAddAnimationText;
@property (nonatomic) NSString *dismissAnimationText;
@property (nonatomic) NSString *typeAutocomplete;
@property (nonatomic) NSString *businessAutocomplete;
@property (nonatomic) NSString *DebugLogFileText;
@property (nonatomic) NSString *UploadSucceededText;
@property (nonatomic) NSString *UploadFailedText;
@property (nonatomic) NSString *RestartingWatcherServiceText;
@property (nonatomic) NSString *PleaseWaitProgressAlertText;
@property (nonatomic) NSString *FakeNetworkLabelText;
@property (nonatomic) NSString *TestnetNetworkLabelText;
@property (nonatomic) NSString *MainnetNetworkLabelText;
@property (nonatomic) NSString *FadingAlertViewNewText;
@property (nonatomic) NSString *DropDownAlertView;
@property (nonatomic) NSString *UploadedFromAirBitzText;
@property (nonatomic) NSString *UploadingToGoogleDrive;
@property (nonatomic) NSString *YesDescriptionText;
@property (nonatomic) NSString *NoDescriptionText;
@property (nonatomic) NSString *HtmlFrame;
@property (nonatomic) NSString *LargeDigitInput;
@property (nonatomic) NSString *LargeDigitInputSelected;
@property (nonatomic) NSString *UsernameSelectorText;
@property (nonatomic) NSString *PleaseEnteraUsernameText;
@property (nonatomic) NSString *IncorrectPINText;
@property (nonatomic) NSString *IncorrectPINAbortText;
@property (nonatomic) NSString *DeleteAccountText;
@property (nonatomic) NSString *TimeToCrackPassword;
@property (nonatomic) NSString *WarningInitWithTitle;
@property (nonatomic) NSString *MessagePasswordRecoveryExit;
@property (nonatomic) NSString *SkipThisStepTitle;
@property (nonatomic) NSString *SkipThisStepMessage;
@property (nonatomic) NSString *GoBackSkipThisStep;
@property (nonatomic) NSString *AlertMessageToAnswerAllQuestions;
@property (nonatomic) NSString *AlertMessageToChooseAllQuestionsProcedding;
@property (nonatomic) NSString *CompleteSignupText;
@property (nonatomic) NSString *PasswordRecoverySetupText;
@property (nonatomic) NSString *WrongAnswersCheckRecoveryResponse;
@property (nonatomic) NSString *GivenAnswersIncorrectCheckRecoveryResponse;
@property (nonatomic) NSString *UnableToImportTokenTitle;
@property (nonatomic) NSString *UnableToImportTokenMessage;
@property (nonatomic) NSString *PasswordMismatchTitle;
@property (nonatomic) NSString *PasswordMismatchMessage;
@property (nonatomic) NSString *QuestionKey;
@property (nonatomic) NSString *MustQuestionChoicesText;
@property (nonatomic) NSString *NumericQuestionChoicesText;
@property (nonatomic) NSString *StringQuestionChoicesText;
@property (nonatomic) NSString *MinLengthQuestionChoicesText;
@property (nonatomic) NSString *RecoverCompleteTitle;
@property (nonatomic) NSString *RecoverCompleteMessage;
@property (nonatomic) NSString *SettingRecoveryFailed;
@property (nonatomic) NSString *RecoveryQuestionsNotSet;
@property (nonatomic) NSString *NameCategoryButtonText;
@property (nonatomic) NSString *LevelCategoryText;
@property (nonatomic) NSString *PinSuccessfullyChangedText;
@property (nonatomic) NSString *UsernameLabelText;
@property (nonatomic) NSString *NewPasswordTextField;
@property (nonatomic) NSString *ReEnterNewPasswordTextField;
@property (nonatomic) NSString *CurrentPasswordTextField;
@property (nonatomic) NSString *NewPinTextField;
@property (nonatomic) NSString *FailedText;
@property (nonatomic) NSString *IncorrectCurrentPassword;
@property (nonatomic) NSString *InsufficientPasswordText;
@property (nonatomic) NSString *PasswordDoesNotMatchText;
@property (nonatomic) NSString *UsernameAlertTextField;
@property (nonatomic) NSString *PINMustBeAlertText;
@property (nonatomic) NSString *PasswordSuccessfullyChangedText;
@property (nonatomic) NSString *AccountSignUpText;
@property (nonatomic) NSString *SignUpFailedText;
@property (nonatomic) NSString *PasswordChangeFailed;
@property (nonatomic) NSString *RememberYourPasswordTitle;
@property (nonatomic) NSString *RememberYourPasswordMessage;
@property (nonatomic) NSString *LaterText;
@property (nonatomic) NSString *CheckPasswordText;
@property (nonatomic) NSString *NoPasswordSetText;
@property (nonatomic) NSString *SkipText;
@property (nonatomic) NSString *ChangeText;
@property (nonatomic) NSString *GreatJobRememberingText;
@property (nonatomic) NSString *IncorrectPasswordText;
@property (nonatomic) NSString *IncorrectPasswordTryAgain;
@property (nonatomic) NSString *AirbitzCheckUserReview;
@property (nonatomic) NSString *MessageCheckUserReview;
@property (nonatomic) NSString *CheckUserReviewCancelButtonTitle;
@property (nonatomic) NSString *CheckUserReviewOtherButtonTitle;
@property (nonatomic) NSString *ReceivedFundsAlert;
@property (nonatomic) NSString *BitcoinReceivedAlert;
@property (nonatomic) NSString *SendFundsAlert;
@property (nonatomic) NSString *BitcoinSentAlertMessage;
@property (nonatomic) NSString *UserReviewNoAlertMessage;
@property (nonatomic) NSString *NoThanksUserReview;
@property (nonatomic) NSString *WriteUserReviewAppStore;
@property (nonatomic) NSString *CheckingPasswordText;
@property (nonatomic) NSString *CantSendemailText;
@property (nonatomic) NSString *EmailCancelledText;
@property (nonatomic) NSString *EmailSavedToLaterText;
@property (nonatomic) NSString *EmailSentText;
@property (nonatomic) NSString *ErrorSendingEmailText;
@property (nonatomic) NSString *PasswordChangeText;
@property (nonatomic) NSString *PasswordChangeAlertMessage;
@property (nonatomic) NSString *AirbitzFeedback;
@property (nonatomic) NSString *YouReceivedBitcoinText;
@property (nonatomic) NSString *YouReceivedBitcoinReceivedCount;
@property (nonatomic) NSString *SendSupportEmail;
@property (nonatomic) NSString *TwoFactorAuthenticationText;
@property (nonatomic) NSString *TwoFactorAuthenticationMessage;
@property (nonatomic) NSString *RemindMeLaterText;
@property (nonatomic) NSString *EnableText;
@property (nonatomic) NSString *TwoFactorsInvalidText;
@property (nonatomic) NSString *TwoFactorsInvalidMessage;
@property (nonatomic) NSString *MustBeImportText;
@property (nonatomic) NSString *MustBeSendText;
@property (nonatomic) NSString *TodayText;
@property (nonatomic) NSString *YesterdayText;
@property (nonatomic) NSString *DaysAgoText;
@property (nonatomic) NSString *RequestaBitcoinAddressText;
@property (nonatomic) NSString *AppRequestedBitcoinAddress;
@property (nonatomic) NSString *ChooseWallettoReceiveFundsText;
@property (nonatomic) NSString *PresentQRcodeText;
@property (nonatomic) NSString *CopiedToTheClipboard;
@property (nonatomic) NSString *WaitingForPaymentText;
@property (nonatomic) NSString *RequestedText;
@property (nonatomic) NSString *RemainingText;
@property (nonatomic) NSString *ReceivedText;
@property (nonatomic) NSString *PartialPaymentText;
@property (nonatomic) NSString *ConnectedText;
@property (nonatomic) NSString *PaymentReceivedText;
@property (nonatomic) NSString *HardwareNotSupportedText;
@property (nonatomic) NSString *NotAuthorizedToUseBluetoothText;
@property (nonatomic) NSString *BluetoothPoweredOffText;
@property (nonatomic) NSString *BluetoothCurrentlyResettingText;
@property (nonatomic) NSString *SMSCancelledText;
@property (nonatomic) NSString *ErrorSendingSMSText;
@property (nonatomic) NSString *SMSSentText;
@property (nonatomic) NSString *RequestedViaText;
@property (nonatomic) NSString *EmailRecipientText;
@property (nonatomic) NSString *SMSRecipientText;
@property (nonatomic) NSString *SendingStatusMessageText;
@property (nonatomic) NSString *PasswordLabelPINTitle;
@property (nonatomic) NSString *PINLabelTitle;
@property (nonatomic) NSString *DigitPIN;
@property (nonatomic) NSString *EnterAmountContinueChecksText;
@property (nonatomic) NSString *AmountTooSmallAlert;
@property (nonatomic) NSString *ErrorSendFailedText;
@property (nonatomic) NSString *IncorrectEntryPINWaitText;
@property (nonatomic) NSString *PleaseEnterYourPInText;
@property (nonatomic) NSString *PleaseWaitAlertdelayedText;
@property (nonatomic) NSString *PleaseWaitMoreSomeTimeText;
@property (nonatomic) NSString *CameraUnavailableText;
@property (nonatomic) NSString *BitcoinAddressMismatchText;
@property (nonatomic) NSString *BitcoinAddressMismatchMessage;
@property (nonatomic) NSString *InvalidBluetoothRequestText;
@property (nonatomic) NSString *RequestorContactSupportText;
@property (nonatomic) NSString *InvalidPrivateKeyText;









































@property (nonatomic) CGFloat fadingAlertDropdownHeight;
@property (nonatomic) CGFloat elementPadding;
@property (nonatomic) CGFloat heightListings;
@property (nonatomic) CGFloat heightLoginScreenLogo;
@property (nonatomic) CGFloat heightSearchClues;
@property (nonatomic) CGFloat heightBLETableCells;
@property (nonatomic) UIImage *backgroundLogin;
@property (nonatomic) UIImage *backgroundApp;
@property (nonatomic) CGFloat heightWalletHeader;
@property (nonatomic) CGFloat heightWalletCell;
@property (nonatomic) CGFloat heightTransactionCell;
@property (nonatomic) CGFloat heightPopupPicker;
@property (nonatomic) CGFloat heightMinimumForQRScanFrame;
@property (nonatomic) CGFloat heightSettingsTableCell;
@property (nonatomic) CGFloat heightSettingsTableHeader;
@property (nonatomic) CGFloat heightButton;


@property (nonatomic) CGFloat animationDelayTimeDefault;
@property (nonatomic) CGFloat animationDurationTimeDefault;
@property (nonatomic) UIViewAnimationOptions animationCurveDefault;
@property (nonatomic) CGFloat alertHoldTimeDefault;
@property (nonatomic) CGFloat alertFadeoutTimeDefault;
@property (nonatomic) CGFloat alertHoldTimePaymentReceived;
@property (nonatomic) CGFloat alertHoldTimeHelpPopups;

//@property (nonatomic) int minutesAutoLogout;
//@property (nonatomic) int defaultCurrencyNum;
//@property (nonatomic) int64_t denomination;
//@property (nonatomic, copy) NSString* denominationLabel;
//@property (nonatomic) int denominationType;
//@property (nonatomic, copy) NSString* firstName;
//@property (nonatomic, copy) NSString* lastName;
//@property (nonatomic, copy) NSString* nickName;
//@property (nonatomic, copy) NSString* fullName;
//@property (nonatomic) bool bNameOnPayments;
//@property (nonatomic, copy) NSString* denominationLabelShort;
//@property (nonatomic) bool bDailySpendLimit;
//@property (nonatomic) int64_t dailySpendLimitSatoshis;
//@property (nonatomic) bool bSpendRequirePin;
//@property (nonatomic) int64_t spendRequirePinSatoshis;
//@property (nonatomic) bool bDisablePINLogin;
//@property (nonatomic) NSUInteger sendInvalidEntryCount;
//@property (nonatomic) NSUInteger sendState;
//@property (nonatomic) NSRunLoop *runLoop;
//@property (nonatomic) NSTimer *sendInvalidEntryTimer;
//@property (nonatomic) NSUInteger PINLoginInvalidEntryCount;
//@property (nonatomic) bool reviewNotified;
//@property (nonatomic) NSDate *firstLoginTime;
//@property (nonatomic) NSInteger loginCount;
//@property (nonatomic) NSInteger pinLoginCount;
//@property (nonatomic) BOOL needsPasswordCheck;
//@property (nonatomic, assign) NSInteger requestViewCount;
//@property (nonatomic, assign) NSInteger sendViewCount;
//@property (nonatomic, assign) NSInteger bleViewCount;
//@property (nonatomic) BOOL notifiedSend;
//@property (nonatomic) BOOL notifiedRequest;
//@property (nonatomic) BOOL notifiedBle;

+ (void)initAll;
+ (void)freeAll;
+ (Theme *)Singleton;
- (id)init;

@end
