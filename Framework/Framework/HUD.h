//
//  HUD.h
//  Framework
//
//  Created by Dan Kalinin on 17/10/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <HUD/MBProgressHUD.h>

FOUNDATION_EXPORT double HUDVersionNumber;
FOUNDATION_EXPORT const unsigned char HUDVersionString[];










@interface HUDConfiguration : NSObject

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle;

@end










@interface UIView (HUD)

- (MBProgressHUD *)HUD:(NSInteger)tag;

@end










@interface MBProgressHUD (HUD)

@property (class) HUDConfiguration *configuration;

- (void)showAnimated:(BOOL)animated forTime:(NSTimeInterval)time;

@end










@interface UIViewController (HUD)

@property (readonly) MBProgressHUD *hudIndeterminate;
@property (readonly) MBProgressHUD *hudDeterminate;
@property (readonly) MBProgressHUD *hudText;

@property (readonly) MBProgressHUD *hudIndeterminateWithButton;

- (void)onHudButton:(UIButton *)sender;

@end
