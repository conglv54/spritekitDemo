//
//  GameScene.h
//  SpriteDemo
//

//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum : NSUInteger {
    State_Idle,
    State_Start,
    State_Stop,
} GameState;

@interface GameScene : SKScene {
 
    CGPoint velocityY;
    CGPoint velocityRote;
    
    CGPoint beginTouch;
    CGPoint endTouch;
    
    NSTimeInterval lastUpdateTime;
    NSTimeInterval deltaTime;
    
    NSTimeInterval changeStateTime;
    
    NSArray *arrChangeStateTime;
    
    float arrVelocity[6];
    
    BOOL isRote;
}

@property (nonatomic) GameState currentState;

@end
