//
//  GridController.h
//  MostAwesomeGameEver
//
//  Created by Dennis Passway on 16/02/15.
//  Copyright (c) 2015 VOF JD BV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GridPositionModel.h"

@interface GridController : NSObject

#pragma mark Designated initializer

- (instancetype)initWithColumns:(int)numberOfColumns rows:(int)numberOfRows;

#pragma mark Grid

@property (strong, nonatomic) NSMutableArray *grid;
@property (nonatomic) int numberOfColumns;
@property (nonatomic) int numberOfRows;
@property (nonatomic) int numberOfCells;

# pragma mark Items

@property (strong, nonatomic) NSMutableArray *items;

- (void)addItem:(id)item column:(int)columnPosition row:(int)rowPosition;
- (void)removeItemAtPosition:(GridPositionModel *)position;
- (GridPositionModel *)itemPosition:(id)item;
- (id)itemAtPosition:(GridPositionModel *)position;

@end