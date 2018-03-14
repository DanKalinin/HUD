//
//  HUD.h
//  Framework
//
//  Created by Dan Kalinin on 17/10/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT double HUDVersionNumber;
FOUNDATION_EXPORT const unsigned char HUDVersionString[];

#import <HUD/MBProgressHUD.h>










@interface HUDConfiguration : NSObject

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle;

@end










@interface HUDController : NSObject

- (instancetype)initWithProgressHUD:(MBProgressHUD *)progressHUD errorHUD:(MBProgressHUD *)errorHUD;
- (void)completeWithError:(NSError *)error;

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
