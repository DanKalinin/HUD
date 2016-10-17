//
//  HUD.m
//  Framework
//
//  Created by Dan Kalinin on 17/10/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import "HUD.h"










@implementation UIView (HUD)

- (MBProgressHUD *)HUD:(NSInteger)tag {
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[MBProgressHUD class]] && view.tag == tag) {
            return (MBProgressHUD *)view;
        }
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    hud.tag = tag;
    [self addSubview:hud];
    return hud;
}

@end










@implementation MBProgressHUD (HUD)

- (void)showAnimated:(BOOL)animated forTime:(NSTimeInterval)time {
    [self showAnimated:animated];
    [self hideAnimated:animated afterDelay:time];
}

@end
