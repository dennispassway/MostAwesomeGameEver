//
//  Colors.m
//  MostAwesomeGameEver
//
//  Created by Johan Haneveld on 22/02/15.
//  Copyright (c) 2015 VOF JD BV. All rights reserved.
//

#import "Colors.h"

@implementation Colors

+ (UIColor *)grey {
    static UIColor *color = nil;
    if (!color) color = [UIColor colorWithRed:0.827 green:0.843 blue:0.855 alpha:1];
    return color;
}

+ (UIColor *)hotPink {
    static UIColor *color = nil;
    if (!color) color = [UIColor colorWithRed:0.969 green:0.314 blue:0.455 alpha:1];
    return color;
}

+ (UIColor *)nightBlue {
    static UIColor *color = nil;
    if (!color) color = [UIColor colorWithRed:0.259 green:0.353 blue:0.412 alpha:1];
    return color;
}

+ (UIColor *)turqoise {
    static UIColor *color = nil;
    if (!color) color = [UIColor colorWithRed:0.4 green:0.8 blue:0.831 alpha:1];
    return color;
}

@end