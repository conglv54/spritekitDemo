//
//  LCVeticalCell.h
//  SpriteDemo
//
//  Created by Le Cong on 12/10/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameScene.h"

typedef enum : NSUInteger {
    State_Idle,
    State_Start,
    State_Stop,
} GameState;

@interface LCVeticalCell : NSObject

@property (nonatomic, weak) GameScene *gameScene;
@property (nonatomic)       GameState currentState;
@property (nonatomic)       int result;

- (id)initWithIndex:(int)index;
- (void)changeLocationWithDistance:(CGFloat)distance;
- (void)update:(NSTimeInterval)deltaTime;
- (void)stepState;

@end
