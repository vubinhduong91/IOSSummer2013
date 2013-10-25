//
//  HinhVuongMaThuatViewController.m
//  HinhVuongMaThuat
//
//  Created by hust6 on 5/5/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import "HinhVuongMaThuatViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface HinhVuongMaThuatViewController ()
@property (strong, nonatomic) AVAudioPlayer *player;
@end

@implementation HinhVuongMaThuatViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self registedNotification];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)playInGameSound
{
    NSString *soundFilePath =
    [[NSBundle mainBundle] pathForResource: @"inGameSound"
                                    ofType: @"mp3"];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer *newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: nil];
    self.player = newPlayer;
    newPlayer.volume = 0.8;
    newPlayer.numberOfLoops = -1;
    [newPlayer prepareToPlay];
    [newPlayer play];
}

-(void)playLearningSound
{
    NSString *soundFilePath =
    [[NSBundle mainBundle] pathForResource: @"learningPartMusic"
                                    ofType: @"mp3"];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer *newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: nil];
    self.player = newPlayer;
    newPlayer.volume = 0.7;
    newPlayer.numberOfLoops = -1;
    [newPlayer prepareToPlay];
    [newPlayer play];
}
- (IBAction)beHoc:(id)sender {
    [self playLearningSound];
}

- (IBAction)beChoi:(id)sender {
    [self playInGameSound];
}


-(void)registedNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(stopMusic:)
                                                 name:@"stopMusic"
                                               object:nil];

}

-(void)stopMusic:(id)notification
{
    [self.player stop];
}

@end
