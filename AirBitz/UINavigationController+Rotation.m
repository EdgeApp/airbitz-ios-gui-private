//
//  UINavigationController+Rotation.m
//  AirBitz
//
//  Created by Allan Wright on 1/2/15.
//  Copyright (c) 2015 AirBitz. All rights reserved.
//

#import "UINavigationController+Rotation.h"
#import "ShowWalletQRViewController.h"

@implementation UINavigationController (Rotation)

- (BOOL)shouldAutorotate
{
    id currentViewController = self.visibleViewController;
    
    if ([currentViewController isKindOfClass:[ShowWalletQRViewController class]])
        return YES;
    
    return NO;
}

@end
