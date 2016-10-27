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

- (IBAction)onIndeterminate:(UIButton *)sender {
    [self.hudIndeterminate showAnimated:YES forTime:2.0];
}

- (IBAction)onDeterminate:(UIButton *)sender {
    self.hudDeterminate.progress = 0.5;
    [self.hudDeterminate showAnimated:YES forTime:2.0];
}

- (IBAction)onText:(UIButton *)sender {
    self.hudText.detailsLabel.text = @"Hello world";
    [self.hudText showAnimated:YES forTime:2.0];
}

@end
