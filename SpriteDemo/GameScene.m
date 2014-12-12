//
//  GameScene.m
//  SpriteDemo
//
//  Created by Lê Công on 12/9/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "GameScene.h"
#import "LCVeticalCell.h"
#import "SKNode+Frame.h"

@implementation GameScene {
    NSMutableArray *arrVerticalCell;
    
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _deltaTime;
    
    CGPoint locationBegin;
    int index;
    
    NSTimer *timer;
}

- (id)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];

    if (self) {
        
        arrVerticalCell = [NSMutableArray new];
        _isAuto = FALSE;
        
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"bgMachine"];
        bg.anchorPoint = CGPointMake(0, 0);
        bg.position = [self newPoint:CGPointMake(102.5, 62)];
        bg.size = [self newSize:CGSizeMake(366, 204.5)];
        
        [self addChild:bg];

        for (int i = 0 ; i < 5; i ++) {
            LCVeticalCell *verticalCell = [[LCVeticalCell alloc] initWithIndex:i];
            verticalCell.gameScene = self;
            
            [arrVerticalCell addObject:verticalCell];
        }
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        locationBegin  = [touch locationInNode:self];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (_isRunning) {
        return;
    }

    if (_isAuto) {
        return;
    }
    
    for (UITouch *touch in touches)
    {
        CGPoint location  = [touch locationInNode:self];
        SKNode *node = [self nodeAtPoint:location];
        
        if (node != self) {
            if ([node.name isEqualToString:@"Cell"] || [node.name isEqualToString:@"Result"] )
            {
                CGPoint previousLocation = [touch previousLocationInNode:self];
                float diff = location.y - previousLocation.y;
                
                index = [self cellInLocation:location];
                LCVeticalCell *verticalCell = arrVerticalCell[index];
                [verticalCell changeLocationWithDistance:diff];
            }
        }
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint locationEnd;
    LCVeticalCell *cell = arrVerticalCell[index];
    
    for (UITouch *touch in touches) {
        locationEnd  = [touch locationInNode:self];
    }
    
    SKNode *node = [self nodeAtPoint:locationEnd];
    if (node == self) {
        return;
    }
    
    if (_isRunning) {
        return;
    }
    
    if (_isAuto) {
        return;
    }
    
    CGFloat distance = locationEnd.y - locationBegin.y;
    if (distance <  -100) {
        _isRote = TRUE;
        cell.currentState = State_Start;
    }
}

- (void)update:(NSTimeInterval)currentTime {
    if(_lastUpdateTime)
    {
        _deltaTime = currentTime - _lastUpdateTime;
    }
    else
    {
        _deltaTime = 0;
    }
    _lastUpdateTime = currentTime;
    
    for (LCVeticalCell *verticalCell in arrVerticalCell) {
        [verticalCell update:_deltaTime];
    }
    
    if (_isAuto) {
        LCVeticalCell *lastCell = arrVerticalCell[4];
        if (lastCell.currentState == State_Idle) {
            for (LCVeticalCell *verticalCell in arrVerticalCell) {
                verticalCell.currentState = State_Start;
            }
        }
    }
}

- (void)start {
    _isRunning = !_isRunning;
    
    if (_isRunning) {
        for (int i = 0; i < arrVerticalCell.count; i ++) {
            LCVeticalCell *cell = arrVerticalCell[i];
            cell.currentState = State_Start;
        }
    } else {
        
        timer = [NSTimer scheduledTimerWithTimeInterval:0.25f target:self selector:@selector(updateCounter:) userInfo:nil repeats:YES];
    }
}

- (void)updateCounter:(NSTimer *)theTimer {
    if (_timerCount > 4) {
        [timer invalidate];
        timer = Nil;
        return;
    }
    
    LCVeticalCell *cell = arrVerticalCell[_timerCount];
    cell.currentState = State_Stop;
    _timerCount ++;
}

- (int)cellInLocation:(CGPoint)location {
    index = (location.x - 100.0)/75;
    return index;
}

@end
