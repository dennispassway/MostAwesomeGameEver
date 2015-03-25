//
//  DiamondView.m
//  MostAwesomeGameEver
//
//  Created by Dennis Passway on 16/02/15.
//  Copyright (c) 2015 VOF JD BV. All rights reserved.
//

#import "DiamondView.h"
#import "Colors.h"

@implementation DiamondView

#pragma mark Initializer

- (instancetype)init {
    CGRect diamondFrame = CGRectMake(0, 0, self.size, self.size);
    
    self = [super initWithFrame:diamondFrame];
    
    if (self) {
        self.alpha = 1;
        self.colorId = arc4random() % 4;
        self.backgroundColor = [self color];
        self.bounds = CGRectInset(diamondFrame, self.size / 4, self.size / 4);
        self.layer.cornerRadius = self.size;
    }
    
    return self;
}

#pragma mark Public Class methods

static float diamondViewSize;
+ (void)setDiamondViewSize:(float)size {
    diamondViewSize = size;
}

#pragma mark Private methods

- (UIColor *)color {
    switch (self.colorId) {
        case 0:
            return [Colors grey];
        case 1:
            return [Colors hotPink];
        case 2:
            return [Colors nightBlue];
        default:
            return [Colors turqoise];
    }
}

#pragma mark Properties

- (float)size {
    if (!_size) {
        if (diamondViewSize) {
            _size = diamondViewSize;
        } else {
            _size = 100.0;
        }
    }
    
    return _size;
}

@end
