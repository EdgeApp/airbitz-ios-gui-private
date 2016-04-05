//
//  AirbitzViewController.h
//  Airbitz
//
//  Created by Paul Puey 2015/05/19.
//  Copyright (c) 2014 AirBitz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "AirbitzViewController.h"

@interface AirbitzViewController ()
{

}

@end

@implementation AirbitzViewController

- (void)airbitzViewControllerUpdateNavBar;
{
    
}

- (void)closeViewController;
{
    [MainViewController animateOut:self withBlur:NO complete:^(void) {
        if (self.delegate)
        {
            if([self.delegate respondsToSelector:@selector(airbitzViewControllerUpdateNavBar)])
                [self.delegate airbitzViewControllerUpdateNavBar];
            if([self.delegate respondsToSelector:@selector(airbitzViewControllerDidFinish:)])
                [self.delegate airbitzViewControllerDidFinish:self];
        }
        
    }];
}




@end
