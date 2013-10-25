//
//  musicVC.m
//  finalVer1
//
//  Created by hust6 on 4/28/13.
//  Copyright (c) 2013 hust6. All rights reserved.
// follow a guild on netutplus

#import "musicVC.h"
#import "appSetting.h"

#define APP_MUSIC 0;
#define PHONE_MUSIC 1;

@interface musicVC ()
@property (weak, nonatomic) IBOutlet UIButton *nextSongButton;
@property (weak, nonatomic) IBOutlet UIButton *preSongButton;
@property (retain, nonatomic) appSetting *appSetting;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property int kindOfMusic;
@end

@implementation musicVC

-(appSetting*)appSetting
{
    if(!_appSetting)
    {
        _appSetting = [[appSetting alloc] init];
    }
    return _appSetting;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
////////////////////

- (void)viewDidLoad
{
    NSLog(@"Music VC didload");
    [super viewDidLoad];
    [self getKindOfMusic];
    NSLog(@"kind of music %d",self.kindOfMusic);
    if(self.kindOfMusic == 0)
    {
        self.label.text = @"You are playing music from this app";
        self.nextSongButton.enabled = NO;
        self.preSongButton.enabled = NO;
    }
    else if(self.kindOfMusic == 1)
    {
        self.label.text = @"You are playing your I-pod music";
        self.nextSongButton.enabled = YES;
        self.preSongButton.enabled = YES;
    }
    
}



-(void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"dismiss from modal VC! ");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SecondViewControllerDismissed"
                                                        object:nil
                                                      userInfo:nil];
}

- (IBAction)playPressed:(id)sender {
    //not complete.
   if(self.kindOfMusic == 1)
   {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PauseOrPlay"
object:nil
userInfo:nil];
   }
    else if(self.kindOfMusic == 0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AVAPauseOrPlay" object:nil userInfo:nil];
    }
}
- (IBAction)nextPressed:(id)sender {
     if(self.kindOfMusic == 1)
    [[NSNotificationCenter defaultCenter] postNotificationName:@"nextSongPressed"
object:nil
userInfo:nil];
}

- (IBAction)previousPressed:(id)sender {
     if(self.kindOfMusic == 1)
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PauseOrPlay"
object:nil
userInfo:nil]; 
}


-(void)getKindOfMusic
{
     NSDictionary *temp = [self.appSetting getSettingValue];
    NSString *musicType = [temp objectForKey:@"music"];
    if([musicType isEqualToString:@"App Music"])
    {
        self.kindOfMusic = 0;
    }
    else if([musicType isEqualToString:@"Phone Music"])
    {
        self.kindOfMusic = 1;
    }
    else
    {
        NSLog(@"not don't know must be wrong");
    }
}

@end
