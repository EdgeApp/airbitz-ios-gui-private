//
// Created by Paul P on 1/20/16.
// Copyright (c) 2016 Airbitz. All rights reserved.
//

#import "ABC.h"
#import "ABCUser.h"
#import "AirbitzCore.h"


@interface ABCUser()
{

}

@end

@implementation ABCUser



- (void)login:(NSString *)name password:(NSString *)pword
{
    self.name = name;
    self.password = pword;
    [self loadSettings];
}

- (id)init
{
    self = [super init];
    if(self)
    {
        [self clear];
    }

    return self;
}



@end