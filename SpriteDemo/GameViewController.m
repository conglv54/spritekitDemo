//
//  GameViewController.m
//  SpriteDemo
//
//  Created by Lê Công on 12/9/14.
//  Copyright (c) 2014 Lê Công. All rights reserved.
//

#import "GameViewController.h"
#import "UIBuyGoldVIew.h"
#import "UIPayoutView.h"
#import "UIHistoryView.h"

#import "GameScene.h"
#import "UIView+Frame.h"

@implementation GameViewController {
    GameScene *scene;
    UIBuyGoldVIew *buyGold;
    UIPayoutView *payOutView;
    UIHistoryView *historyView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *imgBg = [UIImage imageNamed:@"bg"];
    UIImageView *imvBg = [[UIImageView alloc]initWithImage:imgBg];
    [imvBg setNewFrame:CGRectMake(0, 0, 568, 320)];
    [self.view addSubview:imvBg];
    
    UIImage *imgLeft = [UIImage imageNamed:@"bgLeft"];
    UIImageView *imvLeft = [[UIImageView alloc] initWithImage:imgLeft];
    [imvLeft setNewFrame:CGRectMake(0, 45, imgLeft.size.width, imgLeft.size.height)];
    [self.view addSubview:imvLeft];
    
    UIImage *imgHeader = [UIImage imageNamed:@"bgHeader"];
    UIImageView *imvHeader = [[UIImageView alloc]initWithImage:imgHeader];
    imvHeader.frame = CGRectMake(0, 0, imgHeader.size.width, imgHeader.size.height);
    [self.view addSubview:imvHeader];
    
    UIImage *imgLevel = [UIImage imageNamed:@"bgLevel"];
    UIImageView *imvLevel = [[UIImageView alloc]initWithImage:imgLevel];
    [imvLevel setNewFrame:CGRectMake(101, 15, imgLevel.size.width, imgLevel.size.height)];
    [self.view addSubview:imvLevel];
    
    UIImage *imgMoney = [UIImage imageNamed:@"bgMoney"];
    UIImageView *imvMoney = [[UIImageView alloc]initWithImage:imgMoney];
    [imvMoney setNewFrame:CGRectMake(242, 20, imgMoney.size.width, imgMoney.size.height)];
    [self.view addSubview:imvMoney];
    
    UIImage *imgPayout = [UIImage imageNamed:@"btnPayout"];
    UIButton *btnPayout = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnPayout setImage:imgPayout forState:UIControlStateNormal];
    [btnPayout setNewFrame:CGRectMake(388, 23, imgPayout.size.width, imgPayout.size.height)];
    [btnPayout addTarget:self action:@selector(payOut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnPayout];
    
    UIImage *imgBuy = [UIImage imageNamed:@"btnBuy"];
    UIButton *btnBuy = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBuy setImage:imgBuy forState:UIControlStateNormal];
    [btnBuy setNewFrame:CGRectMake(484, 137, imgBuy.size.width, imgBuy.size.height)];
    [btnBuy addTarget:self action:@selector(BuyCoint:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnBuy];
    
    UIImage *imgShop = [UIImage imageNamed:@"btnShop"];
    UIButton *btnShop = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnShop setImage:imgShop forState:UIControlStateNormal];
    [btnShop setNewFrame:CGRectMake(484, 190, imgShop.size.width, imgShop.size.height)];
    [self.view addSubview:btnShop];
    
    UIImage *imgRight = [UIImage imageNamed:@"bgRight"];
    UIImageView *imvRight = [[UIImageView alloc] initWithImage:imgRight];
    [imvRight setNewFrame:CGRectMake(475, 42, imgRight.size.width, imgRight.size.height)];
    [self.view addSubview:imvRight];
    
    UIImage *imgHistory = [UIImage imageNamed:@"btnHistory"];
    UIButton *btnHistory = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnHistory setImage:imgHistory forState:UIControlStateNormal];
    [btnHistory addTarget:self action:@selector(showHistory) forControlEvents:UIControlEventTouchUpInside];
    [btnHistory setNewFrame:CGRectMake(102, 263, imgHistory.size.width, imgHistory.size.height)];
    [self.view addSubview:btnHistory];
    
    UIImage *imgBet = [UIImage imageNamed:@"btnBet"];
    UIButton *btnBet = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnBet setImage:imgBet forState:UIControlStateNormal];
    [btnBet setNewFrame:CGRectMake(233, 289, imgBet.size.width, imgBet.size.height)];
    [self.view addSubview:btnBet];
    
    UIImage *imgMaxBet = [UIImage imageNamed:@"btnMaxBet"];
    UIButton *btnMaxBet = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnMaxBet setImage:imgMaxBet forState:UIControlStateNormal];
    [btnMaxBet setNewFrame:CGRectMake(290, 289, imgMaxBet.size.width, imgMaxBet.size.height)];
    [self.view addSubview:btnMaxBet];
    
    UIImage *imgSpin = [UIImage imageNamed:@"btnSpin"];
    UIButton *btnSpin = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSpin setImage:imgSpin forState:UIControlStateNormal];
    [btnSpin addTarget:self action:@selector(spin:) forControlEvents:UIControlEventTouchUpInside];
    [btnSpin setNewFrame:CGRectMake(397, 289, imgSpin.size.width, imgSpin.size.height)];
    [self.view addSubview:btnSpin];
    
    UIImage *imgBgBet = [UIImage imageNamed:@"bgBet"];
    UIImageView *imvBet = [[UIImageView alloc] initWithImage:imgBgBet];
    [imvBet setNewFrame:CGRectMake(232, 263, imgBgBet.size.width, imgBgBet.size.height)];
    [self.view addSubview:imvBet];
    
    UIImage *imgBgMaxBet = [UIImage imageNamed:@"bgMaxBet"];
    UIImageView *imvMaxBet = [[UIImageView alloc] initWithImage:imgBgMaxBet];
    [imvMaxBet setNewFrame:CGRectMake(289, 263, imgBgMaxBet.size.width, imgBgMaxBet.size.height)];
    [self.view addSubview:imvMaxBet];
    
    UIImage *imgBgWin = [UIImage imageNamed:@"bgWin"];
    UIImageView *imvWin = [[UIImageView alloc] initWithImage:imgBgWin];
    [imvWin setNewFrame:CGRectMake(396, 263, imgBgWin.size.width, imgBgWin.size.height)];
    [self.view addSubview:imvWin];

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
    if (!buyGold) {
        buyGold = [[UIBuyGoldVIew alloc] init];
    }
    [buyGold showinView:self.view];
}

- (void)payOut {
    if (!payOutView) {
        payOutView = [[UIPayoutView alloc] init];
    }
    [payOutView showinView:self.view];
}

- (void)showHistory {
    if (!historyView) {
        historyView  = [[UIHistoryView alloc] init];
    }
    [historyView showinView:self.view];
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
