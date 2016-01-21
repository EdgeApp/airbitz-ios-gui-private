//
//  User.h
//  AirBitz
//
//  Created by Carson Whitsett on 3/27/14.
//  Copyright (c) 2014 AirBitz. All rights reserved.
//
//  master user object that other modules can access in order to get userName and password

#import <Foundation/Foundation.h>
#import "CommonTypes.h"
#import "ABC.h"
#import "AppDelegate.h"
#import "ABCUser.h"


@interface User : ABCUser

@property (nonatomic) NSUInteger sendInvalidEntryCount;
@property (nonatomic) NSUInteger sendState;
@property (nonatomic) NSRunLoop *runLoop;
@property (nonatomic) NSTimer *sendInvalidEntryTimer;
@property (nonatomic) bool reviewNotified;
@property (nonatomic) bool bDisclaimerViewed;
@property (nonatomic) NSDate *firstLoginTime;
@property (nonatomic) NSInteger loginCount;
@property (nonatomic) NSInteger pinLoginCount;
@property (nonatomic) BOOL needsPasswordCheck;
@property (nonatomic, assign) NSInteger requestViewCount;
@property (nonatomic, assign) NSInteger sendViewCount;
@property (nonatomic, assign) NSInteger bleViewCount;
@property (nonatomic, assign) NSInteger walletsViewCount;
@property (nonatomic) BOOL notifiedSend;
@property (nonatomic) BOOL notifiedRequest;
@property (nonatomic) BOOL notifiedBle;
@property (nonatomic) BOOL notifiedWallet;

+ (void)initAll;
+ (void)freeAll;
+ (User *)Singleton;
+ (BOOL)offerUserReview;

- (BOOL)offerRequestHelp;
- (BOOL)offerSendHelp;
- (BOOL)offerBleHelp;
- (BOOL)offerWalletHelp;
- (BOOL)offerDisclaimer;

- (void)saveLocalSettings;
- (SendViewState)sendInvalidEntry;
- (void)startInvalidEntryWait;
- (void)endInvalidEntryWait;
- (NSTimeInterval)getRemainingInvalidEntryWait;
- (void)incPINorTouchIDLogin;
- (void)loadLocalSettings:(tABC_AccountSettings *)pSettings;
- (void)saveDisclaimerViewed;


@end
