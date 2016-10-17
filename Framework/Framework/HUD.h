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










@interface UIView (HUD)

- (MBProgressHUD *)HUD:(NSInteger)tag;

@end










@interface MBProgressHUD (HUD)

- (void)showAnimated:(BOOL)animated forTime:(NSTimeInterval)time;

@end
