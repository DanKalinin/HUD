//
//  HUD.m
//  Framework
//
//  Created by Dan Kalinin on 17/10/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import "HUD.h"
#import <objc/runtime.h>










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










@implementation UIViewController (HUD)

- (void)setHudIndeterminate:(MBProgressHUD *)hudIndeterminate {
    objc_setAssociatedObject(self, @selector(hudIndeterminate), hudIndeterminate, OBJC_ASSOCIATION_ASSIGN);
}

- (MBProgressHUD *)hudIndeterminate {
    MBProgressHUD *hud = objc_getAssociatedObject(self, @selector(hudIndeterminate));
    if (hud) return hud;
    
    hud = [self.navigationController.view HUD:MBProgressHUDModeIndeterminate];
    self.hudIndeterminate = hud;
    return hud;
}

- (void)setHudDeterminate:(MBProgressHUD *)hudDeterminate {
    objc_setAssociatedObject(self, @selector(hudDeterminate), hudDeterminate, OBJC_ASSOCIATION_ASSIGN);
}

- (MBProgressHUD *)hudDeterminate {
    MBProgressHUD *hud = objc_getAssociatedObject(self, @selector(hudDeterminate));
    if (hud) return hud;
    
    hud = [self.navigationController.view HUD:MBProgressHUDModeDeterminate];
    hud.mode = MBProgressHUDModeDeterminate;
    self.hudDeterminate = hud;
    return hud;
}

- (void)setHudText:(MBProgressHUD *)hudText {
    objc_setAssociatedObject(self, @selector(hudText), hudText, OBJC_ASSOCIATION_ASSIGN);
}

- (MBProgressHUD *)hudText {
    MBProgressHUD *hud = objc_getAssociatedObject(self, @selector(hudText));
    if (hud) return hud;
    
    hud = [self.navigationController.view HUD:MBProgressHUDModeText];
    hud.mode = MBProgressHUDModeText;
    hud.offset = CGPointMake(0.0, -MBProgressMaxOffset);
    self.hudText = hud;
    return hud;
}

@end
