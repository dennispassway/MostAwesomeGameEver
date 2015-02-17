//
//  GridController.m
//  MostAwesomeGameEver
//
//  Created by Dennis Passway on 16/02/15.
//  Copyright (c) 2015 VOF JD BV. All rights reserved.
//

#import "GridController.h"

@implementation GridController

#pragma mark Designated initializer

- (instancetype)initWithColumns:(int)numberOfColumns rows:(int)numberOfRows {
    self = [super init];
    
    if (self) {
        self.numberOfColumns = numberOfColumns;
        self.numberOfRows = numberOfRows;
    }

    return self;
}

#pragma mark Public

- (void)addItem:(id)item column:(int)columnPosition row:(int)rowPosition {
    if (![self.grid containsObject:item]) {
        [[self.grid objectAtIndex:columnPosition] insertObject:item atIndex:rowPosition];
        [self.items addObject:item];
    }
}

- (GridPositionModel *)itemPosition:(id)item {
    for (int i = 0; i < self.numberOfColumns; i++) {
        for (int j = 0; j < self.numberOfRows; j++) {
            id itemAtIndex = [[self.grid objectAtIndex:i] objectAtIndex:j];
            if ([itemAtIndex isEqual:item]) {
                return [[GridPositionModel alloc] initWithColumnIndex:i rowIndex:j];
            }
        }
    }
    
    return nil;
}

#pragma mark Private

- (void)createGrid {
    self.grid = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.numberOfColumns; i++) {
        NSMutableArray *column = [[NSMutableArray alloc] init];
        [self.grid addObject:column];
        
        for (int j = 0; j < self.numberOfRows; j++) {
            NSMutableArray *row = [[NSMutableArray alloc] init];
            [column addObject:row];
        }
    }
}

#pragma mark Getters

- (NSMutableArray *)grid {
    if (!_grid) {
        [self createGrid];
    }
    return _grid;
}

- (NSMutableArray *)items {
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    
    return _items;
}

@end
