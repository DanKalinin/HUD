//
//  HUD.m
//  Framework
//
//  Created by Dan Kalinin on 17/10/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import "HUD.h"
#import <Helpers/Helpers.h>
#import <objc/runtime.h>

static NSString *const ModeKey = @"mode";
static NSString *const ContentColorKey = @"contentColor";
static NSString *const BezelViewStyleKey = @"bezelViewStyle";
static NSString *const BezelViewBackgroundColorKey = @"bezelViewBackgroundColor";
static NSString *const OffsetKey = @"offset";










@interface HUDConfiguration ()

@property NSDictionary *dictionary;

@end



@implementation HUDConfiguration

- (instancetype)initWithName:(NSString *)name bundle:(NSBundle *)bundle {
    self = [super init];
    if (self) {
        NSString *selector = NSStringFromSelector(@selector(initWithName:bundle:));
        
        bundle = bundle ? bundle : [NSBundle mainBundle];
        NSURL *URL = [bundle URLForResource:name withExtension:PlistExtension];
        NSAssert(URL, selector);
        
        self.dictionary = [NSDictionary dictionaryWithContentsOfURL:URL];
    }
    return self;
}

- (void)configureHUD:(MBProgressHUD *)HUD {
    
    NSDictionary *dictionary = self.dictionary[@(HUD.tag).stringValue];
    if (!dictionary) return;
    
    NSNumber *number = dictionary[ModeKey];
    if (number) {
        HUD.mode = number.integerValue;
    }
    
    NSString *string = dictionary[ContentColorKey];
    if (string) {
        HUD.contentColor = [UIColor colorWithRGBAString:string];
    }
    
    number = dictionary[BezelViewStyleKey];
    if (number) {
        HUD.bezelView.style = number.integerValue;
    }
    
    string = dictionary[BezelViewBackgroundColorKey];
    if (string) {
        HUD.bezelView.backgroundColor = [UIColor colorWithRGBAString:string];
    }
    
    NSDictionary *point = dictionary[OffsetKey];
    if (point) {
        CGPoint offset;
        CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)point, &offset);
        HUD.offset = offset;
    }
}

@end










@implementation UIView (HUD)

- (MBProgressHUD *)HUD:(NSInteger)tag {
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[MBProgressHUD class]] && view.tag == tag) {
            return (MBProgressHUD *)view;
        }
    }
    
    MBProgressHUD *hud = [MBProgressHUD.alloc initWithView:self];
    hud.contentColor = UIColor.whiteColor;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.8];
    hud.tag = tag;
    [self addSubview:hud];
    
    HUDConfiguration *configuration = MBProgressHUD.configuration;
    [configuration configureHUD:hud];
    
    return hud;
}

@end










@implementation MBProgressHUD (HUD)

static HUDConfiguration *_configuration = nil;

+ (void)setConfiguration:(HUDConfiguration *)configuration {
    _configuration = configuration;
}

+ (HUDConfiguration *)configuration {
    return _configuration;
}

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
    
    hud = [self.HUDView HUD:MBProgressHUDModeIndeterminate];
    self.hudIndeterminate = hud;
    return hud;
}

- (void)setHudDeterminate:(MBProgressHUD *)hudDeterminate {
    objc_setAssociatedObject(self, @selector(hudDeterminate), hudDeterminate, OBJC_ASSOCIATION_ASSIGN);
}

- (MBProgressHUD *)hudDeterminate {
    MBProgressHUD *hud = objc_getAssociatedObject(self, @selector(hudDeterminate));
    if (hud) return hud;
    
    hud = [self.HUDView HUD:MBProgressHUDModeDeterminate];
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
    
    hud = [self.HUDView HUD:MBProgressHUDModeText];
    hud.mode = MBProgressHUDModeText;
    self.hudText = hud;
    return hud;
}

- (void)setHudIndeterminateWithButton:(MBProgressHUD *)hudIndeterminateWithButton {
    objc_setAssociatedObject(self, @selector(hudIndeterminateWithButton), hudIndeterminateWithButton, OBJC_ASSOCIATION_ASSIGN);
}

- (MBProgressHUD *)hudIndeterminateWithButton {
    MBProgressHUD *hud = objc_getAssociatedObject(self, @selector(hudIndeterminateWithButton));
    if (hud) return hud;
    
    hud = [self.HUDView HUD:-(MBProgressHUDModeIndeterminate + 1)];
    [hud.button addTarget:self action:@selector(onHudButton:) forControlEvents:UIControlEventTouchUpInside];
    self.hudIndeterminateWithButton = hud;
    return hud;
}

- (UIView *)HUDView {
    UIView *view = self.tabBarController.view;
    if (view) return view;
    
    view = self.navigationController.view;
    if (view) return view;
    
    return self.view;
}

#pragma mark - Actions

- (void)onHudButton:(UIButton *)sender {
    
}

@end
