//
//  helpVC.m
//  finalVer1
//
//  Created by hust6 on 4/26/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import "helpVC.h"

@interface helpVC ()
@property (weak, nonatomic) IBOutlet UITextView *helpText;

@end

@implementation helpVC

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
    NSString *text = @"- Welcome to help :)\n Some help to help you use the App better:\n-If you want to fall as sleep: Select the \"White sheep\" Button.\n-If you want to see your sleep Graph , click on the \"Sleeping guy\" button.\n-When you want to sleep,click on the Big white shit in the top center of the screen,or wait until the time come to 0 and clicked sleep button, -In case that you fall as sleep but forget to sleep the app manually, No worry the app will sleep automatically after \"the waitng time\"\n-On the graph, the small switch button will help you switch from Time ( Fall asleep, and wake up time) to Duration ( length of your sleep) and vice versa\n If you read this line Congratulation you have made it! That is all you need. Thanks and hope you have a good night :)";
    self.helpText.text = text;
	// Do any additional setup after loading the view.
}
- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
