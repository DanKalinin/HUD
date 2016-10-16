//
//  ViewController.m
//  App
//
//  Created by Dan Kalinin on 17/10/16.
//  Copyright © 2016 Dan Kalinin. All rights reserved.
//

#import "ViewController.h"
#import <HUD/HUD.h>



@interface ViewController ()

@end



@implementation ViewController

- (IBAction)onShow:(UIButton *)sender {
    [[self.view HUD:0] showAnimated:YES];
    [[self.view HUD:0] hideAnimated:YES afterDelay:3.0];
}

@end
