//
//  GameScene.m
//  SpriteDemo
//
//  Created by Lê Công on 12/9/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "GameScene.h"

static const float OBJECT_VELOCITY = 500;
static const float MAX_VELOCITY = 1000;

static inline CGPoint CGPointAdd(const CGPoint a, const CGPoint b)
{
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint CGPointMultiplyScalar(const CGPoint a, const CGFloat b)
{
    return CGPointMake(a.x * b, a.y * b);
}

@implementation GameScene

- (id)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];

    if (self) {
        
        for (int j = 0; j < 5; j ++) {
            for (int i = 0 ; i < 6; i ++) {
                int slot = arc4random()%4;
                [self genareObjectWithSlot:slot atPosition:CGPointMake(100 + 72*j, 50 + (65*i))];
            }
        }
        
        for (int i = 0 ; i < 6; i ++) {
            arrVelocity[i] = MAX_VELOCITY;
        }
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (self.currentState != State_Idle) {
        return;
    }
    
    for (UITouch *touch in touches) {
        beginTouch = [touch locationInNode:self];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    if (self.currentState != State_Idle) {
        return;
    }
    
    for (UITouch *touch in touches) {
        
        CGPoint location  = [touch locationInNode:self];
        CGPoint previousLocation = [touch previousLocationInNode:self];
        float diff = location.y - previousLocation.y;
        
        for (int i = 0; i < self.children.count; i ++) {
            SKNode *node = self.children[i];
            if ([node.name isEqualToString:@"spriteNode"]) {
                node.position = CGPointMake(node.position.x, node.position.y + diff);
            }
        }
        
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    if (self.currentState != State_Idle) {
        return;
    }
    
    for (UITouch *touch in touches) {
        endTouch = [touch locationInNode:self];
        NSLog(@"%f", endTouch.y - beginTouch.y);
        if (endTouch.y - beginTouch.y < - 50) {
            isRote = TRUE;
            velocityRote.y = - (endTouch.y - beginTouch.y) * 2;
            _currentState = State_Start;
        }
    }
}

- (void)genareObjectWithSlot:(int)slot atIndex:(int)index andPosition:(CGPoint)position {

    NSString *imageName = [NSString stringWithFormat:@"jackPot%d", slot];
    SKTexture *texture = [SKTexture textureWithImageNamed:imageName];
    SKSpriteNode *spriteNode = [[SKSpriteNode alloc] initWithTexture:texture];
    
    spriteNode.position = position;
    spriteNode.anchorPoint = CGPointMake(0, 0);
    spriteNode.name = @"spriteNode";
    spriteNode.size = CGSizeMake(72, 65);
    
    [self insertChild:spriteNode atIndex:index];
}

- (void)genareObjectWithSlot:(int)slot atPosition:(CGPoint)position {
    [self genareObjectWithSlot:slot atIndex:(int)self.children.count andPosition:position];
}

- (void)update:(CFTimeInterval)currentTime {
    
    if(lastUpdateTime)
    {
        deltaTime = currentTime - lastUpdateTime;
    }
    else
    {
        deltaTime = 0;
    }
    lastUpdateTime = currentTime;
    
    switch (_currentState) {
        case State_Idle:
            for (int i = 0 ; i < self.children.count; i ++) {
                
                if (i % 6 == 0 ) {
                    SKNode *minNode = self.children[i];
                    
                    if ([minNode.name isEqualToString:@"spriteNode"]) {
                        if (minNode.position.y < 35) {
                            
                            [minNode removeFromParent];
                            
                            SKSpriteNode *maxNode = self.children[i + 4];
                            int slot = arc4random()%4;
                            
                            [self genareObjectWithSlot:slot atIndex:i+5 andPosition:CGPointMake(maxNode.position.x, maxNode.position.y + maxNode.size.height)];
                        }
                    }
                }
            }
            
            break;
        case State_Start:
            
            if (!isRote) {
                velocityY.y = velocityY.y - OBJECT_VELOCITY*deltaTime;
            } else {
                velocityY.y = velocityY.y - velocityRote.y*deltaTime;
            }
            
            if (velocityY.y < - MAX_VELOCITY) {
                velocityY.y = - MAX_VELOCITY;
                
                self.currentState = State_Stop;
            }
            
            
            break;
            
        case State_Stop:

            changeStateTime = changeStateTime + deltaTime;
            
            for (int i = 0; i < 5; i ++) {
                if (changeStateTime > i*0.125) {
                    if (!isRote) {
                        arrVelocity[i] = arrVelocity[i] + OBJECT_VELOCITY*deltaTime;
                    } else {
                        arrVelocity[i] = arrVelocity[i] + velocityRote.y*deltaTime;
                    }
                }
            }
            
            if (arrVelocity[5] > 0) {
                self.currentState = State_Idle;
                for (int i = 0; i < 5; i++) {
                    arrVelocity[i] = 0;
                }
            }
            
            break;
        default:
            break;
    }
    

    
    for (int i = 0; i < self.children.count; i ++) {
        CGPoint amtToMove;
        if (i >=0 && i <=5) {
            amtToMove = CGPointMultiplyScalar(velocityY, deltaTime);
        }
        
        SKSpriteNode *node = self.children [i];
        node.position = CGPointAdd(node.position, amtToMove);
        
        if (i % 6 == 0 ) {
            SKNode *minNode = self.children[i];
            
            if ([minNode.name isEqualToString:@"spriteNode"]) {
                if (minNode.position.y < 35) {
                    
                    [minNode removeFromParent];
                    
                    SKSpriteNode *maxNode = self.children[i + 4];
                    int slot = arc4random()%4;
                    
                    [self genareObjectWithSlot:slot atIndex:i+5 andPosition:CGPointMake(maxNode.position.x, maxNode.position.y + maxNode.size.height)];
                }
            }
        }
        
    }
    
}


@end
