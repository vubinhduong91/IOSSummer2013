//
//  levelVC.m
//  HinhVuongMaThuat
//
//  Created by hust6 on 5/9/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import "levelVC.h"
#import "gameInfo.h"
#import "nineSquareVC.h"

@interface levelVC ()
@property (nonatomic) UIAlertView *homeAlert,*clearAleart;
@property (weak, nonatomic) IBOutlet UIImageView *lock1;
@property (weak, nonatomic) IBOutlet UIImageView *lock2;
@property (weak, nonatomic) IBOutlet UIImageView *lock3;

@property (weak, nonatomic) IBOutlet UIButton *level2;
@property (weak, nonatomic) IBOutlet UIButton *level3;
@property (weak, nonatomic) IBOutlet UIButton *level4;

@property (strong, nonatomic) gameInfo *gameInfo;

@property (nonatomic) int chosenLevel;

@end

@implementation levelVC

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
   
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    int currentOpenedLevel = [self.gameInfo currentOpenedLevel];
    NSLog(@"i load %d",currentOpenedLevel);
    
    [self initLevel:currentOpenedLevel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)levelPressed:(UIButton *)sender {
    //not done yet.
    [self performSegueWithIdentifier:@"segueToNineSquare" sender:sender];
    self.chosenLevel = sender.tag;
    NSLog(@"sender.tag = %d",sender.tag);
}



- (IBAction)homePressed:(id)sender {
    [self showHomeAlert];
}



-(void)showHomeAlert
{
    
    self.homeAlert = [[UIAlertView alloc] initWithTitle:@"Trở lại màn hình chính" message:@"Bé có chắc chắn không?" delegate:self cancelButtonTitle:@"Có" otherButtonTitles:@"Không", nil];
    self.homeAlert.tag = 1;
    [self.homeAlert show];
    
}

-(void)showClearAlert
{
    
    self.clearAleart = [[UIAlertView alloc] initWithTitle:@"Mục đích kiểm thử" message:@"Bạn muốn khóa các cấp độ lại như ban đầu ?" delegate:self cancelButtonTitle:@"Có" otherButtonTitles:@"Không", nil];
    self.clearAleart.tag = 2;
    [self.clearAleart show];
}



-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1)
    {
    if(buttonIndex == 0)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"stopMusic" object:nil userInfo:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
    }
    else if(alertView.tag == 2)
    {
    if(buttonIndex == 0)
        {
        [self.gameInfo clearData];
        [self initLevel:1];
        }
    }
}


-(void)initLevel:(int)currentOpenedLevel
{
    if(currentOpenedLevel == 1)
    {
        [self.lock1 setHidden:NO];
        [self.lock2 setHidden:NO];
        [self.lock3 setHidden:NO];
        [self.level2 setEnabled:NO];
        [self.level3 setEnabled:NO];
        [self.level4 setEnabled:NO];
    }
    else if(currentOpenedLevel == 2)
    {
        [self.lock1 setHidden:YES];
        [self.lock2 setHidden:NO];
        [self.lock3 setHidden:NO];
        [self.level2 setEnabled:YES];
        [self.level3 setEnabled:NO];
        [self.level4 setEnabled:NO];
    }
    else if(currentOpenedLevel == 3)
    {
        [self.lock1 setHidden:YES];
        [self.lock2 setHidden:YES];
        [self.lock3 setHidden:NO];
        [self.level2 setEnabled:YES];
        [self.level3 setEnabled:YES];
        [self.level4 setEnabled:NO];
    }
    else if(currentOpenedLevel == 4)
    {
        [self.lock1 setHidden:YES];
        [self.lock2 setHidden:YES];
        [self.lock3 setHidden:YES];
        [self.level2 setEnabled:YES];
        [self.level3 setEnabled:YES];
        [self.level4 setEnabled:YES];
    }

    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    nineSquareVC *vc = [segue destinationViewController];
    vc.levelHasBeenChosen = sender.tag;
    NSLog(@"chosen level :%d", vc.levelHasBeenChosen);
}

///debug
- (IBAction)restartAAA:(id)sender {
    [self showClearAlert];
}

@end
