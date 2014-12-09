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
        
        for (int i = 0 ; i < 6; i ++) {
            int slot = arc4random()%4;
            [self genareObjectWithSlot:slot atPosition:CGPointMake(100, 50 + (65*i))];
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
                
                SKNode *minNode = self.children[0];
                
                if ([minNode.name isEqualToString:@"spriteNode"]) {
                    if (minNode.position.y < 35) {
                        
                        [minNode removeFromParent];
                        
                        SKSpriteNode *maxNode = self.children[self.children.count -1];
                        int slot = arc4random()%4;
                        
                        [self genareObjectWithSlot:slot atPosition:CGPointMake(100, maxNode.position.y + maxNode.size.height)];
                    }
                }
                
                SKNode *maxNode = self.children[self.children.count - 1];
                if ([maxNode.name isEqualToString:@"spriteNode"]) {
                    if (maxNode.position.y > 440) {
                        
                        [maxNode removeFromParent];
                        
                        SKSpriteNode *minNode = self.children[0];
                        int index = arc4random()%4;
                        
                        [self genareObjectWithSlot:index atIndex:0 andPosition:CGPointMake(100, minNode.position.y - minNode.size.height)];
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
            if (!isRote) {
                velocityY.y = velocityY.y + OBJECT_VELOCITY*deltaTime;
            } else {
                velocityY.y = velocityY.y + velocityRote.y*deltaTime;
            }

            if (velocityY.y > 0) {
                self.currentState = State_Idle;
                velocityY.y = 0;
            }
            
            break;
        default:
            break;
    }
    
    CGPoint amtToMove = CGPointMultiplyScalar(velocityY, deltaTime);
    
    for (int i = 0; i < self.children.count; i ++) {
        SKSpriteNode *node = self.children [i];
        node.position = CGPointAdd(node.position, amtToMove);
        SKNode *minNode = self.children[0];
        
        if ([minNode.name isEqualToString:@"spriteNode"]) {
            if (minNode.position.y < 35) {
                
                [minNode removeFromParent];
                
                SKSpriteNode *maxNode = self.children[self.children.count -1];
                int slot = arc4random()%4;
                
                [self genareObjectWithSlot:slot atPosition:CGPointMake(100, maxNode.position.y + maxNode.size.height)];
            }
        }
        
    }
    
}


@end
