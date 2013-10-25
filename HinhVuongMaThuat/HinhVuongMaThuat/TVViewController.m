//
//  TVViewController.m
//  HinhVuongMaThuat
//
//  Created by hust6 on 5/11/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import "TVViewController.h"
#import "dongVat.h"
#import "danhSachDongVat.h"
#import "thongTinChiTietVeDongVat.h"

@interface TVViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) danhSachDongVat *listOfAnimal;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation TVViewController

- (danhSachDongVat *)listOfAnimal {
	if (!_listOfAnimal) {
		_listOfAnimal = [[danhSachDongVat alloc] init];
        _listOfAnimal.type = self.animaltype;
        NSLog(@"animal type %d", self.animaltype);
        [_listOfAnimal InitTheList];
	}
	return  _listOfAnimal;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)  tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.listOfAnimal numberOfProjects];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger cellnum = indexPath.row;
	UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"projectCell"];
	cell.textLabel.text = [self.listOfAnimal animalName:cellnum];
	return cell;
    
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
    thongTinChiTietVeDongVat *infoVC = segue.destinationViewController;
    NSInteger selectedCell = [self.tableView  indexPathForSelectedRow].row;
    infoVC.animalImage = [self.listOfAnimal animalImage:selectedCell];
    infoVC.animalDescription = [self.listOfAnimal animalDescription:selectedCell];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnToChoiLoaiDongVat:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
