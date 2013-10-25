//
//  questionVC.m
//  HinhVuongMaThuat
//
//  Created by hust6 on 5/6/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import "questionVC.h"
#import "nineSquareVC.h"
#import "QuestionModel.h"
#import "ExplodeView.h"
#import <AVFoundation/AVFoundation.h>

@interface questionVC ()
@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;
@property (weak, nonatomic) IBOutlet UIImageView *topImage;
@property (weak, nonatomic) IBOutlet UIImageView *questionSkeletonImage;

@property (weak, nonatomic) IBOutlet UIButton *answer0;
@property (weak, nonatomic) IBOutlet UIButton *answer1;
@property (weak, nonatomic) IBOutlet UIButton *answer2;
@property (weak, nonatomic) IBOutlet UIButton *answer3;


@property (nonatomic) int correct;
@property (nonatomic) UIAlertView *rightAlert;
@property (nonatomic) UIAlertView *wrongAlert;

@property (nonatomic) AVAudioPlayer *player;

@end

@implementation questionVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   // NSLog(@"%d", self.tagOfButtonWasPressed);
    self.topImage.alpha = 0;
    [self initQuestion];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initQuestion
{
    QuestionModel *model = [[QuestionModel alloc] init];
    //need change
    NSMutableArray *array = [model getQuestion:self.tagOfButtonWasPressed];
    NSString *questionDetail = array[0];
    NSString *imageName = array[1];
    self.question.text = questionDetail;
    [self.image setImage:[UIImage imageNamed:imageName]];
    [self.answer0 setTitle:array[2][0] forState:UIControlStateNormal];
    [self.answer1 setTitle:array[2][1] forState:UIControlStateNormal];
    [self.answer2 setTitle:array[2][2] forState:UIControlStateNormal];
    [self.answer3 setTitle:array[2][3] forState:UIControlStateNormal];
    NSString *questionCorrect = array[3];
    self.correct = [questionCorrect integerValue];
//init cover images.
    NSArray *temp = [[NSArray alloc] initWithObjects:@"che1.png",@"che2.png",@"che3.png",@"che4.png", nil];
    int rand = arc4random_uniform(4);
    UIImage *tempImage = [UIImage imageNamed:[temp objectAtIndex:rand]];
    [self.coverImage setImage:tempImage];
    
}



- (IBAction)answerPressed:(UIButton *)sender {
    [self hiddenAllButton];
    if(sender.tag == self.correct)
    {
        [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(showStar) userInfo:nil repeats:NO];
       
        
        UIImage *temp = [UIImage imageNamed:@"right.png"];
        [self.topImage setImage:temp];
        self.topImage.alpha = 1;
        
        //play sound
        [self playCorrectAnswerSound];
        
        [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(showCorrectMessage) userInfo:nil  repeats:(NO)];
        
        self.coverImage.alpha = 0;
        self.questionSkeletonImage.alpha = 0;
        
    }
    else
    {
       // [self showMessage:0];
        self.image.alpha = 0;
        
        UIImage *temp = [UIImage imageNamed:@"wrong.png"];
        [self.topImage setImage:temp];
        self.topImage.alpha = 1;
        self.questionSkeletonImage.alpha = 0;
        
        //play sound
        [self playWrongAnswerSound];
        
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showWrongMessage) userInfo:nil  repeats:(NO)];
        
        
    }
    
}

-(void)showCorrectMessage
{
     
        self.rightAlert = [[UIAlertView alloc] initWithTitle:@"Chúc mừng" message:@"Bé đã trả lời chính xác :)" delegate:self cancelButtonTitle:@"Tiếp tục" otherButtonTitles:nil , nil];
        self.rightAlert.tag = 1;
        [self.rightAlert show];
}

    
-(void)showWrongMessage
{
        self.wrongAlert = [[UIAlertView alloc] initWithTitle:@"Thật tiếc" message:@"Bé đã trả lời sai :(" delegate:self cancelButtonTitle:@"Tiếp tục" otherButtonTitles:nil , nil];
        self.wrongAlert.tag = 2;
        [self.wrongAlert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1)
    {
        if(buttonIndex == 0)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"right" object:nil userInfo:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }
    else if(alertView.tag == 2)
        {
        if(buttonIndex == 0)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wrong" object:nil userInfo:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        }
}

-(void)hiddenAllButton
{
    [self.question setHidden:YES];
    [self.answer0 setHidden:YES];
    [self.answer1 setHidden:YES];
    [self.answer2 setHidden:YES];
    [self.answer3 setHidden:YES];
}


-(void)playCorrectAnswerSound
{
    NSString *soundFilePath =
    [[NSBundle mainBundle] pathForResource: @"win"
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

-(void)playWrongAnswerSound
{
    NSString *soundFilePath =
    [[NSBundle mainBundle] pathForResource: @"wrong"
                                    ofType: @"m4a"];
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: soundFilePath];
    
    AVAudioPlayer *newPlayer =
    [[AVAudioPlayer alloc] initWithContentsOfURL: fileURL
                                           error: nil];
    self.player = newPlayer;
    newPlayer.volume = 1;
    [newPlayer prepareToPlay];
    [newPlayer play];
}


-(void)showStar
{
    ExplodeView* explode = [[ExplodeView alloc] initWithFrame:CGRectMake(140,100,10,10)];
    [self.image addSubview: explode];
    [self.image sendSubviewToBack:explode];
}

@end
