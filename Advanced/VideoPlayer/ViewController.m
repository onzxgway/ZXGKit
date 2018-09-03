//
//  ViewController.m
//  VideoPlayer
//
//  Created by 朱献国 on 2018/8/30.
//  Copyright © 2018年 朱献国. All rights reserved.
//


#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height
#define KDeviceFrame [UIScreen mainScreen].bounds

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (nonatomic, strong) MPMoviePlayerController *moviePlayerCtrl;
@property (nonatomic, strong) AVPlayer *player;
@end

@implementation ViewController

/**
 在iOS开发上，如果遇到需要播放影片，如开机动画，我們很习惯地会使用MediaPlayer來播放影片，因为很方便使用，所以就一直使用下去。但是随着客户的要求越來越严苛，尤其是过场动画或互动效果上的表现。所以如果在一些动画中还携带影片一起运算，那势必机器会跑不动。所以在iOS 4之后，我们可以使用AVPlayer这个类別来进行更细微的操作。
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createPlayer];
    
    [self createAVPlayer];
}

// MediaPlayer
- (void)createPlayer {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"AAA" ofType:@"mp4"];
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
    NSURL *url = [NSURL URLWithString:@"http://test.video.juziwl.cn/elearning/20180820/bac84be788f846fb9535d5b2f2417f36.mp4"];
    
    MPMoviePlayerController *moviePlayerCtrl = [[MPMoviePlayerController alloc] initWithContentURL: url];
    self.moviePlayerCtrl = moviePlayerCtrl;
    
    moviePlayerCtrl.controlStyle = MPMovieControlStyleEmbedded;
    moviePlayerCtrl.view.frame = self.view.bounds;
    [self.view addSubview:moviePlayerCtrl.view];
    
}

// AVPlayer
- (void)createAVPlayer {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"AAA" ofType:@"mp4"];
    NSURL *sourceMovieURL = [NSURL fileURLWithPath:filePath];
    NSURL *url = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/gear1/prog_index.m3u8"];
    
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:sourceMovieURL options:nil];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    self.player = player;
    
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.view.layer.bounds;
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.view.layer addSublayer:playerLayer];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.moviePlayerCtrl play];
    [self.player play];
}

@end
