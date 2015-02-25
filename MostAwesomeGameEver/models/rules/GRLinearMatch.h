//
//  GRLinearMatch.h
//  MostAwesomeGameEver
//
//  Created by Dennis Passway on 25/02/15.
//  Copyright (c) 2015 VOF JD BV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GridController.h"

@interface GRLinearMatch : NSObject

#pragma mark Public methods

- (NSArray *)applyWithGrid:(GridController *)grid;

@end
