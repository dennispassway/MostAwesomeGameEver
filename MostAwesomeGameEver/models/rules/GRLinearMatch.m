//
//  GRLinearMatch.m
//  MostAwesomeGameEver
//
//  Created by Dennis Passway on 25/02/15.
//  Copyright (c) 2015 VOF JD BV. All rights reserved.
//

#import "GRLinearMatch.h"
#import "DiamondView.h"

@interface GRLinearMatch()

@property (strong, nonatomic) DiamondView *item;
@property (strong, nonatomic) GridController *grid;

@property (strong, nonatomic) NSMutableArray *match;
@property (strong, nonatomic) NSMutableArray *matches;

@property (nonatomic) int currentColorId;

@end

@implementation GRLinearMatch

#pragma mark Public methods

- (NSArray *)applyWithGrid:(GridController *)grid {
    self.grid = grid;
    
    self.match = [[NSMutableArray alloc] init];
    self.matches = [[NSMutableArray alloc] init];
    
    self.currentColorId = -1;
    
    [self loopTroughGridHorizontal:YES];
    [self loopTroughGridHorizontal:NO];
    
    return self.matches;
}

#pragma mark Private methods

- (void)loopTroughGridHorizontal:(BOOL)horizontal {
    if (horizontal) {
        for (int columnIndex = 0; columnIndex < self.grid.numberOfColumns; columnIndex++) {
            for (int rowIndex = 0; rowIndex < self.grid.numberOfRows; rowIndex++) {
                [self checkGridItemForMatchWithColumnIndex:columnIndex rowIndex:rowIndex];
            }
            
            [self checkAmountOfMatches];
            [self resetWithColorId:-1];
        }
    }
    else {
        for (int rowIndex = 0; rowIndex < self.grid.numberOfRows; rowIndex++) {
            for (int columnIndex = 0; columnIndex < self.grid.numberOfColumns; columnIndex++) {
                [self checkGridItemForMatchWithColumnIndex:columnIndex rowIndex:rowIndex];
            }
            
            [self checkAmountOfMatches];
            [self resetWithColorId:-1];
        }
    }
    
}

- (void)checkGridItemForMatchWithColumnIndex:(int)columnIndex rowIndex:(int)rowIndex {
    self.item = [self.grid itemAtPosition:[[GridPositionModel alloc] initWithColumnIndex:columnIndex rowIndex:rowIndex]];
    
    if (self.item.colorId == self.currentColorId) {
        [self.match addObject:[[GridPositionModel alloc] initWithColumnIndex:columnIndex rowIndex:rowIndex]];
    }
    else {
        [self checkAmountOfMatches];
        [self resetWithColorId:self.item.colorId];
        
        [self.match addObject:[[GridPositionModel alloc] initWithColumnIndex:columnIndex rowIndex:rowIndex]];
    }
}

static int const amountToMatch = 2;

- (void)checkAmountOfMatches {
    if ([self.match count] >= amountToMatch) {
        [self.matches addObject:self.match.copy];
    }
}

- (void)resetWithColorId:(int)colorId {
    [self.match removeAllObjects];
    self.currentColorId = colorId;
}

@end