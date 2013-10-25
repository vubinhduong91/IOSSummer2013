//
//  thongTinChiTietVeDongVat.m
//  HinhVuongMaThuat
//
//  Created by hust6 on 5/11/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import "thongTinChiTietVeDongVat.h"

@interface thongTinChiTietVeDongVat ()
@property (weak, nonatomic) IBOutlet UIImageView *animialImageView;
@property (weak, nonatomic) IBOutlet UITextView *animalInfomationTextView;

@end

@implementation thongTinChiTietVeDongVat

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
    [self initInfomation];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initInfomation
{
    UIImage *image = [UIImage imageNamed:self.animalImage];
    [self.animialImageView setImage:image];
    self.animalInfomationTextView.text = self.animalDescription;
    
}
- (IBAction)backToTV:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)returnToMainMenu:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"stopMusic" object:nil userInfo:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
