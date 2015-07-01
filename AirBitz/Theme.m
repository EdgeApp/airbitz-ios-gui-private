//
//  Theme.m
//  AirBitz
//
//  Created by Paul Puey on 5/2/15.
//  Copyright (c) 2015 AirBitz. All rights reserved.
//

#import "Theme.h"
#import "Util.h"
#import <sys/sysctl.h>

static BOOL bInitialized = NO;

@implementation Theme

static Theme *singleton = nil;  // this will be the one and only object this static singleton class has

+ (void)initAll
{
    if (NO == bInitialized)
    {
        singleton = [[Theme alloc] init];
        bInitialized = YES;
    }
}

+ (void)freeAll
{
    if (YES == bInitialized)
    {
        // release our singleton
        singleton = nil;
        
        bInitialized = NO;
    }
}

+ (Theme *)Singleton
{
    return singleton;
}

- (id)init
{
    self = [super init];

    //    self.denomination = 100000000;
    self.colorTextBright = [UIColor whiteColor];
    self.colorTextDark = UIColorFromARGB(0xff0C578C);;
    self.colorTextLink = UIColorFromARGB(0xFF007aFF);
    self.deleteAccountWarning     = NSLocalizedString(@"Delete '%@' on this device? This will disable access via PIN. If 2FA is enabled on this account, this device will not be able to login without a 2FA reset which takes 7 days.", @"Delete Account Warning");
    self.colorSendButton = UIColorFromARGB(0xFF80c342);
    self.colorRequestButton = UIColorFromARGB(0xff2291cf);

    self.colorRequestButtonDisabled = UIColorFromARGB(0x5580c342);
    self.colorSendButtonDisabled = UIColorFromARGB(0x55006698);

    self.colorRequestTopTextField = self.colorTextBright;
    self.colorRequestTopTextFieldPlaceholder = UIColorFromARGB(0xffdddddd);
    self.colorRequestBottomTextField = self.colorTextDark;

    self.colorButtonGreen = UIColorFromARGB(0xff80C342);

    self.appFont = @"Lato-Regular";

    self.backButtonText                                    = NSLocalizedString(@"Back", @"Back button text on top left");
    self.exitButtonText                                    = NSLocalizedString(@"Exit", @"Exit button text on top left");
    self.helpButtonText                                    = NSLocalizedString(@"Help", @"Help button text on top right");
    self.infoButtonText                                    = NSLocalizedString(@"Info", @"Info button text on top right");
    self.doneButtonText                                    = NSLocalizedString(@"Done", @"Generic DONE button text");
    self.cancelButtonText                                  = NSLocalizedString(@"CANCEL", @"Generic CANCEL button text");
    self.exportButtonText                                  = NSLocalizedString(@"Export", @"EXPORT button text for wallet export");
    self.renameButtonText                                  = NSLocalizedString(@"Rename", @"RENAME button text for wallet rename");
    self.walletBalanceHeaderText                           = NSLocalizedString(@"TOTAL: ", @"Prefix of wallet balance dropdown header");
    self.walletNameHeaderText                              = NSLocalizedString(@"Wallet: ", @"Prefix of wallet name on rename popup");
    self.renameWalletWarningText                           = NSLocalizedString(@"Wallet name must have at least one character", nil);
    self.transactionCellNoTransactionsText                 = NSLocalizedString(@"No Transactions", @"what to display when wallet has no transactions");
    self.transactionCellNoTransactionsFoundText            = NSLocalizedString(@"No Transactions Found", @"what to display when no transactions are found in search");
    self.fiatText = NSLocalizedString(@"Fiat", @"Fiat");
    self.walletHeaderButtonHelpText                        = NSLocalizedString(@"To sort wallets, tap and drag the 3 bars to the right of a wallet. Drag below the [ARCHIVE] header to archive the wallet", @"Popup wallet help test");
    self.walletHasBeenArchivedText                          = NSLocalizedString(@"This wallet has been archived. Please select a different wallet from the [Wallets] tab below", @"Popup sessage for when a wallet is archived");
    self.walletsPopupHelpText = NSLocalizedString(@"Tap and hold a wallet for additional options", nil);
    self.selectWalletTransferPopupHeaderText                = NSLocalizedString(@"↓ Choose a wallet to transfer funds to ↓", @"Header of popup in SendView from wallet to wallet transfer");
    self.invalidAddressPopupText                            = NSLocalizedString(@"Invalid Bitcoin Address", nil);
    self.enterBitcoinAddressPopupText                       = NSLocalizedString(@"Send to Bitcoin Address", nil);
    self.enterBitcoinAddressPlaceholder                     = NSLocalizedString(@"Bitcoin Address or URI", nil);
    self.enterPrivateKeyPopupText                           = NSLocalizedString(@"Sweep Funds From Private Key", nil);
    self.enterPrivateKeyPlaceholder                         = NSLocalizedString(@"Bitcoin Private Key", nil);
    self.smsText                                            = NSLocalizedString(@"SMS", @"text for textmessage/SMS");
    self.emailText                                          = NSLocalizedString(@"Email", @"text for Email");
    self.sendScreenHelpText                                 = NSLocalizedString(@"Scan the QR code of payee to send payment or tap on a bluetooth request from the list below", nil);
    self.creatingWalletText                                 = NSLocalizedString(@"Creating and securing wallet", nil);
    self.createAccountAndTransferFundsText                  = NSLocalizedString(@"Please create a new account and transfer your funds if you forgot your password.", nil);
    self.createPasswordForAccountText                       = NSLocalizedString(@"Please create a password for this account or you will not be able to recover your account if your device is lost or stolen.", nil);
    self.settingsText                                       = NSLocalizedString(@"Settings", nil);
    self.categoriesText                                     = NSLocalizedString(@"Categories", nil);
    self.signupText                                         = NSLocalizedString(@"Sign Up", nil);
    self.changePasswordText                                 = NSLocalizedString(@"Change Password", nil);
    self.changePINText                                      = NSLocalizedString(@"Change PIN", nil);
    self.twoFactorText                                      = NSLocalizedString(@"Two Factor", nil);
    self.importText                                         = NSLocalizedString(@"Import", nil);
    self.passwordRecoveryText                               = NSLocalizedString(@"Password Recovery", nil);
    self.debugOptionsHeaderText                             = NSLocalizedString(@"Debug Options", @"Debug screen header title");
    self.PrevButtonText                                     = NSLocalizedString(@"Prev", nil);
    self.NextButtonText                                     = NSLocalizedString(@"Next", nil);
    self.locationAlert                                      = NSLocalizedString(@"Your location services are not currently enabled. Therefore, this application will not be able to calculate distances. If you would like this feature, please go to the device settings under \"General / Location Services\" and enable it.",nil);
    self.LocationWarningTitle                               = NSLocalizedString(@"Location Warning", nil);
    self.OkCancelButtonTitle                                = NSLocalizedString(@"OK", nil);
    self.LocationNSMutalableString                          = NSLocalizedString(@"The application is having difficulty obtaining your location. Please try again later.", nil);
    self.changeNavBarTitle                                  = NSLocalizedString(@"More Categories", @"");
    self.LevelcategoryKey                                   = NSLocalizedString(@"level", nil);
    self.categoryCellText                                   = NSLocalizedString(@"categoryCell", nil);
    self.resultscategoryText                                = NSLocalizedString(@"results", nil);
    self.presentAddAnimationText                            = NSLocalizedString(@"present", nil);
    self.presentingAddAnimationText                         = NSLocalizedString(@"presenting", nil);
    self.dismissAnimationText                               = NSLocalizedString(@"dismiss", nil);
    self.typeAutocomplete                                   = NSLocalizedString(@"type", nil);
    self.businessAutocomplete                               = NSLocalizedString(@"business", nil);
    self.DebugLogFileText                                   = NSLocalizedString(@"Debug Log File", nil);
    self.UploadSucceededText                                = NSLocalizedString(@"Upload Succeeded", nil);
    self.UploadFailedText                                   = NSLocalizedString(@"Upload Failed. Please check your network connection or contact support@airbitz.co", nil);
    self.RestartingWatcherServiceText                       = NSLocalizedString(@"Restarting watcher service", nil);
    self.PleaseWaitProgressAlertText                        = NSLocalizedString(@"Please wait...", nil);
    self.FakeNetworkLabelText                               = NSLocalizedString(@"Fake", nil);
    self.TestnetNetworkLabelText                            = NSLocalizedString(@"Testnet", nil);
    self.MainnetNetworkLabelText                            = NSLocalizedString(@"Mainnet", nil);
    self.FadingAlertViewNewText                             = NSLocalizedString(@"FadingAlertViewNew", nil);
    self.DropDownAlertView                                  = NSLocalizedString(@"DropDownAlertView", nil);
    self.UploadedFromAirBitzText                            = NSLocalizedString(@"Uploaded from AirBitz", nil);
    self.UploadingToGoogleDrive                             = NSLocalizedString(@"Uploading to Google Drive", nil);
    self.YesDescriptionText                                 = NSLocalizedString(@"YES", nil);
    self.NoDescriptionText                                  = NSLocalizedString(@"NO", nil);
    self.HtmlFrame                                          = NSLocalizedString(@"html", nil);
    self.LargeDigitInput                                    = NSLocalizedString(@"large-digit-input", nil);
    self.LargeDigitInputSelected                            = NSLocalizedString(@"large-digit-input_selected", nil);
    self.UsernameSelectorText                               = NSLocalizedString(@"Username", @"Username");
    self.PleaseEnteraUsernameText                           = NSLocalizedString(@"Please enter a User Name", nil);
    self.IncorrectPINText                                   = NSLocalizedString(@"Incorrect PIN", nil);
    self.IncorrectPINAbortText                               = NSLocalizedString(@"Incorrect PIN. Please log in.", nil);
    self.DeleteAccountText                                  = NSLocalizedString(@"Delete Account", nil);
    self.TimeToCrackPassword                                = NSLocalizedString(@"Time to crack:", @"text in password verification popup");
    self.WarningInitWithTitle                               = NSLocalizedString(@"Warning!", nil);
    self.MessagePasswordRecoveryExit                        = NSLocalizedString(@"You are about to exit password recovery and questions & answers have not yet been set.", nil);
    self.SkipThisStepTitle                                  = NSLocalizedString(@"Skip this step", @"Title of Skip this step alert");
    self.SkipThisStepMessage                                = NSLocalizedString(@"**WARNING** You will NEVER be able to recover your password if it is forgotten!!",nil);
    self.GoBackSkipThisStep                                 = NSLocalizedString(@"Go Back", nil);
    self.AlertMessageToAnswerAllQuestions                   = NSLocalizedString(@"You must answer all six questions. Make sure your answers are long enough.", nil);
    self.AlertMessageToChooseAllQuestionsProcedding         = NSLocalizedString(@"You must choose all six questions before proceeding.", nil);
    self.CompleteSignupText                                 = NSLocalizedString(@"Complete Signup", nil);
    self.PasswordRecoverySetupText                          = NSLocalizedString(@"Password Recovery Setup", nil);
    self.WrongAnswersCheckRecoveryResponse                  = NSLocalizedString(@"Wrong Answers", nil);
    self.GivenAnswersIncorrectCheckRecoveryResponse         = NSLocalizedString(@"The given answers were incorrect. Please try again.", nil);
    self.UnableToImportTokenTitle                           = NSLocalizedString(@"Unable to import token", nil);
    self.UnableToImportTokenMessage                         = NSLocalizedString(@"We are sorry we are unable to import the token at this time.", nil);
    self.PasswordMismatchTitle                              = NSLocalizedString(@"Password mismatch", nil);
    self.PasswordMismatchMessage                            = NSLocalizedString(@"Please enter your correct password.", nil);
    self.QuestionKey                                        = NSLocalizedString(@"Question", nil);
    self.MustQuestionChoicesText                            = NSLocalizedString(@"must", nil);
    self.NumericQuestionChoicesText                         = NSLocalizedString(@"numeric", nil);
    self.StringQuestionChoicesText                          = NSLocalizedString(@"string", nil);
    self.MinLengthQuestionChoicesText                       = NSLocalizedString(@"minLength", nil);
    self.RecoverCompleteTitle                               = NSLocalizedString(@"Recovery Questions Set", @"Title of recovery questions setup complete alert");
    self.RecoverCompleteMessage                             = NSLocalizedString(@"Your password recovery questions and answers are now set up.  When recovering your password, your answers must match exactly. **DO NOT FORGET YOUR PASSWORD AND RECOVERY ANSWERS** YOUR ACCOUNT CANNOT BE RECOVERED WITHOUT THEM!!",nil);
    self.SettingRecoveryFailed                              = NSLocalizedString(@"Setting recovery questions failed:\n%@", nil);
    self.RecoveryQuestionsNotSet                            = NSLocalizedString(@"Recovery Questions Not Set", @"Title of recovery questions setup error alert");
    self.NameCategoryButtonText                             = NSLocalizedString(@"Name", nil);
    self.LevelcategoryKey                                   = NSLocalizedString(@"Level", nil);
    self.PinSuccessfullyChangedText                         = NSLocalizedString(@"PIN successfully changed.", @"");
    self.UsernameLabelText                                  = NSLocalizedString(@"User Name: %@", nil);
    self.NewPasswordTextField                               = NSLocalizedString(@"New Password", @"");
    self.ReEnterNewPasswordTextField                        = NSLocalizedString(@"Re-enter New Password", @"");
    self.CurrentPasswordTextField                           = NSLocalizedString(@"Current Password", @"");
    self.NewPinTextField                                    = NSLocalizedString(@"New PIN", @"");
    self.FailedText                                         = NSLocalizedString(@"%@ failed:\n%@", nil);
    self.IncorrectCurrentPassword                           = NSLocalizedString(@"Incorrect current password", @"");
    self.InsufficientPasswordText                           = NSLocalizedString(@"Insufficient Password", @"Title of password check popup alert");
    self.PasswordDoesNotMatchText                           = NSLocalizedString(@"Password does not match re-entered password", @"");
    self.UsernameAlertTextField                             = NSLocalizedString(@"Username must be at least %d characters.", @"");
    self.PINMustBeAlertText                                 = NSLocalizedString(@"PIN must be 4 digits", @"");
    self.PasswordSuccessfullyChangedText                    = NSLocalizedString(@"Password successfully changed. DO NOT FORGET YOUR PASSWORD OR RECOVERY ANSWERS! THEY CANNOT BE RECOVERED!", @"");
    self.SignUpFailedText                                   = NSLocalizedString(@"Sign Up failed:\n%@", nil);
    self.PasswordChangeFailed                               = NSLocalizedString(@"Password change failed:\n%@", nil);
    self.RememberYourPasswordTitle                          = NSLocalizedString(@"Remember your password?", nil);
    self.RememberYourPasswordMessage                        = NSLocalizedString(@"Do you still remember your password? You will need your password if your device gets lost or if your PIN is incorrectly entered 3 times.\nEnter it below to make sure:", nil);
    self.LaterText                                         = NSLocalizedString(@"Later", nil);
    self.CheckPasswordText                                 = NSLocalizedString(@"Check Password", nil);
    self.NoPasswordSetText                                 = NSLocalizedString(@"No password set", nil);
    self.SkipText                                          = NSLocalizedString(@"Skip", nil);
    self.ChangeText                                        = NSLocalizedString(@"CHANGE", nil);
    self.GreatJobRememberingText                           = NSLocalizedString(@"Great job remembering your password.", nil);
    self.IncorrectPasswordText                             = NSLocalizedString(@"Incorrect Password", nil);
    self.IncorrectPasswordTryAgain                         = NSLocalizedString(@"Incorrect Password. Try again, or change it now?", nil);
    self.AirbitzCheckUserReview                            = NSLocalizedString(@"Airbitz", nil);
    self.MessageCheckUserReview                            = NSLocalizedString(@"How are you liking Airbitz?", nil);
    self.CheckUserReviewCancelButtonTitle                  = NSLocalizedString(@"Not so good", nil);
    self.CheckUserReviewOtherButtonTitle                   = NSLocalizedString(@"It's great", nil);
    self.ReceivedFundsAlert                                = NSLocalizedString(@"Received Funds", nil);
    self.BitcoinReceivedAlert                              = NSLocalizedString(@"Bitcoin received. Tap for details.", nil);
    self.SendFundsAlert                                    = NSLocalizedString(@"Send Funds", nil);
    self.BitcoinSentAlertMessage                           = NSLocalizedString(@"Bitcoin sent. Tap for details.", nil);
    self.UserReviewNoAlertMessage                          = NSLocalizedString(@"Would you like to send us some feedback?", nil);
    self.NoThanksUserReview                                = NSLocalizedString(@"No Thanks", nil);
    self.WriteUserReviewAppStore                           = NSLocalizedString(@"Would you like to write a review in the App store?", nil);
    self.CheckingPasswordText                              = NSLocalizedString(@"Checking password...", nil);
    self.CantSendemailText                                 = NSLocalizedString(@"Can't send e-mail", nil);
    self.EmailCancelledText                                = NSLocalizedString(@"Email cancelled", nil);
    self.EmailSavedToLaterText                             = NSLocalizedString(@"Email saved to send later", nil);
    self.EmailSentText                                     = NSLocalizedString(@"Email Sent", nil);
    self.ErrorSendingEmailText                             = NSLocalizedString(@"Error sending Email", nil);
    self.PasswordChangeText                                = NSLocalizedString(@"Password Changed", nil);
    self.PasswordChangeAlertMessage                        = NSLocalizedString(@"The password to this account was changed by another device. Please login using the new credentials.", nil);
    self.AirbitzFeedback                                   = NSLocalizedString(@"Airbitz Feedback", nil);
    self.YouReceivedBitcoinText                            = NSLocalizedString(@"You received Bitcoin!\n%@ (~%@)\nUse the Payee, Category, and Notes field to optionally tag your transaction", nil);
    self.YouReceivedBitcoinReceivedCount                   = NSLocalizedString(@"You Received Bitcoin!\n%@ (~%@)", nil);
    self.SendSupportEmail                                  = NSLocalizedString(@"support@airbitz.co", nil);
    self.TwoFactorAuthenticationText                       = NSLocalizedString(@"Two Factor Authentication On", nil);
    self.TwoFactorAuthenticationMessage                    = NSLocalizedString(@"Two Factor Authentication (enchanced security) has been enabled from a different device for this account. Please enable 2 Factor Authentication for full access from this device.", nil);
    self.RemindMeLaterText                                 = NSLocalizedString(@"Remind Me Later", nil);
    self.EnableText                                        = NSLocalizedString(@"Enable", nil);
    self.TwoFactorsInvalidText                             = NSLocalizedString(@"Two Factor Invalid", nil);
    self.TwoFactorsInvalidMessage                          = NSLocalizedString(@"The Two Factor Authentication token on this device is invalid. Either the token was changed by a different device our your clock is skewed. Please check your system time to ensure it is correct.", nil);
    self.MustBeImportText                                  = NSLocalizedString(@"Must be import", nil);
    self.MustBeSendText                                    = NSLocalizedString(@"Must be Send", nil);
    self.TodayText                                         = NSLocalizedString(@"Today", nil);
    self.YesterdayText                                     = NSLocalizedString(@"Yesterday", nil);
    self.DaysAgoText                                       = NSLocalizedString(@"%ld days ago", nil);
    self.RequestaBitcoinAddressText                        = NSLocalizedString(@"%@ has requested a bitcoin address to send money to.", nil);
    self.AppRequestedBitcoinAddress                        = NSLocalizedString(@"An app has requested a bitcoin address to send money to.", nil);
    self.ChooseWallettoReceiveFundsText                    = NSLocalizedString(@" Please choose a wallet to receive funds.", nil);
    self.PresentQRcodeText                                 = NSLocalizedString(@"Present QR code to Sender and have them scan to send you payment",nil);
    self.CopiedToTheClipboard                              = NSLocalizedString(@"Request is copied to the clipboard", nil);
    self.WaitingForPaymentText                             = NSLocalizedString(@"Waiting for Payment...", @"Status on Request screen");
    self.RequestedText                                     = NSLocalizedString(@"Requested...", @"Requested string on Request screen");
    self.RemainingText                                     = NSLocalizedString(@"Remaining...", @"Remaining string on Request screen");
    self.ReceivedText                                      = NSLocalizedString(@"Receiving...", @"Remaining string on Request screen");
    self.PartialPaymentText                                = NSLocalizedString(@"Partial Payment", @"Text on partial payment");
    self.ConnectedText                                     = NSLocalizedString(@"Connected", "Popup text when BLE connects");
    self.PaymentReceivedText                               = NSLocalizedString(@"Payment received", @"Text on payment recived popup");
    self.HardwareNotSupportedText                          = NSLocalizedString(@"Your hardware doesn't support Bluetooth LE sharing.", nil);
    self.NotAuthorizedToUseBluetoothText                   = NSLocalizedString(@"This app is not authorized to use Bluetooth. You can change this in the Settings app.", nil);
    self.BluetoothPoweredOffText                           = NSLocalizedString(@"Bluetooth is currently powered off.", nil);
    self.BluetoothCurrentlyResettingText                   = NSLocalizedString( @"Bluetooth is currently resetting.", nil);
    self.SMSCancelledText                                  = NSLocalizedString(@"SMS cancelled", nil);
    self.ErrorSendingSMSText                               = NSLocalizedString(@"Error sending SMS", nil);
    self.SMSSentText                                       = NSLocalizedString(@"SMS sent", nil);
    self.EmailRecipientText                                = NSLocalizedString(@"Email Recipient", nil);
    self.SMSRecipientText                                  = NSLocalizedString( @"SMS Recipient", nil);
    self.SendingStatusMessageText                          = NSLocalizedString( @"Sending...", @"status message");
    self.PasswordLabelPINTitle                             = NSLocalizedString(@"Password", nil);
    self.PINLabelTitle                                     = NSLocalizedString(@"PIN", nil);

    self.DigitPIN                                          = NSLocalizedString(@"4 Digit PIN", nil);
    self.EnterAmountContinueChecksText                     = NSLocalizedString(@"Please enter an amount to send", nil);
    self.AmountTooSmallAlert                               = NSLocalizedString(@"Amount is too small", nil);
    self.ErrorSendFailedText                               = NSLocalizedString(@"Error during send", nil);
    self.IncorrectEntryPINWaitText                         = NSLocalizedString(@"Incorrect PIN. Please wait %.0f seconds and try again.", nil);
    self.PleaseEnterYourPInText                            = NSLocalizedString(@"Please enter your PIN", nil);
    self.PleaseWaitAlertdelayedText                        = NSLocalizedString(@"Please wait 1 second before retrying %@", nil);
    self.PleaseWaitMoreSomeTimeText                        = NSLocalizedString(@"Please wait %.0f seconds before retrying %@", nil);
    self.CameraUnavailableText                             = NSLocalizedString(@"Camera unavailable. Please enable camera access on your phone's Privacy Settings", @"");
    self.BitcoinAddressMismatchText                        = NSLocalizedString(@"Bitcoin address mismatch", nil);
    self.BitcoinAddressMismatchMessage                     = NSLocalizedString(@"The bitcoin address of the device you connected with:%@ does not match the address that was initially advertised:%@", nil);
    self.InvalidBluetoothRequestText                       = NSLocalizedString(@"Invalid Bluetooth Request", nil);
    self.RequestorContactSupportText                       = NSLocalizedString(@"Please have Requestor contact support", nil);
    self.InvalidPrivateKeyText                             = NSLocalizedString(@"Invalid private key", nil);







    
    
    
    
    

    self.sendRequestButtonDisabled = 0.4f;

    self.animationDurationTimeDefault           = 0.35;     // How long the animation transition should take
    self.animationDelayTimeDefault              = 0.0;      // Delay until animation starts. Should always be zero
    self.animationCurveDefault                  = UIViewAnimationOptionCurveEaseOut;

    self.alertHoldTimeDefault                   = 4.0;      // How long to hold the alert before going away
    self.alertFadeoutTimeDefault                = 2.0;      // How much time it takes to animate the fade away
    self.alertHoldTimePaymentReceived           = 10;       // Hold time for payments
    self.alertHoldTimeHelpPopups                = 6.0;      // Hold time for auto popup help


    self.backgroundApp = [UIImage imageNamed:@"postcard-mountain-blue.jpg"];
    self.backgroundLogin = [UIImage imageNamed:@"postcard-mountain.png"];

//    if (IS_IPHONE4)
    {
        self.heightListings = 90.0;
        self.heightLoginScreenLogo = 70;
        self.heightWalletHeader = 44.0;
        self.heightSearchClues = 35.0;
        self.fadingAlertDropdownHeight = 80;
        self.heightBLETableCells = 50;
        self.heightWalletCell = 60;
        self.heightTransactionCell = 72;
        self.heightPopupPicker = 50;
        self.heightMinimumForQRScanFrame = 200;
        self.elementPadding = 5; // Generic padding between elements
        self.heightSettingsTableCell            = 40.0;
        self.heightSettingsTableHeader          = 60.0;
        self.heightButton                       = 45.0;
    }
    if (IS_MIN_IPHONE5)
    {
        self.heightListings = 110.0;
        self.heightLoginScreenLogo = 100;
        self.heightWalletHeader = 50.0;
        self.heightSearchClues = 40.0;
        self.heightBLETableCells = 55;
        self.heightPopupPicker = 55;
    }
    if (IS_MIN_IPHONE6)
    {
        self.heightSearchClues = 45.0;
        self.heightLoginScreenLogo = 120;
        self.heightBLETableCells = 65;
        self.heightPopupPicker = 60;
        self.heightSettingsTableCell            = 45.0;
        self.heightSettingsTableHeader          = 65.0;
    }
    if (IS_MIN_IPHONE6_PLUS)
    {
        self.heightWalletHeader = 55.0;
        self.heightListings = 130.0;
        self.heightSearchClues = 45.0;
        self.heightBLETableCells = 70;
        self.heightPopupPicker = 65;
    }
    if (IS_MIN_IPAD_MINI)
    {
        self.heightBLETableCells = 75;
    }

    NSLog(@"***Device Type: %@ %@", [self platform], [self platformString]);

    NSString *devtype = [self platform];


    if (0 ||
            [devtype hasPrefix:@"iPod"] ||
            [devtype hasPrefix:@"iPhone4"] ||
            [devtype hasPrefix:@"iPhone5"] ||
            [devtype hasPrefix:@"iPad1"] ||
            [devtype hasPrefix:@"iPad2"]
            )
    {
        self.bTranslucencyEnable = NO;
    }
    else
    {
        self.bTranslucencyEnable = YES;
    }
    return self;
}

- (NSString *)platform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);

    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];

    free(machine);

    return platform;
}

- (NSString *)platformString
{
    NSString *platform = [self platform];

    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (GSM)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (GSM)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (GSM)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (GSM+CDMA)";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad mini 2G (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad mini 2G (Cellular)";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";

    return platform;
}

@end
