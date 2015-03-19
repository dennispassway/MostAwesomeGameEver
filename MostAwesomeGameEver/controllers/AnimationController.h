//
//  AnimationController.h
//  MostAwesomeGameEver
//
//  Created by Dennis Passway on 18/03/15.
//  Copyright (c) 2015 VOF JD BV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationController : NSObject

+ (void)fadeOut:(UIView *)view onComplete:(void (^)(BOOL finished))block;

@end
