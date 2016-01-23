//
// Created by Paul P on 1/20/16.
// Copyright (c) 2016 Airbitz. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ABCUser : NSObject

@property (nonatomic, strong) AirbitzCore                     *airbitzCore;


- (void)login:(NSString *)user password:(NSString *)pword;
- (void)login:(NSString *)user password:(NSString *)pword setupPIN:(BOOL)setupPIN;
- (id)init;
- (void)clear;
- (void)loadSettings;

@end