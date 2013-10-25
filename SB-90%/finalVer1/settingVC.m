//
//  settingVC.m
//  finalVer1
//
//  Created by hust6 on 4/26/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import "settingVC.h"
#import "appSetting.h"


@interface settingVC ()
@property (weak, nonatomic) IBOutlet UILabel *currentLevel;
@property (weak, nonatomic) IBOutlet UILabel *currentCountingTime;
@property (weak, nonatomic) IBOutlet UILabel *currentWaitingTime;
@property (weak, nonatomic) IBOutlet UILabel *currentMusic;

@property (strong, nonatomic) appSetting *appSetting;
@property  NSDictionary *currentSetting;
@property int level;
@property int count;
@property int wait;
@property NSString *music;
@end

@implementation settingVC

@synthesize currentSetting;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(appSetting*)appSetting
{
    if(!_appSetting)
    {
        _appSetting = [[appSetting alloc] init];
    }
    return _appSetting;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentSetting = [self.appSetting getSettingValue];
    self.level = [[self.currentSetting objectForKey:@"level"] integerValue];
    self.count = [[self.currentSetting objectForKey:@"countingTime"] integerValue];
    self.wait = [[self.currentSetting objectForKey:@"waitingTime"] integerValue];
    self.music = [self.currentSetting objectForKey:@"music"];
    self.currentLevel.text = [NSString stringWithFormat:@"%d", self.level];
    self.currentCountingTime.text = [NSString stringWithFormat:@"%d", self.count];
    self.currentWaitingTime.text = [NSString stringWithFormat:@"%d", self.wait];
    self.currentMusic.text = self.music;
    // default value.
    // level = 1;
    //countting time  = 60 seconds;
    // waiting time = 60 seconds;
	// Do any additional setup after loading the view.
}

- (IBAction)levelChanged:(id)sender {
    self.level++;
    if(self.level > 5)
    {
        self.level = 1;
    }
    self.currentLevel.text = [NSString stringWithFormat:@"%d", self.level];

}

- (IBAction)countingTimeChanged:(id)sender {
    self.count += 30;
    if(self.count > 300)
    {
        self.count = 60;
    }
    self.currentCountingTime.text = [NSString stringWithFormat:@"%d", self.count];
}

- (IBAction)WaitingTimeChanged:(id)sender {
    self.wait += 30;
    if(self.wait > 300)
    {
        self.wait = 60;
    }
    self.currentWaitingTime.text = [NSString stringWithFormat:@"%d", self.wait];
}

- (IBAction)musicChanged:(id)sender {
    NSArray *array = [[NSArray alloc] initWithObjects:@"App Music", @"Phone Music", @"OFF", nil];
    if([self.currentMusic.text isEqualToString:[array objectAtIndex:0]])
        {
            self.currentMusic.text = [array objectAtIndex:1];
        }
        else if([self.currentMusic.text isEqualToString:[array objectAtIndex:1]])
                 {
                     self.currentMusic.text = [array objectAtIndex:2];
                 }
        else
                {
                     self.currentMusic.text = [array objectAtIndex:0];
                }
        self.music = self.currentMusic.text;
}


- (IBAction)save:(id)sender {
    NSDictionary *temp = [[NSDictionary alloc] initWithObjectsAndKeys:
                          [NSNumber numberWithInt:self.level], @"level",
                          [NSNumber numberWithInt:self.count], @"countingTime",
                          [NSNumber numberWithInt:self.wait], @"waitingTime",
                          self.music , @"music"
                          , nil];
    [self.appSetting upDateSetting:temp];
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)default:(id)sender {
    self.level = 1;
    self.wait = 60;
    self.count = 60;
    self.music  = @"App Music";
    self.currentLevel.text = [NSString stringWithFormat:@"%d",self.level];
    self.currentCountingTime.text = [NSString stringWithFormat:@"%d",self.count];
    self.currentWaitingTime.text = [NSString stringWithFormat:@"%d",self.wait];
    self.currentMusic.text  = self.music;
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

//- (IBAction)backButtonPressed:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
