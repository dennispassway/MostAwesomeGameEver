//
//  DiamondView.m
//  MostAwesomeGameEver
//
//  Created by Dennis Passway on 16/02/15.
//  Copyright (c) 2015 VOF JD BV. All rights reserved.
//

#import "DiamondView.h"

@implementation DiamondView

#pragma mark Initializer

- (instancetype)init {
    CGRect diamondFrame = CGRectMake(0, 0, self.size, self.size);
    
    self = [super initWithFrame:diamondFrame];
    
    if (self) {
        self.backgroundColor = [self randomColor];
        self.bounds = CGRectInset(diamondFrame, self.size / 4, self.size / 4);
        self.layer.cornerRadius = self.size;
    }
    
    return self;
}

#pragma mark Private methods

- (UIColor *)randomColor {
    switch (arc4random() % 4) {
        case 0:
            return [UIColor colorWithRed:0.827 green:0.843 blue:0.855 alpha:1];
        case 1:
            return [UIColor colorWithRed:0.969 green:0.314 blue:0.455 alpha:1];
        case 2:
            return [UIColor colorWithRed:0.259 green:0.353 blue:0.412 alpha:1];
        case 3:
            return [UIColor colorWithRed:0.4 green:0.8 blue:0.831 alpha:1];
    }

    return [UIColor colorWithRed:0.827 green:0.843 blue:0.855 alpha:1];
}

#pragma mark Getters

- (float)size {
    if (!_size) {
        _size = 100.0;
    }
    return _size;
}

@end
