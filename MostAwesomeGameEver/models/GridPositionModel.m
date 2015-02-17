//
//  GridPositionModel.m
//  MostAwesomeGameEver
//
//  Created by Dennis Passway on 16/02/15.
//  Copyright (c) 2015 VOF JD BV. All rights reserved.
//

#import "GridPositionModel.h"

@implementation GridPositionModel

#pragma mark Designated initializer

- (instancetype)initWithColumnIndex:(int)columnIndex rowIndex:(int)rowIndex  {
    self = [super init];
    
    if (self) {
        self.columnIndex = columnIndex;
        self.rowIndex = rowIndex;
    }
    
    return self;
}

@end
