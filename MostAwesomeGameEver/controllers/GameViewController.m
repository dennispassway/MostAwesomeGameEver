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

@end

@implementation GameViewController

#pragma mark Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self randomFillGrid];
    [self drawGrid];
    [self applyGameRules];
    [self removeMatchesFromGrid];
    [self updateUI];
}

#pragma mark Private methods

- (void)randomFillGrid {
    for (int i = 0; i < self.gridController.numberOfColumns; i++) {
        for (int j = 0; j < self.gridController.numberOfRows; j++) {
            DiamondView *diamondView = [[DiamondView alloc] init];
            [self.gridController addItem:diamondView column:i row:j];
        }
    }
}

- (void)drawGrid {
    NSArray *items = self.gridController.items;
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
    
    for (NSArray *floep in self.matches) {
        NSLog(@"%lu", (unsigned long)[floep count]);
    }
}

- (void)removeMatchesFromGrid {
    for (NSArray *match in self.matches) {
        for (GridPositionModel *position in match) {
            DiamondView *item = [self.gridController itemAtPosition:position];
            [item removeFromSuperview];
            [self.gridController removeItemAtPosition:position];
        }
    }
}

- (void)updateUI {
    [self drawGrid];
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
