//
//  AirbitzViewController.h
//  Airbitz
//
//  Created by Paul Puey 2015/05/19.
//  Copyright (c) 2014 AirBitz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AB.h"

@protocol AirbitzViewControllerDelegate;

@interface AirbitzViewController : UIViewController

@property (assign)            id<AirbitzViewControllerDelegate> delegate;
@property (nonatomic, strong) NSLayoutConstraint * leftConstraint;

- (void)closeViewController;
- (void)airbitzViewControllerUpdateNavBar;

@end

@protocol AirbitzViewControllerDelegate <NSObject>

@required

- (void)airbitzViewControllerDidFinish:(AirbitzViewController *)avc;
- (void)airbitzViewControllerUpdateNavBar;

@end
