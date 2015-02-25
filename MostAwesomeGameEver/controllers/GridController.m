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

- (void)addItem:(id)item atPosition:(GridPositionModel *)position {
    if (![self containsItem:item]) {
        NSMutableArray *row = [self.grid objectAtIndex:position.columnIndex];
        [row replaceObjectAtIndex:position.rowIndex withObject:item];
    }
}

- (void)removeItemAtPosition:(GridPositionModel *)position {
    // replace item in 2d array
    NSObject *placeholder = [[NSObject alloc] init];
    [self addItem:placeholder atPosition:position];
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

- (id)itemAtPosition:(GridPositionModel *)position {
    return [[self.grid objectAtIndex:position.columnIndex] objectAtIndex:position.rowIndex];
}

- (BOOL)containsItem:(id)item {
    for (int i = 0; i < self.numberOfColumns; i++) {
        for (int j = 0; j < self.numberOfRows; j++) {
            id itemAtIndex = [[self.grid objectAtIndex:i] objectAtIndex:j];
            if ([itemAtIndex isEqual:item]) {
                return YES;
            }
        }
    }
    
    return NO;
}

- (NSArray *)getItems {
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.numberOfColumns; i++) {
        for (int j = 0; j < self.numberOfRows; j++) {
            id itemAtIndex = [[self.grid objectAtIndex:i] objectAtIndex:j];
            [items addObject:itemAtIndex];
        }
    }
    
    return items;
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

#pragma mark Properties

- (NSMutableArray *)grid {
    if (!_grid) {
        [self createGrid];
    }
    return _grid;
}

@end
