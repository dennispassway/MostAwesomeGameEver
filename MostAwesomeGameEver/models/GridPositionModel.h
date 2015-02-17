//
//  GridPositionModel.h
//  MostAwesomeGameEver
//
//  Created by Dennis Passway on 16/02/15.
//  Copyright (c) 2015 VOF JD BV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GridPositionModel : NSObject

#pragma mark Designated initializer

- (instancetype)initWithColumnIndex:(int)columnIndex rowIndex:(int)rowIndex;

#pragma mark Properties

@property (nonatomic) int rowIndex;
@property (nonatomic) int columnIndex;

@end
