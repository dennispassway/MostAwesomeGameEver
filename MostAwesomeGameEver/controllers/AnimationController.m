//
//  AnimationController.m
//  MostAwesomeGameEver
//
//  Created by Dennis Passway on 18/03/15.
//  Copyright (c) 2015 VOF JD BV. All rights reserved.
//

#import "AnimationController.h"

@implementation AnimationController

- (void)floepie {
    
    [UIView animateWithDuration:1 animations:^(void) {
        for (NSArray *match in self.matches) {
            for (GridPositionModel *positionOfItem in match) {
                id item = [self.gridController itemAtPosition:positionOfItem];
                
                if ([item isKindOfClass:[DiamondView class]]) {
                    DiamondView *view = (DiamondView *)item;
                    view.alpha = 0;
                }
            }
        }
    } completion:^(BOOL finished) {
        for (NSArray *match in self.matches) {
            for (GridPositionModel *positionOfItem in match) {
                id item = [self.gridController itemAtPosition:positionOfItem];
                
                if ([item isKindOfClass:[DiamondView class]]) {
                    [item removeFromSuperview];
                    [self.gridController removeItemAtPosition:positionOfItem];
                }
            }
        }
        
        [self refillGridWithDiamonds];
    }];

    
}

@end
