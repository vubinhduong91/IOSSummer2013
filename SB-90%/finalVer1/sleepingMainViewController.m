//
//  sleepingMainViewController.m
//  sleepingMain
//
//  Created by hust6 on 4/13/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//
//



#import "sleepingMainViewController.h"
#import "modelForGraph.h"
#import "SpriteModel.h"
#import "appSetting.h"
#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>



// custiomize the input for better graph.
// Time now from 21.00 last night -> 9.00 next morning.
//therefore 21-> 0 ; 23->2. 0->3 , ...9->12
// Not so good but acceptable.
#define notSoGoodDecrease 21;
#define notSoGoodIncrease 3;


@interface sleepingMainViewController () <AVAudioPlayerDelegate>

@property CGRect screenRect;

@property (weak, nonatomic) IBOutlet UILabel *label;


@property (nonatomic) UIAlertView *alertView1;
@property (nonatomic) UIAlertView *alertView2;
@property (nonatomic) UIAlertView *alertView3;
@property (nonatomic) UIAlertView *alertView4;
@property (nonatomic) UIAlertView *alertView5;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *sleepButton;
@property (weak, nonatomic) IBOutlet UIButton *musicButton;

@property (nonatomic) NSUInteger time;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) NSTimer *timer2;

@property (nonatomic) CGFloat currentScreenBrightness;

@property (nonatomic) CGFloat currentBrightness;

@property (nonatomic) NSDate *sleepTime;
@property (nonatomic) NSDate *wakeUpTime;
@property (nonatomic) NSString *timeToStore;


//game state.
@property  BOOL pause,sleep;

//Game setting
@property int level;
@property int countingTime;
@property int watingTime;
@property NSString *music;
@property int tempValueForAudioPlayer;
//Check the sheep.
@property int howManySheep;
@property int totalSheepTonight;
//array of songs.
@property (retain ,nonatomic) NSArray *songList;

@property (strong, nonatomic) modelForGraph *model;
@property (retain, nonatomic) appSetting *appSetting;
@property (retain, nonatomic) MPMusicPlayerController *playerController;
@property (retain, nonatomic) AVAudioPlayer *audioPlayer;

@end

@implementation sleepingMainViewController

@synthesize alertView5;
@synthesize alertView4;
@synthesize alertView3;
@synthesize alertView2;
@synthesize alertView1;
@synthesize sleepTime;
@synthesize wakeUpTime;
@synthesize timeToStore;

//lazy initial.
-(appSetting*)appSetting
{
    if(!_appSetting)
    {
        _appSetting = [[appSetting alloc] init];
    }
    return _appSetting;
}


-(modelForGraph *)model
{
    if(!_model)
    {
        _model = [[modelForGraph alloc] init];
    }
    return _model;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setValueForApp];
    self.screenRect = [[UIScreen mainScreen] bounds];
    [self registedNotification];  
    
    //music.
    if([self.music isEqualToString:@"Phone Music"])
    {
        [self initMusicPlayer];
    }
    else if([self.music isEqualToString:@"App Music"]) 
    {
        NSLog(@"hey must see me");
        [self initAudioPlayer];
    }
    else
    {
        [self.musicButton setHidden:YES];
    }
    self.totalSheepTonight = 0;
    self.currentBrightness = [[UIScreen mainScreen] brightness];
    NSLog(@"%f brightneess", self.currentBrightness);
    [self mainLoop];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// setting the loop
-(void)setValueForApp
{
    NSDictionary *temp = [self.appSetting getSettingValue];
    self.level = [[temp objectForKey:@"level"] integerValue];
    self.countingTime = [[temp objectForKey:@"countingTime"] integerValue];
    self.watingTime = [[temp objectForKey:@"waitingTime"] integerValue];
    self.music = [temp objectForKey:@"music"];
    self.appSetting = nil;
}

// main loop  of app.
-(void)mainLoop
{
   
    self.howManySheep = 0;
    _time = self.countingTime; // seconds
    self.label.text = [NSString stringWithFormat:@"%d", _time];
    [self newCloud:self.countingTime];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(update) userInfo:nil  repeats:(YES)];
}

-(void)update // update.
{
    int number = self.countingTime;
    number = number - 3;
    int temp =  6 - self.level;
    
    // add a new animals each 6 - level (seconds).
    if(!self.pause)
    {
    if(_time > 5 && _time < number && (_time % temp == 0))
    {
        int rand1 = arc4random_uniform(3) + 1;
        int rand2 = arc4random_uniform(4) + 8;
        [self CreateAnimation:rand1:rand2];
    }
    
    //add a new cloud each 10s.
    if(_time % 10 == 0)
        [self newCloud:10];
        
    //reduce time by 1s.
    _time = _time - 1;
    self.label.text = [NSString stringWithFormat:@"%d", _time];
    
    if(_time == 0)
    {
         self.totalSheepTonight += self.howManySheep;
        [_timer invalidate];
        [self showAlert1];
        float temp = self.watingTime;
        _timer2 = [NSTimer scheduledTimerWithTimeInterval:temp target:self selector:@selector(hidenAlertView) userInfo:nil  repeats:(NO)];

    }
 }

    
}
//hidden the alertView1 after a time.
-(void)hidenAlertView
{
    NSLog(@"here in hiddenAlertView");
    [alertView1 dismissWithClickedButtonIndex:[alertView1 cancelButtonIndex] animated:NO];
    self.alertView1 = nil;
    [self sleepApp];
}

-(void)sleepApp
{
    self.sleep = YES;
    NSDate *sleep = [[NSDate alloc] init];
    sleepTime = sleep;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EE\ndd/MM"];
    timeToStore = [dateFormatter stringFromDate:sleepTime];
    [self.backButton setEnabled:NO];
    [self dimDisplay];
    [self tapRecognized];
    [NSTimer scheduledTimerWithTimeInterval:self.watingTime target:self selector:@selector(stopAllMusic) userInfo:nil  repeats:(NO)];
    [self.sleepButton removeFromSuperview];

}

-(void)showAlert1 // alert after 1 min.
{
    alertView1 = [[UIAlertView alloc] initWithTitle:@"What now?" message:@"what about now" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:@"Sleep", nil];
    alertView1.tag = 1;
    [alertView1 show];
}

-(void)showAlert2 // alert after double tap wake up.
{
    alertView2 = [[UIAlertView alloc] initWithTitle:@"Wakie wakie" message:@"^_^" delegate:self cancelButtonTitle:@"Wake" otherButtonTitles:@"Sleep", nil];
    alertView2.tag = 2;
    [alertView2 show];
}

-(void)showAlert3
{
    alertView3 = [[UIAlertView alloc] initWithTitle:@":bee..bee..." message:@"How many sheeps?" delegate:self cancelButtonTitle:@"Let check" otherButtonTitles:@"I do not care", nil];
    alertView3.alertViewStyle = UIAlertViewStylePlainTextInput;
    UITextField * alertTextField = [alertView3 textFieldAtIndex:0];
    alertTextField.keyboardType = UIKeyboardTypeDecimalPad;
    alertView3.tag = 3;
    [alertView3 show];

}

-(void)showAlert4:(NSString *)input
{
    alertView4 = [[UIAlertView alloc] initWithTitle:@"Oh look" message:input delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alertView4.tag = 4;
    [alertView4 show];
}

-(void) showAlert5
{
    alertView5 = [[UIAlertView alloc] initWithTitle:@"Are you sure?" message:nil delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    alertView5.tag = 5;
    [alertView5 show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
    {
        NSString *title1 = [alertView1 buttonTitleAtIndex:buttonIndex];
        if(alertView.tag == 1)
        {
        if([title1 isEqualToString:@"Continue"])
        {
            [_timer2 invalidate];
            [self showAlert3];
        }
        else if([title1 isEqualToString:@"Sleep"])
        {
            [_timer2 invalidate];
            [self sleepApp];
        }
        }
        else if(alertView.tag == 2)
        {
        NSString *title2 = [alertView2 buttonTitleAtIndex:buttonIndex];
        
        if([title2 isEqualToString:@"Wake"])
        {
            self.sleep = NO;
             wakeUpTime = [[NSDate alloc] init];
            [self WriteDate];
            [self restoreDisplay];
            self.view.gestureRecognizers = NO;
            [_timer invalidate];
            [self stopAllMusic];
            [self.navigationController  popViewControllerAnimated:YES];
        }
        else if([title2 isEqualToString:@"Sleep"])
        {
            [self dimDisplay];
        }
        }
        else if(alertView.tag == 3)
        {
            UITextField *textfield =  [alertView textFieldAtIndex: 0];
            NSString *StringOfGuessNumber = textfield.text;
            int GuessNumber = [StringOfGuessNumber intValue];
            NSString *title3 = [alertView3 buttonTitleAtIndex:buttonIndex];
            NSString *wrongMessage = [NSString stringWithFormat:@"Not correct there are %d, nevermind :)",self.howManySheep];
            if([title3 isEqualToString:@"Let check"])
                {
                    if(GuessNumber == self.howManySheep)
                    {
                        [self showAlert4:@"Great! you are correct"];
                    }
                    else
                    {
                        [self showAlert4:wrongMessage];
                    }
                }
            else if([title3 isEqualToString:@"I do not care"])
                {
                    [self mainLoop];
                }
        }
        //
        else if(alertView.tag == 4)
                {
                    [self mainLoop];
                }
         else if(alertView.tag == 5)
                {
                    if(buttonIndex == 0)
                        {
                            [_timer invalidate];
                            [_timer2 invalidate];
                            self.musicButton.hidden = YES;
                            [self sleepApp];
                        }
                }
    }

-(void)tapRecognized{
    UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    singleTapGestureRecognizer.numberOfTapsRequired = 2;
    singleTapGestureRecognizer.enabled = YES;
    singleTapGestureRecognizer.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:singleTapGestureRecognizer];    
}



- (void)singleTap:(UITapGestureRecognizer *)gesture {
    
    [self restoreDisplay];
    [self showAlert2];
}
// dim display
-(void)dimDisplay
{
    [[UIScreen mainScreen] setBrightness:0];
}

// restore displays
-(void)restoreDisplay
{
    [[UIScreen mainScreen] setBrightness:self.currentBrightness];
}

-(void)WriteDate{
    
    float sleepTimeToStore = [self getFloatValueFromDate:sleepTime];
    float wakeUpTimeToStore = [self getFloatValueFromDate:wakeUpTime];
    float lengthToStore = [wakeUpTime timeIntervalSinceDate:sleepTime]/(60 * 60);
    lengthToStore = roundf(100 * lengthToStore) / 100.0;
    NSLog(@"Time %f", lengthToStore);
    
    float NotSoGoodsleepTimeToStore, NotSoGoodWakeUpTimeToStore;
    if(sleepTimeToStore >= 21 && sleepTimeToStore <= 23)
    {
        NotSoGoodsleepTimeToStore = sleepTimeToStore - notSoGoodDecrease;
    }
    else 
    {
        NotSoGoodsleepTimeToStore =  sleepTimeToStore + notSoGoodIncrease;
    }
    
    if(wakeUpTimeToStore >= 21 && wakeUpTimeToStore <= 23)
    {
        NotSoGoodWakeUpTimeToStore = wakeUpTimeToStore - notSoGoodDecrease;
    }
    else
    {
        NotSoGoodWakeUpTimeToStore =  wakeUpTimeToStore + notSoGoodIncrease;
    }
    
    [self.model updateAfterWakeUp:timeToStore :NotSoGoodsleepTimeToStore :NotSoGoodWakeUpTimeToStore :(lengthToStore):self.totalSheepTonight];
    
    
}
-(float)getFloatValueFromDate:(NSDate *) date // return in form hh.sec
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
    NSInteger hour = [components hour];
    //NSLog(@"%d", hour);
    NSInteger minute = [components minute];
    // NSLog(@"%d", minute);
    float temp = hour + (float)minute/60;
    //get only 2 digit after the dot. "12.44" not "12.443123"
    temp = temp * 100;
    temp = round(temp);
    temp = temp / 100;
    return temp;
}

// handle view when disapper.
- (IBAction)backPressed:(id)sender {
    [_timer invalidate];
    [self stopAllMusic];
    [self.navigationController  popViewControllerAnimated:YES];
}

// Move.

//===========================All the down below part is About create move sheep. 
//New sheep.
-(UIImageView *)newSheep:(CGRect )rect
{
    
    UIImage *image = [UIImage imageNamed:@"sheep.png"];
    NSArray *imageArray =  [image spritesWithSpriteSheetImage:image inRange:NSMakeRange(0, 5) spriteSize:CGSizeMake(image.size.width /5 , image.size.height)];
    UIImageView *sheep;
    sheep = [[UIImageView alloc] initWithFrame:rect];
    sheep.animationImages = imageArray;
    sheep.animationDuration = [imageArray count] * 0.2;
    [self.view addSubview:sheep];
    [sheep startAnimating];
    return sheep;
    
}

//new Milk Cow
-(UIImageView *)newMilkCow:(CGRect )rect
{
    
    UIImage *image = [UIImage imageNamed:@"milkCow.png"];
    NSArray *imageArray =  [image spritesWithSpriteSheetImage:image inRange:NSMakeRange(0, 5) spriteSize:CGSizeMake(image.size.width /5 , image.size.height)];
    UIImageView *milkCow;
    milkCow = [[UIImageView alloc] initWithFrame:rect];
    milkCow.animationImages = imageArray;
    milkCow.animationDuration = [imageArray count] * 0.1;
    [self.view addSubview:milkCow];
    [milkCow startAnimating];
    return milkCow;
    
}

//new chicken
-(UIImageView *)newChick:(CGRect )rect
{
    
    UIImage *image = [UIImage imageNamed:@"chick.png"];
    NSArray *imageArray =  [image spritesWithSpriteSheetImage:image inRange:NSMakeRange(0, 5) spriteSize:CGSizeMake(image.size.width /5 , image.size.height)];
    UIImageView *chick;
    chick = [[UIImageView alloc] initWithFrame:rect];
    chick.animationImages = imageArray;
    chick.animationDuration = [imageArray count] * 0.1;
    [self.view addSubview:chick];
    [chick startAnimating];
    return chick;
    
}

//new pigy.
-(UIImageView *)newPig:(CGRect )rect
{
    
    UIImage *image = [UIImage imageNamed:@"pig.png"];
    NSArray *imageArray =  [image spritesWithSpriteSheetImage:image inRange:NSMakeRange(0, 5) spriteSize:CGSizeMake(image.size.width /5 , image.size.height)];
    UIImageView *pig;
    pig = [[UIImageView alloc] initWithFrame:rect];
    pig.animationImages = imageArray;
    pig.animationDuration = [imageArray count] * 0.1;
    [self.view addSubview:pig];
    [pig startAnimating];
    return pig;
    
}

//new invert sheep
-(UIImageView *)newInvertSheep:(CGRect )rect
{
    
    UIImage *image = [UIImage imageNamed:@"invertSheep.png"];
    NSArray *imageArray =  [image spritesWithSpriteSheetImage:image inRange:NSMakeRange(0, 5) spriteSize:CGSizeMake(image.size.width /5 , image.size.height)];
    UIImageView *invertSheep;
    invertSheep = [[UIImageView alloc] initWithFrame:rect];
    invertSheep.animationImages = imageArray;
    invertSheep.animationDuration = [imageArray count] * 0.1;
    [self.view addSubview:invertSheep];
    [invertSheep startAnimating];
    return invertSheep;
    
}

//new cloud
-(void)newCloud:(float) duration
{
    UIImage *cloud;
    UIImageView *cloudView;
    int temp = arc4random_uniform(1);
   // NSLog(@"I want to see this line %d", temp);
    if(temp)
    {
        cloud = [UIImage imageNamed:@"cloud_1.png"];
        cloudView = [[UIImageView alloc] initWithFrame:CGRectMake(0 - 191, 10, 191, 110)];
        
    }
    else
    {
        cloud = [UIImage imageNamed:@"cloud_2.png"];
        cloudView = [[UIImageView alloc] initWithFrame:CGRectMake(0 - 134, 10, 134, 98)];
    }
    cloudView.image = cloud;
    [self.view addSubview:cloudView];
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         cloudView.center = CGPointMake(cloudView.center.x + self.screenRect
                                                        .size.height + cloud.size.width
                                                        , cloudView.center.y);
                     }
                     completion:^(BOOL finished) {
                        // NSLog(@"done");
                         [cloudView removeFromSuperview];
                     }];
    
    
}


//////////////////////////////////////////

///Create animation.
-(void)CreateAnimation:(int)mode :(int)speed
{
    int rand1 = arc4random_uniform(3);
    CGFloat x = 0 - 80;
    if(mode == 3)
    {
        self.howManySheep++;
        UIImageView *invertSheep = [self newInvertSheep:CGRectMake(self.screenRect.size.height + 80, self.screenRect.size.width/2 + rand1 * (self.screenRect.size.width /2 - 40)/3, 45, 45)];
        [self invertMove:invertSheep:speed];

        
    }
    else
    {
        int rand2 = arc4random_uniform(8);
        int rand3 = arc4random_uniform(2);
        if(rand2 == 0)
        {
            UIImageView *chick = [self newChick:CGRectMake(x, self.screenRect.size.width/2 + rand1 * (self.screenRect.size.width /2 - 40) / 3 , 30, 30)];
            if(rand3 == 1)
            {
                [self normalMove:chick :speed];
            }
            else
            {
                [self JumpingMove:chick :speed];
            }
        }
        else if(rand2 == 1)
        {
            
            UIImageView *pig = [self newPig:CGRectMake(x, self.screenRect.size.width/2 + rand1 * (self.screenRect.size.width /2 - 40)/ 3 , 55, 55)];
            if(rand3 == 1)
            {
                [self normalMove:pig :speed];
            }
            else
            {
                [self JumpingMove:pig :speed];
            }
        }
        else if(rand2 == 2)
        {
            
            UIImageView *milkCow = [self newMilkCow:CGRectMake(x, self.screenRect.size.width/2 + rand1 * (self.screenRect.size.width /2 - 40)/3 , 80, 80)];
            if(rand3 == 1)
            {
                [self normalMove:milkCow :speed];
            }
            else
            {
                [self JumpingMove:milkCow :speed];
            }
        }
        else
        {
            self.howManySheep++;
            UIImageView *sheep = [self newSheep:CGRectMake(x, self.screenRect.size.width/2 + rand1 * (self.screenRect.size.width /2 - 40)/3 , 50, 50)];
            if(rand3 == 1)
            {
                [self normalMove:sheep :speed];
            }
            else
            {
                [self JumpingMove:sheep :speed];
            }
        
        }
        
    }
}


//normal move.

- (void)normalMove:(UIImageView *)imageView :(CGFloat) duration
{
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         imageView.center = CGPointMake(imageView.center.x + self.screenRect
                                                        .size.height + 50
                                                        , imageView.center.y);
                     }
                     completion:^(BOOL finished) {
                         //NSLog(@"done");
                         [imageView removeFromSuperview];
                     }];
    
}

 //invert right to left
                                                           
-(void)invertMove:(UIImageView *)imageView :(CGFloat) duration

{[UIView animateWithDuration:duration
                       delay:0.0
                     options:UIViewAnimationCurveEaseOut
                  animations:^{
                      imageView.center  = CGPointMake(0 - imageView.bounds.size.width, imageView.center.y);
                  }
                  completion:^(BOOL finished) {
                      //NSLog(@"done");
                      [imageView removeFromSuperview];
                  }];
    
}


-(void)JumpingMove:(UIImageView *)imageView:(CGFloat) duration

{
    [self firstMove:imageView :duration];
}

// jumping move
-(void)firstMove:(UIImageView *)imageView:(CGFloat) duration
{
    [UIView animateWithDuration:duration/3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         imageView.center = CGPointMake(imageView.center.x + self.screenRect
                                                        .size.height /3, imageView.center.y);
                     }
                     completion:^(BOOL finished) {
                         [self secondMove:imageView :duration];
                     }];
}

-(void)secondMove:(UIImageView *)imageView:(CGFloat) duration
{
    [UIView animateWithDuration:duration/6 delay:0.0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self runSpinAnimationWithDuration:imageView :duration/6];
                         imageView.center = CGPointMake(imageView.center.x + self.screenRect
                                                        .size.height /6, imageView.center.y - 100);
                     }
                     completion:^(BOOL finished) {
                         [self thirdMove:imageView:duration];
                     }];
}

-(void)thirdMove:(UIImageView *)imageView:(CGFloat) duration
{
    [UIView animateWithDuration:duration/6 delay:0.0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self runSpinAnimationWithDuration:imageView :duration/6];
                         imageView.center = CGPointMake(imageView.center.x + (2 * self.screenRect
                                                                              .size.height /6 ), imageView.center.y + 100);
                     }
                     completion:^(BOOL finished) {
                         [self forthMove:imageView:duration];
                     }];
}


-(void)forthMove:(UIImageView *)imageView:(CGFloat) duration
{
    [UIView animateWithDuration:duration/3 delay:0.0 options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         imageView.center = CGPointMake(imageView.center.x + self.screenRect
                                                        .size.height/3 + 100, imageView.center.y);
                     }
                     completion:^(BOOL finished) {
                         [imageView removeFromSuperview];
                        // NSLog(@"done");
                     }];
}
// finished 4 steps of jumps Move.

- (void) runSpinAnimationWithDuration:(UIImageView *)imageView :(CGFloat) duration;
{
    CABasicAnimation* rotationAnimation;
    CGFloat rotations = 1;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /*1.0 half 2.0 full rotation*/ * rotations  ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 1.0;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    [imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

// sleep button click
- (IBAction)sleepClicked:(id)sender {
    [self showAlert5];
    
}

//handle music modal.
// music press.
- (IBAction)musicPressed:(id)sender {
    NSLog(@"PAUSE");
    [self pauseLayer:self.view.layer];
    self.pause = YES;
}
//this is delegate method of above method.
-(void)didDismissSecondViewController: (id)notification
{
    NSLog(@"UNPAUSE");
    [self resumeLayer:self.view.layer];
    self.pause = NO;
}

-(void)handleNextSong: (id)notification
{
    
    if(self.playerController.playbackState == MPMusicPlaybackStateStopped)
    {
        [self initMusicPlayer];
    }
    else
    {
        [self.playerController skipToNextItem];
    }
}

-(void)handlePreviousSong: (id)notification
{
    if(self.playerController.playbackState == MPMusicPlaybackStateStopped)
    {
        [self initMusicPlayer];
    }
    else
    {
         [self.playerController skipToPreviousItem];
    }
   
}


-(void)handlePauseOrPlay :(id)notification
{
    if(self.playerController.playbackState == MPMusicPlaybackStatePlaying)
    {
        [self.playerController pause];
    }
    else
    {
        [self.playerController play];
    }
}

-(void)handlePauseOrPlayForAVAudio: (id)notification
{
    if(self.audioPlayer.playing)
    {
        [self.audioPlayer pause];
    }
    else if(!self.audioPlayer.playing)
    {
        [self.audioPlayer play];
    }
}


-(void)initMusicPlayer
{

    self.playerController = [MPMusicPlayerController applicationMusicPlayer];
    
    // assign a playback queue containing all media items on the device
    [self.playerController setQueueWithQuery: [MPMediaQuery songsQuery]];
    
    
    NSArray *queryArray = [[MPMediaQuery songsQuery] items];
    NSLog(@"%@", queryArray);
    self.playerController.shuffleMode = MPMusicShuffleModeSongs;
    self.playerController.repeatMode = MPMusicRepeatModeAll;
    // start playing from the beginning of the queue
    [ self.playerController play];

}

//shuffle function is proper one! Fisher and Yates 
-(void)initAudioPlayer
{

    NSArray *songs = [[NSArray alloc] initWithObjects:@"1",@"2",@"3", nil];
    NSMutableArray *songList = [[NSMutableArray alloc] initWithArray:songs];
        int temp =[songList count];
    for(int j = 0; j < 1000 ; j++)
    {
        for(int i = temp-1; i  >= 1; i--)
    {
        int rand = arc4random_uniform(i);
        [songList exchangeObjectAtIndex:rand withObjectAtIndex:i];
        
    }
    }
    NSArray *tempArray = [[NSArray alloc] initWithArray:songList];
    
            [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
            [self becomeFirstResponder];
    //self.songList = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    self.tempValueForAudioPlayer = 0;
    NSLog(@"%@", tempArray);
    NSURL *audioFileLocationURL = [[NSBundle mainBundle] URLForResource:[tempArray objectAtIndex:self.tempValueForAudioPlayer] withExtension:@"mp3"];
    
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:audioFileLocationURL error:&error];
    //[self.audioPlayer setNumberOfLoops:0];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
               }
    else
    {
                      //make sure something the system follow our playback status.
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[AVAudioSession sharedInstance] setActive:YES error:nil];
        
            //self.audioPlayer.numberOfLoops = 0;
            self.audioPlayer.delegate = self;
            [self.audioPlayer prepareToPlay];
            [self.audioPlayer play];
            
    }
}

//play song @_@ after it initialized ,AVAaudio is so poor T_T.
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
   // NSLog(@"Fire in a hole");
    if (flag)
    {
        self.tempValueForAudioPlayer++;
        if(self.tempValueForAudioPlayer == [self.songList count])
            {
                self.tempValueForAudioPlayer = 0;
            }
        NSURL *url = [[NSBundle mainBundle] URLForResource:[self.songList objectAtIndex:self.tempValueForAudioPlayer] withExtension:@"mp3"];
        NSAssert(url, @"URL is valid.");
        NSError* error = nil;
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        if(!self.audioPlayer)
        {
            NSLog(@"Error creating player: %@", error);
        }
        self.audioPlayer.numberOfLoops = 0;
        self.audioPlayer.delegate = self;
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
    }
}

-(void)stopAllMusic
{
    if(self.audioPlayer)
    {
        [self.audioPlayer stop];
    }
    if(self.playerController)
    {
        [self.playerController stop];
    }
}


// This will help sleepingMainVC know when the music this dissmiss also next song, previous song, or  
-(void)registedNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBeComeActice:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didDismissSecondViewController:)
                                                 name:@"SecondViewControllerDismissed"
                                               object:nil];
    //User pressed home
    
    // add new observer to music view controller
    if([self.music isEqualToString:@"Phone Music"]) // phone music
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleNextSong:)
                                                     name:@"nextSongPressed"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handlePreviousSong:)
                                                     name:@"previousSongPressed"
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handlePauseOrPlay:)
                                                     name:@"PauseOrPlay"
                                                   object:nil];
    }
    else if([self.music isEqualToString:@"App Music"])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePauseOrPlayForAVAudio:) name:@"AVAPauseOrPlay" object:nil];
    }
}


// Pause and unpause layer ,Great help from Pro Jim
-(void)pauseLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer convertTime:CACurrentMediaTime() fromLayer:nil];
    layer.speed = 0.0;
    layer.timeOffset = pausedTime;
}

-(void)resumeLayer:(CALayer*)layer
{
    CFTimeInterval pausedTime = [layer timeOffset];
    layer.speed = 1.0;
    layer.timeOffset = 0.0;
    layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    layer.beginTime = timeSincePause;
}



-(void)appWillResignActive:(id)notification
{
    if(self.sleep)
    {
    NSLog(@"appWillResignActive");
    }
        // i Don't know why this method doesn't be called.
   // [self restoreDisplay];
   
    
}
-(void)appDidBeComeActice:(id)notification
{
     NSLog(@"appDidBeComeActice");
    if(self.sleep)
        {
            NSLog(@"i am back");
            [self restoreDisplay];
            [self showAlert2];
        }
}

@end
