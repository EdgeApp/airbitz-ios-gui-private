//
// Created by Paul P on 1/20/16.
// Copyright (c) 2016 Airbitz. All rights reserved.
//

#import "ABC.h"
#import "ABCUser.h"
#import "AirbitzCore.h"


@implementation ABCUser
{
    AirbitzCore                     *airbitzCore;
}

- (BOOL)isLoggedIn
{
    return (0 < self.name.length);
}

- (void)login:(NSString *)name password:(NSString *)pword
{
    [self login:name password:pword setupPIN:NO];
}

- (void)login:(NSString *)name password:(NSString *)pword setupPIN:(BOOL)setupPIN
{
    self.name = name;
    self.password = pword;
    [self loadSettings];

    if (setupPIN) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
            [airbitzCore setupLoginPIN];
        });
    }
    [airbitzCore login];
}

- (id)init
{
    self = [super init];
    if(self)
    {
        [self clear];
    }
    self.denomination = 100000000;
    self.denominationType = ABC_DENOMINATION_UBTC;
    self.denominationLabel = @"bits";
    self.denominationLabelShort = @"Ƀ ";

    return self;
}



- (void)loadSettings
{
    tABC_Error error;
    tABC_AccountSettings *pSettings = NULL;
    tABC_CC result = ABC_LoadAccountSettings([self.name UTF8String],
            [self.password UTF8String],
            &pSettings,
            &error);
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

        [self loadLocalSettings:pSettings];

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


@end