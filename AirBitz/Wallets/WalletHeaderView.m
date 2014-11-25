//
//  WalletHeaderView.m
//  AirBitz
//
//  Created by Carson Whitsett on 6/2/14.
//  Copyright (c) 2014 AirBitz. All rights reserved.
//

#import "WalletHeaderView.h"

@interface WalletHeaderView ()
{
    BOOL headerCollapsed;
}

@end

@implementation WalletHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(WalletHeaderView *)CreateWithTitle:(NSString *)title collapse:(BOOL)bCollapsed
{
    WalletHeaderView *whv = nil;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        whv = [[[NSBundle mainBundle] loadNibNamed:@"WalletHeaderView~iphone" owner:nil options:nil] objectAtIndex:0];
    }
    /*else
     {
     av = [[[NSBundle mainBundle] loadNibNamed:@"HowToPlayView~ipad" owner:nil options:nil] objectAtIndex:0];
     
     }*/
    whv.layer.cornerRadius = 4.0;
    whv.titleLabel.text = title;
    whv->headerCollapsed = bCollapsed;
    if (whv->headerCollapsed)
    {
        whv.btn_expandCollapse.transform = CGAffineTransformRotate(whv.btn_expandCollapse.transform, M_PI);
    }
    return whv;
}

- (IBAction)ExpandCollapse
{
    if(headerCollapsed)
    {
        headerCollapsed = NO;
        [UIView animateWithDuration:0.35
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^
         {
             self.btn_expandCollapse.transform = CGAffineTransformRotate(self.btn_expandCollapse.transform, M_PI);
         }
                         completion:^(BOOL finished)
         {
             
             [self.delegate walletHeaderView:self Expanded:YES];
         }];
    }
    else
    {
        headerCollapsed = YES;
        [UIView animateWithDuration:0.35
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^
         {
             self.btn_expandCollapse.transform = CGAffineTransformRotate(self.btn_expandCollapse.transform, -M_PI);
         }
                         completion:^(BOOL finished)
         {
             [self.delegate walletHeaderView:self Expanded:NO];
         }];
    }
}

- (IBAction)addWallet
{
    [self.delegate addWallet];
}

@end
