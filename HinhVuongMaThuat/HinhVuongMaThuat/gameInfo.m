//
//  gameInfo.m
//  HinhVuongMaThuat
//
//  Created by hust6 on 5/9/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import "gameInfo.h"

@interface gameInfo ()
@property (weak, nonatomic) NSUserDefaults *userDefault;
@end
@implementation gameInfo
-(NSUserDefaults *)userDefault
{
    if(!_userDefault)
    {
        _userDefault = [NSUserDefaults standardUserDefaults];
    }
    return _userDefault;
}

-(int)currentOpenedLevel
{
    NSLog(@"i am in current Opend Level");
    NSString *temp = [self.userDefault objectForKey:@"currentOpenedLevel"];
    int value = [temp integerValue];
    if(temp == nil)
    {
        NSString *initValue = @"1";
        [self.userDefault setObject:initValue forKey:@"currentOpenedLevel"];
        return 1;
    }
    else return value;
    
}
-(void)OpennewLevel
{
    NSString *temp = [self.userDefault objectForKey:@"currentOpenedLevel"];
    int value = [temp integerValue];
    if(value < 4)
    {
        value++;
        NSString *tempString = [NSString stringWithFormat:@"%d", value];
        [self.userDefault setObject:tempString forKey:@"currentOpenedLevel"];
    }
}
-(void)clearData
{
   // NSString *initValue = @"1";
    NSLog(@"Sao khong chay vao day nhi");
    [self.userDefault setObject:nil forKey:@"currentOpenedLevel"];
}

@end
