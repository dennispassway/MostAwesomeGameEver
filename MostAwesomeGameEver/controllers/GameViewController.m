//
//  ViewController.m
//  MostAwesomeGameEver
//
//  Created by Dennis Passway on 16/02/15.
//  Copyright (c) 2015 VOF JD BV. All rights reserved.
//

#import "GameViewController.h"
#import "GridPositionModel.h"
#import "DiamondView.h"
#import "GRLinearMatch.h"

@interface GameViewController()

@property (weak, nonatomic) IBOutlet UIView *gameView;
@property (strong, nonatomic) NSArray *matches;
@property (nonatomic) BOOL isChanged;

@end

@implementation GameViewController

#pragma mark Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self randomFillGrid];
    [self start];
}

#pragma mark Private methods

- (void)start {
    [self drawGrid];
    [self applyGameRules];
    
    if (self.isChanged) {
        [self removeMatchesFromGame];
        [self refillGrid];
    }
}

- (void)randomFillGrid {
    for (int i = 0; i < self.gridController.numberOfColumns; i++) {
        for (int j = 0; j < self.gridController.numberOfRows; j++) {
            DiamondView *diamondView = [[DiamondView alloc] init];
            [self.gridController addItem:diamondView atPosition:[[GridPositionModel alloc] initWithColumnIndex:i rowIndex:j]];
        }
    }
}

- (void)drawGrid {
    NSArray *items = [self.gridController getItems];
    CGFloat gameViewWidth = CGRectGetWidth(self.gameView.frame);
    
    for (DiamondView *item in items) {
        GridPositionModel *position = [self.gridController itemPosition:item];
        
        CGRect frame = item.frame;
        frame.size.width = gameViewWidth / 4;
        frame.size.height = gameViewWidth / 4;
        frame.origin.x = (position.columnIndex * item.size);
        frame.origin.y = (position.rowIndex * item.size);
        item.frame = frame;
        
        [self.view addSubview:item];
    }
}

- (void)applyGameRules {
    GRLinearMatch *linearMatchRule = [[GRLinearMatch alloc] init];
    self.matches = [linearMatchRule applyWithGrid:self.gridController];
    
    NSLog(@"total matches: %lu", (unsigned long)[self.matches count]);
    
    for (NSArray *match in self.matches) {
        NSLog(@"match length: %lu", (unsigned long)[match count]);
    }
    
    self.isChanged = [self.matches count] > 0;
}

- (void)removeMatchesFromGame {
    for (NSArray *match in self.matches) {
        for (GridPositionModel *position in match) {
            // get basic item. it can be diamondview or placeholder
            id item = [self.gridController itemAtPosition:position];
            
            // check if it is the correct type Diamondview
            if ([item isKindOfClass:[DiamondView class]]) {
                // remove view from superview
                [item removeFromSuperview];
                // remove id from grid
                [self.gridController removeItemAtPosition:position];
            }
        }
    }
}

- (void)refillGrid {
    GridPositionModel *position;
    id item;
    DiamondView *view;
    
    for (int i = 0; i < self.gridController.numberOfColumns; i++) {
        for (int j = 0; j < self.gridController.numberOfRows; j++) {
            position = [[GridPositionModel alloc] initWithColumnIndex:i rowIndex:j];
            item = [self.gridController itemAtPosition:position];
            if (![item isKindOfClass:[DiamondView class]]) {
                view = [[DiamondView alloc] init];
                [self.gridController addItem:view atPosition:position];
            }
        }
    }
    
    [self start];
}

#pragma mark Getters

- (GridController *)gridController {
    if (!_gridController) {
        CGFloat gameViewWidth = CGRectGetWidth(self.gameView.frame);
        CGFloat gameViewHeight = CGRectGetHeight(self.gameView.frame);
        
        int columns = gameViewWidth / (gameViewWidth / 4);
        int rows = gameViewHeight / (gameViewWidth / 4);
        _gridController = [[GridController alloc] initWithColumns:columns rows:rows];
    }
    
    return _gridController;
}

@end
