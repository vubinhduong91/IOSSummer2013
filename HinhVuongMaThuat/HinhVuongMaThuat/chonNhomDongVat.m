//
//  chonNhomDongVat.m
//  HinhVuongMaThuat
//
//  Created by hust6 on 5/11/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import "chonNhomDongVat.h"
#import "TVViewController.h"

@interface chonNhomDongVat ()
@property (nonatomic) int temp;

@end

@implementation chonNhomDongVat

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)segueToTV:(UIButton *)sender {
      self.temp = sender.tag;
    [self performSegueWithIdentifier:@"segueToTableView" sender:nil];
  
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    TVViewController *vc = [segue destinationViewController];
    vc.animaltype = self.temp;
    NSLog(@"temp la:%d",self.temp);
}
- (IBAction)returnToMainMenu:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"stopMusic" object:nil userInfo:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
