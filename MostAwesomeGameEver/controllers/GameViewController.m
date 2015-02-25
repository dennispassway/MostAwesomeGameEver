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

@interface GameViewController()

@property (weak, nonatomic) IBOutlet UIView *gameView;

@end

@implementation GameViewController

#pragma mark Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self randomFillGrid];
    [self drawGrid];
    [self applyGameRules];
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
//    [self gameRuleTopToBottom];
//    [self gameRuleLeftToRight];
}

- (void)gameRuleTopToBottom {
    DiamondView *item;
    int currentColorId = -1;
    NSMutableArray *foundPattern = [[NSMutableArray alloc] init];
    NSMutableArray *foundPatterns = [[NSMutableArray alloc] init];
    
    // search pattern from top to bottom
    for (int i = 0; i < self.gridController.numberOfColumns; i++) {
        NSLog(@"NEW COLUMN: %d", i);
        NSLog(@"-=-=-=-=-=-=-=-");
        
        for (int j = 0; j < self.gridController.numberOfRows; j++) {
            NSLog(@"ROW INDEX %d", j);
            item = [self.gridController itemAtPosition:[[GridPositionModel alloc] initWithColumnIndex:i rowIndex:j]];
            
            if (item.colorId == currentColorId) {
//                NSLog(@"match: %d, %d", item.colorId, currentColorId);
                [foundPattern addObject:[[GridPositionModel alloc] initWithColumnIndex:i rowIndex:j]];
            } else {
                // minimum pattern length
                if ([foundPattern count] >= 3) {
                    NSLog(@"found pattern");
                    // save pattern.
                    [foundPatterns addObject:foundPattern.copy];
                }
                
                // reset search.
//                NSLog(@"reset search");
                [foundPattern removeAllObjects];
                currentColorId = item.colorId;
                [foundPattern addObject:[[GridPositionModel alloc] initWithColumnIndex:i rowIndex:j]];
//                NSLog(@"new color:  %d", currentColorId);
            }
        }
        
        if ([foundPattern count] >= 3) {
            NSLog(@"found pattern");
            // save pattern.
            [foundPatterns addObject:foundPattern.copy];
        }
        
        // reset search.
//        NSLog(@"reset search");
        [foundPattern removeAllObjects];
        currentColorId = -1;
        
        NSLog(@"-=-=-=-=-=-=-=-");
        NSLog(@"END OF COLUMN");
        NSLog(@"-=-=-=-=-=-=-=-");
    }
}

- (void)gameRuleLeftToRight {
    DiamondView *item;
    int currentColorId = -1;
    NSMutableArray *foundPattern = [[NSMutableArray alloc] init];
    NSMutableArray *foundPatterns = [[NSMutableArray alloc] init];
    
    // search pattern from top to bottom
    for (int i = 0; i < self.gridController.numberOfRows; i++) {
        NSLog(@"NEW ROW: %d", i);
        NSLog(@"-=-=-=-=-=-=-=-");
        
        for (int j = 0; j < self.gridController.numberOfColumns; j++) {
            NSLog(@"COLUMN INDEX %d", j);
            item = [self.gridController itemAtPosition:[[GridPositionModel alloc] initWithColumnIndex:j rowIndex:i]];
            
            if (item.colorId == currentColorId) {
//                NSLog(@"match: %d, %d", item.colorId, currentColorId);
                [foundPattern addObject:[[GridPositionModel alloc] initWithColumnIndex:i rowIndex:j]];
            } else {
                // minimum pattern length
                if ([foundPattern count] >= 3) {
                    NSLog(@"found pattern");
                    // save pattern.
                    [foundPatterns addObject:foundPattern.copy];
                }
                
                // reset search.
//                NSLog(@"reset search");
                [foundPattern removeAllObjects];
                currentColorId = item.colorId;
                [foundPattern addObject:[[GridPositionModel alloc] initWithColumnIndex:i rowIndex:j]];
//                NSLog(@"new color:  %d", currentColorId);
            }
        }
        
        if ([foundPattern count] >= 3) {
            NSLog(@"found pattern");
            // save pattern.
            [foundPatterns addObject:foundPattern.copy];
        }
        
        // reset search.
//        NSLog(@"reset search");
        [foundPattern removeAllObjects];
        currentColorId = -1;
        
        NSLog(@"-=-=-=-=-=-=-=-");
        NSLog(@"END OF COLUMN");
        NSLog(@"-=-=-=-=-=-=-=-");
    }
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
