//
//  GameScene.h
//  SpriteDemo
//

//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene

@property (nonatomic) BOOL isAuto;
@property (nonatomic) BOOL isRote;

@property (nonatomic) int timerCount;
- (void)start;

@end
