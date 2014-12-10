//
//  LCGrid.m
//  SpriteDemo
//
//  Created by Lê Công on 12/10/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "LCGrid.h"
#import "LCCell.h"

@implementation LCGrid {
    NSMutableArray *grid;
}


- (id)init {
    self = [super init];
    if (self) {
        grid = [NSMutableArray new];
        for (int i = 0; i < 5; i++) {
            NSMutableArray *array = [NSMutableArray new];
            for (int j = 0; j < 6; j++) {
                int slot = arc4random()%4;
                NSString *imageName = [NSString stringWithFormat:@"jackPot%d", slot];
                [array addObject:[[LCCell alloc] initWithImageNamed:imageName andPosition:CGPointMake(100*i+j*72, 100*i+65*j)]];
            }
        }
    }
    return self;
}
@end
