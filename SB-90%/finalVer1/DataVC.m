//
//  DataVC.m
//  finalVer1
//
//  Created by hust6 on 4/26/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import "DataVC.h"
#import "modelForGraph.h"

@interface DataVC ()
@property (weak, nonatomic) IBOutlet UILabel *avg;
@property (weak, nonatomic) IBOutlet UILabel *shortest;
@property (weak, nonatomic) IBOutlet UILabel *longest;
@property (weak, nonatomic) IBOutlet UILabel *sheep;
@property (strong ,nonatomic) modelForGraph *model;
@end

@implementation DataVC

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(([[self.model shortestSleepingTime] floatValue]*[[self.model longestSleepingTime] floatValue]) != 0)
    {
    self.avg.text = [self.model averageSleepingTime];
    self.shortest.text = [self.model shortestSleepingTime];
    self.longest.text = [self.model longestSleepingTime];
    }
    else
    {
        self.avg.text = @"It is too small";
        self.shortest.text = @":)";;
        self.longest.text = @":)";;
    }
    self.sheep.text = [NSString stringWithFormat:@"%d",[self.model totalSheepsHadBeenCounted]];
	// Do any additional setup after loading the view.
}

-(modelForGraph *)model
{
    if(!_model)
    {
        _model = [[modelForGraph alloc] init];
    }
    return _model;
}





- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"@_@");
    // Dispose of any resources that can be recreated.
}

@end
