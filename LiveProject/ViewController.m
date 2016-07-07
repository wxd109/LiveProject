//
//  ViewController.m
//  LiveProject
//
//  Created by dd on 16/7/7.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "ViewController.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface ViewController ()

@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     [self play:@"http://hls.quanmin.tv/live/555/playlist.m3u8"];
    self.view.backgroundColor = [UIColor blackColor];
//    [self play:[[NSBundle mainBundle] pathForResource:@"login_video" ofType:@"mp4"]];
}

- (void)play:(NSString *)flv
{
    if (_moviePlayer) {
        
    }
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    IJKFFMoviePlayerController *moviewPlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:flv withOptions:options];
    moviewPlayer.view.frame = self.view.bounds;
    moviewPlayer.view.backgroundColor = [UIColor whiteColor];
    moviewPlayer.scalingMode = IJKMPMovieScalingModeAspectFit;
    moviewPlayer.shouldAutoplay = NO;
    moviewPlayer.shouldShowHudView = NO;
    moviewPlayer.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;;
    self.view.autoresizesSubviews = YES;
    [self.view addSubview:moviewPlayer.view];
    [moviewPlayer prepareToPlay];
    self.moviePlayer = moviewPlayer;
    [self initObserver];
}

- (void)initObserver
{
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
}

- (void)didFinish
{
    NSLog(@"加载状态...%ld %ld %s", self.moviePlayer.loadState, self.moviePlayer.playbackState, __func__);
    
}

- (void)stateDidChange
{
    if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.moviePlayer.isPlaying) {
            [self.moviePlayer play];
        }else{
            
        }
    }else if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled){ // 网速不佳, 自动暂停状态
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
