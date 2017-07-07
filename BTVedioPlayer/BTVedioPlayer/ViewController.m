//
//  ViewController.m
//  BTVedioPlayer
//
//  Created by 滕跃兵 on 2017/7/4.
//  Copyright © 2017年 滕跃兵. All rights reserved.
//
#import <AVKit/AVKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ViewController.h"
#import "LRLVideoPlayerView.h"


@interface ViewController ()<LRLAVPlayDelegate>

@property (nonatomic, strong) LRLVideoPlayerView * player;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createAVPlayerView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"我的天" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 100, 100);
    btn.center = self.view.center;
    [self.view addSubview:btn];
}

-(void)createAVPlayerView{
    
    LRLVideoPlayerItem *item1 = [[LRLVideoPlayerItem alloc] init];
    item1.videoUrlStr = @"http://hc.yinyuetai.com/uploads/videos/common/B65B013CF61E82DC9766E8BDEEC8B602.flv?sc=8cafc5714c8a6265";
    
    LRLVideoPlayerItem *item2 = [[LRLVideoPlayerItem alloc] init];
    item2.videoUrlStr = @"http://baobab.wdjcdn.com/1463028607774b.mp4";
    
    LRLVideoPlayerItem *item3 = [[LRLVideoPlayerItem alloc] init];
    item3.videoUrlStr = @"http://hc.yinyuetai.com/uploads/videos/common/331C015823B0F4E886170714CD9062FD.flv?sc=8f526db9deea29c8";
    
    LRLVideoPlayerItem *item4 = [[LRLVideoPlayerItem alloc] init];
    item4.videoUrlStr = @"http://hc.yinyuetai.com/uploads/videos/common/76840156C5FC70B48E22172396283ABA.flv?sc=fe29e57cf9e45fa3";
    
    //, item2, item3, item4
    self.player = [LRLVideoPlayerView avplayerViewWithPlayItems:@[item1, item2, item3, item4] andInitialHeight:200.0 andSuperView:self.view];
    
    self.player.backPlayMode = NO;
    self.player.delegate = self;
    [self.view addSubview:self.player];
    [self.view bringSubviewToFront:self.player];
    __weak ViewController * weakSelf = self;
    //播放器的外层UI封装部分依赖 Masonry 第三方库
    [self.player setPositionWithPortraitBlock:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).with.offset(60);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        //添加竖屏时的限制, 这条也是固定的, 因为: _videoHeight 是float* 类型, 我可以通过它, 动态改视频播放器的高度;
        make.height.equalTo(@(*(weakSelf.player.videoHeight)));
    } andLandscapeBlock:^(MASConstraintMaker *make) {
        make.width.equalTo(@(SCREEN_HEIGHT));
        make.height.equalTo(@(SCREEN_WIDTH));
        make.center.equalTo(weakSelf.view);
    }];
    [self.player prepare];
}


#pragma mark - 关闭设备自动旋转, 然后手动监测设备旋转方向来旋转avplayerView
-(BOOL)shouldAutorotate{
    return NO;
}


@end
