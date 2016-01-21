//
// Created by Paul P on 1/20/16.
// Copyright (c) 2016 Airbitz. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ABCUser : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *password;

// User Settings
@property (nonatomic) int minutesAutoLogout;
@property (nonatomic) int defaultCurrencyNum;
@property (nonatomic) int64_t denomination;
@property (nonatomic, copy) NSString* denominationLabel;
@property (nonatomic) int denominationType;
@property (nonatomic, copy) NSString* firstName;
@property (nonatomic, copy) NSString* lastName;
@property (nonatomic, copy) NSString* nickName;
@property (nonatomic, copy) NSString* fullName;
@property (nonatomic, copy) NSString* strPIN;
@property (nonatomic) bool bNameOnPayments;
@property (nonatomic, copy) NSString* denominationLabelShort;
@property (nonatomic) bool bDailySpendLimit;
@property (nonatomic) int64_t dailySpendLimitSatoshis;
@property (nonatomic) bool bSpendRequirePin;
@property (nonatomic) int64_t spendRequirePinSatoshis;
@property (nonatomic) bool bDisablePINLogin;

- (BOOL)isLoggedIn;
- (void)login:(NSString *)user password:(NSString *)pword;
- (void)login:(NSString *)user password:(NSString *)pword setupPIN:(BOOL)setupPIN;
- (id)init;
- (void)clear;
- (void)loadSettings;

@end