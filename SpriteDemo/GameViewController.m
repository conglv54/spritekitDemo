//
//  GameViewController.m
//  SpriteDemo
//
//  Created by Lê Công on 12/9/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "GameViewController.h"
#import "UIBuyGoldVIew.h"
#import "GameScene.h"

@implementation GameViewController {
    GameScene *scene;
    UIBuyGoldVIew *buyGold;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    buyGold = [[UIBuyGoldVIew alloc] init];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    skView.ignoresSiblingOrder = YES;
    
    // Create and configure the scene.
    scene = [[GameScene alloc] initWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
}

- (IBAction)spin:(id)sender {
    if (scene.isAuto || scene.isRote) {
        return;
    }
    
    [scene start];
}

- (IBAction)autoGame:(id)sender {
    if (scene.isRote || scene.isRunning) {
        return;
    }
    
    scene.isAuto = !scene.isAuto;
}

- (IBAction)BuyCoint:(id)sender {
    [buyGold showinView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
