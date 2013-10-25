//
//  danhSachDongVat.h
//  HinhVuongMaThuat
//
//  Created by hust6 on 5/11/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface danhSachDongVat : NSObject

@property (nonatomic) int type;

-(NSInteger) numberOfProjects;

-(NSString *) animalName:(int) index;
-(NSString *) animalImage:(int) index;
-(NSString *) animalDescription:(int)index;

- (void)InitTheList;

@end
