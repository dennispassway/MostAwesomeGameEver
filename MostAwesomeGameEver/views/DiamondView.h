//
//  DiamondView.h
//  MostAwesomeGameEver
//
//  Created by Dennis Passway on 16/02/15.
//  Copyright (c) 2015 VOF JD BV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiamondView : UIView

#pragma mark Properties

@property (nonatomic) int colorId;
@property (nonatomic) float size;

+ (void)setDiamondViewSize:(float)size;

@end
