//
//  LCCell.m
//  SpriteDemo
//
//  Created by Lê Công on 12/10/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "LCCell.h"

@implementation LCCell

- (id)initWithImageNamed:(NSString *)imageName andPosition:(CGPoint)position {
    
    SKTexture *texture = [SKTexture textureWithImageNamed:imageName];
    
    self = [super initWithTexture:texture];
    
    self.position = position;
    self.anchorPoint = CGPointMake(0, 0);
    self.name = @"LCCell";
    self.size = CGSizeMake(72, 65);
    
    return self;
}
@end
