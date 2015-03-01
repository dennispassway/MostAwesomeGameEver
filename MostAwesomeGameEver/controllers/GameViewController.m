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

static int const numberOfHorizontalItems = 4;



#pragma mark Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    
    [self randomFillGrid];
    [self startGame];
}

#pragma mark Private methods

- (void)setup {
    float itemSize = CGRectGetWidth(self.gameView.frame) / numberOfHorizontalItems;
    [DiamondView setDiamondViewSize:itemSize];
}

- (void)startGame {
    [self drawGrid];
    [self applyGameRules];
    
    if (self.isChanged) {
        [self removeMatchesFromGame];
        [self refillGridWithDiamonds];
    }
}

- (void)randomFillGrid {
    for (int columnIndex = 0; columnIndex < self.gridController.numberOfColumns; columnIndex++) {
        for (int rowIndex = 0; rowIndex < self.gridController.numberOfRows; rowIndex++) {
            DiamondView *diamondView = [[DiamondView alloc] init];
            [self.gridController addItem:diamondView atPosition:[[GridPositionModel alloc] initWithColumnIndex:columnIndex rowIndex:rowIndex]];
        }
    }
}

- (void)drawGrid {
    NSArray *items = [self.gridController items];
    CGFloat gameViewWidth = CGRectGetWidth(self.gameView.frame);
    
    for (DiamondView *item in items) {
        GridPositionModel *position = [self.gridController positionOfItem:item];
        
        float inset = 8.0;
        int itemSize = gameViewWidth / numberOfHorizontalItems;
        
        CGRect itemFrame = item.frame;
        itemFrame.size.width = itemSize;
        itemFrame.size.height = itemSize;
        itemFrame.origin.x = (position.columnIndex * item.size) + (item.size / 4);
        itemFrame.origin.y = (position.rowIndex * item.size) + (item.size / 4);
        item.frame = itemFrame;
        item.bounds = CGRectInset(item.frame, inset, inset);
        
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
        for (GridPositionModel *positionOfItem in match) {
            id item = [self.gridController itemAtPosition:positionOfItem];
            
            if ([item isKindOfClass:[DiamondView class]]) {
                [item removeFromSuperview];
                [self.gridController removeItemAtPosition:positionOfItem];
            }
        }
    }
}

- (void)refillGridWithDiamonds {
    GridPositionModel *position;
    id item;
    DiamondView *diamondView;
    
    for (int columnIndex = 0; columnIndex < self.gridController.numberOfColumns; columnIndex++) {
        for (int rowIndex = 0; rowIndex < self.gridController.numberOfRows; rowIndex++) {
            position = [[GridPositionModel alloc] initWithColumnIndex:columnIndex rowIndex:rowIndex];
            item = [self.gridController itemAtPosition:position];
            if (![item isKindOfClass:[DiamondView class]]) {
                diamondView = [[DiamondView alloc] init];
                [self.gridController addItem:diamondView atPosition:position];
            }
        }
    }
    
    [self startGame];
}

#pragma mark Getters

- (GridController *)gridController {
    if (!_gridController) {
        CGFloat gameViewWidth = CGRectGetWidth(self.gameView.frame);
        CGFloat gameViewHeight = CGRectGetHeight(self.gameView.frame);
        
        int itemSize = (gameViewWidth / numberOfHorizontalItems);
        
        int columns = gameViewWidth / itemSize;
        int rows = gameViewHeight / itemSize;
        _gridController = [[GridController alloc] initWithColumns:columns rows:rows];
    }
    
    return _gridController;
}

@end
