//
//  gioiThieuVC.m
//  HinhVuongMaThuat
//
//  Created by hust6 on 5/11/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import "gioiThieuVC.h"

@interface gioiThieuVC ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation gioiThieuVC


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
    NSString *gioiThieu = @"Trò chơi \nÔ màu kì diệu\nNhóm 11.Các thành viên:\n 1.Vũ Bình Dương\n2.Đoàn Quang Diện\n3.Trương Ngọc Hiếu\n4.Lãnh Hùng Sơn\n. Dưới sự hướng dẫn nhiệt tình của giảng viên:\n Nguyễn Thị Hương Giang\nPhân công việc: Lập trình: Vũ Bình Dương, Trương Ngọc Hiếu, Đoàn Quang Diện, Lãnh Hùng Sơn\nThiết kế:Trương Ngọc Hiếu, Lãnh Hùng Sơn\nÂm thanh và nội dung trò chơi:Đoàn Quang Diện,Vũ Bình Dương\n Quá trình kiểm thử được cả nhóm cùng thực hiện\n Xin cám ơn!";
    self.textView.text = gioiThieu;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)returnToMainMenu:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



@end
