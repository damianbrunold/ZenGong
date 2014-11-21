//
//  ViewController.m
//  ZenGong
//
//  Created by Damian Brunold on 23.09.14.
//  Copyright (c) 2014 Damian Brunold. All rights reserved.
//

#import "ViewController.h"
#import "ZenModel.h"
#import "ZenView.h"
#import "SettingsViewController.h"

@import AVFoundation;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startButton;

@property (weak, nonatomic) IBOutlet UIButton *settingsButton;

@property (weak, nonatomic) IBOutlet ZenView *zenview;

@end

@implementation ViewController {
    ZenModel *model;
    AVAudioPlayer *player;
    UIImage *imgPlay;
    UIImage *imgPause;
    UIImage *imgStop;
    UIImage *imgSettings;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    model = [ZenModel sharedInstance];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gong" ofType:@"mp3"];
    player = [[AVAudioPlayer alloc]
              initWithContentsOfURL:[NSURL fileURLWithPath:path]
              error:nil];
    [self loadImages];
    [self updateView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateView];
}

- (void)reactivate {
    model = [ZenModel sharedInstance];
    if ([model expired]) {
        [self reset];
    }
    if (self.ticker == nil && [model started]) {
        [self startTimer];
        [[self startButton] setImage:imgStop forState:UIControlStateNormal];
        [[self settingsButton] setHidden:YES];
        [UIApplication sharedApplication].idleTimerDisabled = YES;
    }
    [self updateView];
}

- (void)loadImages {
    imgPlay = [UIImage imageNamed:@"play-32.png"];
    imgPause = [UIImage imageNamed:@"pause-32.png"];
    imgStop = [UIImage imageNamed:@"stop-32.png"];
    imgSettings = [UIImage imageNamed:@"settings-32.png"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onTick:(NSTimer *)timer {
    [self updateView];
    if ([model almostExpired]) {
        [self playGong];
    }
    if ([model expired]) {
        [self reset];
    }
}

- (void)playGong {
    [player play];
}

- (void)updateView {
    [[self zenview] setState:[model currentTime] elapsed:[model fraction]];
    [[self zenview] setNeedsDisplay];
}

- (IBAction)started:(id)sender {
    if ([model started]) {
        [self reset];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [UIApplication sharedApplication].idleTimerDisabled = NO;
    } else {
        [self startTimer];
        [model start];
        [self updateView];
        [[self startButton] setImage:imgStop forState:UIControlStateNormal];
        [[self settingsButton] setHidden:YES];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        UILocalNotification *alarm = [[UILocalNotification alloc] init];
        alarm.fireDate = [model expirationTime];
        alarm.alertBody = @"ZenGong";
        alarm.soundName = @"gong.mp3";
        [[UIApplication sharedApplication] scheduleLocalNotification:alarm];
        [UIApplication sharedApplication].idleTimerDisabled = YES;
    }
}

- (void)startTimer {
    if (self.ticker != nil) {
        [self.ticker invalidate];
        self.ticker = nil;
    }
    NSTimer *new_ticker = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                           target:self
                                                         selector:@selector(onTick:)
                                                         userInfo:nil
                                                          repeats:YES];
    self.ticker = new_ticker;
}

- (void)reset {
    if (self.ticker != nil) {
        [self.ticker invalidate];
    }
    [model reset];
    [self updateView];
    [[self startButton] setImage:imgPlay forState:UIControlStateNormal];
    [[self settingsButton] setHidden:NO];
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    [model saveData];
}

- (IBAction)settings:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
