//
//  nineSquareVC.m
//  HinhVuongMaThuat
//
//  Created by hust6 on 5/6/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import "nineSquareVC.h"
#import "gameInfo.h"
#import "questionVC.h"
#import "ExplodeView.h"
#import "StarDustView.h"
#import <AVFoundation/AVFoundation.h>

#define kScreenWidth [UIScreen mainScreen].bounds.size.height
#define kScreenHeight [UIScreen mainScreen].bounds.size.width

@interface nineSquareVC () 

@property (weak, nonatomic) IBOutlet UIImageView *hiddenImage;

@property (weak, nonatomic) IBOutlet UIImageView *skeletonImage;

@property (nonatomic) int currentButton;
@property (nonatomic) int remaining;
@property (nonatomic) int remainingButton;
@property (weak, nonatomic) IBOutlet UILabel *currentLevelLabel;
@property (weak, nonatomic) IBOutlet UILabel *remaingItemLabel;
@property (weak, nonatomic) IBOutlet UILabel *becanLabel;
@property (weak, nonatomic) IBOutlet UILabel *dapannuaLabel;
@property (weak, nonatomic) IBOutlet UILabel *sauthithanghoacthuaLabel;


@property (weak, nonatomic) IBOutlet UIButton *homeButton;

@property (weak, nonatomic) IBOutlet UIButton *button0;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;

@property (nonatomic) NSArray *questionArray;

@property (strong,nonatomic) gameInfo *gameInfo;

@property (nonatomic) UIAlertView *homeAlert;
@property (nonatomic) UIAlertView *winAlert;
@property (nonatomic) UIAlertView *loseAlert;

@property (nonatomic) AVAudioPlayer *player;

@end

@implementation nineSquareVC



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(gameInfo *)gameInfo
{
    if(!_gameInfo)
    {
        _gameInfo = [[gameInfo alloc] init];
    }
    return _gameInfo;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self createQuestionArray];
    [self.remaingItemLabel setFont:[UIFont fontWithName:@"comic andy" size:40]];
    [self registedNotification];
    if(self.levelHasBeenChosen == 1)
    {
        UIImage *temp = [UIImage imageNamed:@"nen1.png"];
        [self.hiddenImage setImage:temp];
        self.currentLevelLabel.text = @"Cấp dễ";
        self.remaining = 4;
    }
    else if(self.levelHasBeenChosen == 2)
    {
        UIImage *temp = [UIImage imageNamed:@"nen2.png"];
        [self.hiddenImage setImage:temp];
        self.currentLevelLabel.text = @"Cấp trung bình";
        self.remaining = 6;
    }
    else if(self.levelHasBeenChosen == 3)
    {
        UIImage *temp = [UIImage imageNamed:@"nen3.png"];
        [self.hiddenImage setImage:temp];
        self.currentLevelLabel.text = @"Cấp khó";
        self.remaining = 8;
    }
    else if(self.levelHasBeenChosen == 4)
    {
        UIImage *temp = [UIImage imageNamed:@"nen4.png"];
        [self.hiddenImage setImage:temp];
        self.currentLevelLabel.text = @"Cấp cực khó";
        self.remaining = 9;
    }
    
    
    self.remaingItemLabel.text = [NSString stringWithFormat:@"%d",self.remaining];
    self.remainingButton = 9;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)returnToHome:(id)sender {
   // [self.navigationController popViewControllerAnimated:YES];
   [self showHomeAlert];
}

// pressed 1 of 9 button.
- (IBAction)squareButtonPressed:(UIButton *)sender {
    if(sender.tag != 100)
    {
        self.currentButton = sender.tag;
        self.remainingButton--;
        
      [self performSegueWithIdentifier:@"segueToQuestionView" sender:sender];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    questionVC *vc = [segue destinationViewController];
    NSString *tempSting = [self.questionArray objectAtIndex:(self.currentButton -1)];
    int temp = [tempSting integerValue];
    vc.tagOfButtonWasPressed =  temp;
}


-(void)registedNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(rightAnswer:)
                                                 name:@"right"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(wrongAnswer:)
                                                 name:@"wrong"
                                               object:nil];
}

-(void)rightAnswer:(id)notification
{
    //self.tempLabel.text = @"right";
    self.remaining--;
    self.remaingItemLabel.text = [NSString stringWithFormat:@"%d",self.remaining];
    [self makeCurrentButtonWork:1];
    if(self.remaining == 0) //win game.
    {
        [self winGame];
    }

    
}

-(void)wrongAnswer:(id)notification
{
    //self.tempLabel.text= @"wrong";
    [self makeCurrentButtonWork:0];
    if(self.remainingButton < self.remaining) //loseGame.
    {
        [self loseGame];
        //self.tempLabel.text = @"LOSE";
    }
}

-(void)makeCurrentButtonWork:(int)rigtOrWrong
{
    UIButton *temp = (UIButton *)[self.view viewWithTag:self.currentButton];
    if(rigtOrWrong) // right
    {
        [temp setHidden:YES];
      
    }
    else
    {
        UIImage *tempImage = [UIImage imageNamed:@"sai.png"];
        [temp setImage:tempImage forState:UIControlStateDisabled];
        [temp setEnabled:NO];
        //[temp setTitle:@"Wrong" forState:UIControlStateNormal];
    }
}

-(void)createQuestionArray
{
    NSMutableArray *temp = [[NSMutableArray alloc] initWithObjects:@0,@1,@2,@3,@4,@5,@6,@7,@8,@9,@10,@11,@12,@13,@14,@15,@16,@17,@18,@19,@20,@21,@22,@23,@24,@25,@26,@27,@28,nil];
   // NSLog(@"%@", temp);
    int j,i;
    for(j = 0 ; j < 1000; j++)
    {
    for(i=0;i<[temp count];i++)
    {
        int rand = arc4random_uniform([temp count]);
        [temp exchangeObjectAtIndex:i withObjectAtIndex:rand];
    }
    }
    
    self.questionArray = [temp subarrayWithRange:NSMakeRange(0, 9)];
    NSLog(@"%@", self.questionArray);
}

-(void)hiddenEvery
{
     [self.button0 setHidden:YES];
     [self.button1 setHidden:YES];
     [self.button2 setHidden:YES];
     [self.button3 setHidden:YES];
     [self.button4 setHidden:YES];
     [self.button5 setHidden:YES];
     [self.button6 setHidden:YES];
     [self.button7 setHidden:YES];
     [self.button8 setHidden:YES];
    [self.becanLabel setHidden:YES];
    
    [self.homeButton setHidden:YES];
    
    //[self.currentLevelLabel setHidden:YES];
    [self.remaingItemLabel setHidden:YES];
    [self.dapannuaLabel setHidden:YES];
     self.skeletonImage.alpha = 0;
}

-(void)winGame
{
    int temp = [self.gameInfo currentOpenedLevel];
    if(self.levelHasBeenChosen == temp)
    {
    [self.gameInfo OpennewLevel];
    }
    //choi nhac mario
    [self playLevelCompletedSound];
    
    [self hiddenEvery];
    self.currentLevelLabel.text = @"Chiến thắng !";
    self.sauthithanghoacthuaLabel.text = @"Bé đã vượt qua thử thách";
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(showStar) userInfo:nil repeats:NO];
    //start dust.
    int startX = 0;
    int endX = kScreenWidth + 200;
    int startY = kScreenHeight/2 - 50;
    
    StarDustView* stars = [[StarDustView alloc] initWithFrame:CGRectMake(startX, startY, 10, 10)];
    [self.hiddenImage addSubview:stars];
    [self.hiddenImage sendSubviewToBack:stars];
    
    [UIView animateWithDuration:5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         stars.center = CGPointMake(endX, startY);
                     } completion:^(BOOL finished) {
                         
                         //game finished
                         [stars removeFromSuperview];
                         
                         //when animation is finished, show alert
                         [self showThangAlert];
                     }];

    //////////
    
//    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(showThangAlert) userInfo:nil repeats:NO];
}

-(void)loseGame
{
    [self hiddenEvery];
    UIImage *tempImage = [UIImage imageNamed:@"nenover.png"];
    [self.hiddenImage setImage:tempImage];
    [self.hiddenImage setNeedsDisplay];
    self.currentLevelLabel.text = @"Thua cuộc :(";
    
    //choi nhac mario
    [self playGameOverSound];
    //UIImage *thuaImage = [UIImage imageNamed:@"AfterLooseTheGame.png"];
    //[self.hiddenImage setImage:thuaImage];
    self.sauthithanghoacthuaLabel.text = @"Thua keo này ta bầy keo khác";
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(showThuaAlert) userInfo:nil repeats:NO];
}

-(void)showHomeAlert
{
    
    self.homeAlert = [[UIAlertView alloc] initWithTitle:@"Trở lại màn hình chính" message:@"Bé có chắc chắn không?" delegate:self cancelButtonTitle:@"Có" otherButtonTitles:@"Không", nil];
    self.homeAlert.tag = 110;
    [self.homeAlert show];
}

-(void)showThangAlert
{
    
    self.winAlert = [[UIAlertView alloc] initWithTitle:@"Bé thật là giỏi" message:@"Hãy tiếp tục các trinh phục thử thách nào" delegate:self cancelButtonTitle:@"Tiếp tục" otherButtonTitles:nil, nil];
    self.winAlert.tag = 111;
    [self.winAlert show];
}

-(void)showThuaAlert
{
    self.loseAlert = [[UIAlertView alloc] initWithTitle:@"Có một chút nhầm lẫn chăng?" message:@"Dừng cuộc chơi ở đây :(" delegate:self cancelButtonTitle:@"Đồng ý" otherButtonTitles:nil, nil];
    self.loseAlert.tag = 112;
    [self.loseAlert show];
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(alertView.tag == 110)
    {
        if(buttonIndex == 0)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"stopMusic" object:nil userInfo:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }
    else if(alertView.tag == 111)
    {
        if(buttonIndex == 0)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else if(alertView.tag == 112)
    {
        if(buttonIndex == 0)
        {
             [[NSNotificationCenter defaultCenter] postNotificationName:@"stopMusic" object:nil userInfo:nil];
            //NSLog(@"here is the lose alertView");
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }

}

-(void)showStar
{
    CGFloat x = 20;
    CGFloat y = 33;
    CGFloat height = 200;
    CGFloat width = 200;
    
    //    // explode 0
    ExplodeView* explode = [[ExplodeView alloc] initWithFrame:CGRectMake(x,y,10,10)];
    [self.hiddenImage addSubview: explode];
    [self.hiddenImage sendSubviewToBack:explode];
    // explode 1
    ExplodeView* explode1 = [[ExplodeView alloc] initWithFrame:CGRectMake(x + width,y,10,10)];
    [self.hiddenImage addSubview: explode1];
    [self.hiddenImage sendSubviewToBack:explode1];
    //      // explode 2
    ExplodeView* explode2 = [[ExplodeView alloc] initWithFrame:CGRectMake(x + width, y + height,10,10)];
    [self.hiddenImage addSubview: explode2];
    [self.hiddenImage sendSubviewToBack:explode2];
    //      // explode e
    ExplodeView* explode3 = [[ExplodeView alloc] initWithFrame:CGRectMake(x,y + height,10,10)];
    [self.hiddenImage addSubview: explode3];
    [self.hiddenImage sendSubviewToBack:explode3];
    
}


-(void)playLevelCompletedSound
{
    NSString *soundFilePath =
    [[NSBundle mainBundle] pathForResource: @"levelComplete"
                                    ofType: @"mp3"];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer *newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: nil];
    self.player = newPlayer;
    newPlayer.volume = 1;
    [newPlayer prepareToPlay];
    [newPlayer play];
}

-(void)playGameOverSound
{
    NSString *soundFilePath =
    [[NSBundle mainBundle] pathForResource: @"gameOver"
                                    ofType: @"mp3"];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer *newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: nil];
    self.player = newPlayer;
    newPlayer.volume = 1;
    [newPlayer prepareToPlay];
    [newPlayer play];
}


@end
