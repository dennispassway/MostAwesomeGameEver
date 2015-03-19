//
//  AnimationController.m
//  MostAwesomeGameEver
//
//  Created by Dennis Passway on 18/03/15.
//  Copyright (c) 2015 VOF JD BV. All rights reserved.
//

#import "AnimationController.h"

@implementation AnimationController

+ (void)fadeOut:(UIView *)view onComplete:(void (^)(BOOL finished))block {
    
    [UIView animateWithDuration:0.5 animations:^(void){
        view.alpha = 0;
    } completion:block];
    
}

@end
