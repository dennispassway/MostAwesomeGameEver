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

#pragma mark Public Methods

- (void)addItem:(id)item atPosition:(GridPositionModel *)position {
    if (![self containsItem:item]) {
        NSMutableArray *row = [self.grid objectAtIndex:position.columnIndex];
        [row replaceObjectAtIndex:position.rowIndex withObject:item];
    }
}

- (void)removeItemAtPosition:(GridPositionModel *)position {
    NSObject *placeholder = [[NSObject alloc] init];
    [self addItem:placeholder atPosition:position];
}

- (GridPositionModel *)positionOfItem:(id)item {
    for (int columnIndex = 0; columnIndex < self.numberOfColumns; columnIndex++) {
        for (int rowIndex = 0; rowIndex < self.numberOfRows; rowIndex++) {
            id itemAtIndex = [[self.grid objectAtIndex:columnIndex] objectAtIndex:rowIndex];
            if ([itemAtIndex isEqual:item]) {
                return [[GridPositionModel alloc] initWithColumnIndex:columnIndex rowIndex:rowIndex];
            }
        }
    }
    
    return nil;
}

- (id)itemAtPosition:(GridPositionModel *)position {
    return [[self.grid objectAtIndex:position.columnIndex] objectAtIndex:position.rowIndex];
}

- (BOOL)containsItem:(id)item {
    for (int columnIndex = 0; columnIndex < self.numberOfColumns; columnIndex++) {
        for (int rowIndex = 0; rowIndex < self.numberOfRows; rowIndex++) {
            id itemAtIndex = [[self.grid objectAtIndex:columnIndex] objectAtIndex:rowIndex];
            if ([itemAtIndex isEqual:item]) {
                return YES;
            }
        }
    }
    
    return NO;
}

- (NSArray *)items {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    for (int columnIndex = 0; columnIndex < self.numberOfColumns; columnIndex++) {
        for (int rowIndex = 0; rowIndex < self.numberOfRows; rowIndex++) {
            id itemAtIndex = [[self.grid objectAtIndex:columnIndex] objectAtIndex:rowIndex];
            [items addObject:itemAtIndex];
        }
    }
    
    return items;
}

#pragma mark Private Methods

- (void)createGrid {
    self.grid = [[NSMutableArray alloc] init];
    
    for (int columnIndex = 0; columnIndex < self.numberOfColumns; columnIndex++) {
        NSMutableArray *column = [[NSMutableArray alloc] init];
        [self.grid addObject:column];
        
        for (int rowIndex = 0; rowIndex < self.numberOfRows; rowIndex++) {
            NSMutableArray *row = [[NSMutableArray alloc] init];
            [column addObject:row];
        }
    }
}

#pragma mark Properties

- (NSMutableArray *)grid {
    if (!_grid) {
        [self createGrid];
    }
    return _grid;
}

@end
