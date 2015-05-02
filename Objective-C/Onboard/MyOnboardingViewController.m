//
//  MyOnboardingViewController.m
//  Onboard
//
//  Created by Mike on 2/11/15.
//  Copyright (c) 2015 Mike Amaral. All rights reserved.
//

#import "MyOnboardingViewController.h"
#import "MBProgressHUD.h"

@interface MyOnboardingViewController () {
    dispatch_block_t _handler;
}

@end

@implementation MyOnboardingViewController

- (instancetype)initWithCompletionHandler:(dispatch_block_t)completionHandler {
    self = [super initWithBackgroundImage:nil contents:nil];
    
    if (!self) {
        return nil;
    }
    
    _handler = completionHandler;
    
    self.iconSize = 160;
    self.fontName = @"HelveticaNeue-Thin";
    self.shouldMaskBackground = NO;
    self.shouldBlurBackground = YES;
    self.backgroundImage = [UIImage imageNamed:@"purple"];
    
    __weak typeof(self) weakSelf = self;
    
    NSString *page1Title = @"Pacenotes";
    NSString *page1Body = @"Driver-specific alerts for safer trips ahead of schedule.";
    UIImage *page1Image = [UIImage imageNamed:@"layers"];
    NSString *page1ButtonTxt = @"Demo Async";
    OnboardingContentViewController *firstPage = [[OnboardingContentViewController alloc] initWithTitle:page1Title body:page1Body image:page1Image buttonText:page1ButtonTxt action:^{
        [weakSelf doSomethingWithCompletionHandler:^{
            [weakSelf moveNextPage];
        }];
    }];
    
    OnboardingContentViewController *secondPage = [[OnboardingContentViewController alloc] initWithTitle:@"Safer travels" body:@"Avoid dangerous weather conditions on the road." image:[UIImage imageNamed:@"cone"] buttonText:nil action:nil];
    
    OnboardingContentViewController *thirdPage = [[OnboardingContentViewController alloc] initWithTitle:@"Efficient trips" body:@"Know live traffic patterns before they throw you off." image:[UIImage imageNamed:@"coffee"] buttonText:@"Get Started" action:completionHandler];
    
    self.viewControllers = @[firstPage, secondPage, thirdPage,];
    
    return self;
}

- (void)doSomethingWithCompletionHandler:(dispatch_block_t)handler {
    // Lets just do something that resembles an async request...
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [hud hide:YES];
        handler();
    });
}

@end
