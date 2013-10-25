//
//  appSetting.m
//  finalVer1
//
//  Created by hust6 on 4/28/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import "appSetting.h"
@interface appSetting ()
@property (strong, nonatomic) NSUserDefaults *userDefault;
@end

@implementation appSetting

-(NSUserDefaults *)userDefault
{
    if(!_userDefault)
    {
        _userDefault = [NSUserDefaults standardUserDefaults];
    }
    return _userDefault;
}

-(void)upDateSetting:(NSDictionary *)newSetting
{
    [self.userDefault setObject:newSetting forKey:@"userSetting"];
    
}

-(NSDictionary *)getSettingValue
{
    // index - 0, level.
    // index - 1, counting time.
    // index - 2, waiting time.
    
    //for the first time
    NSDictionary *temp = [self.userDefault objectForKey:@"userSetting"];
    if([temp count] == 0)
    {
        int level = 4;
        int count = 60;
        int wait = 60;
        NSString *music = @"App Music";
        NSDictionary *temp = [[NSDictionary alloc] initWithObjectsAndKeys:
                               [NSNumber numberWithInt:level], @"level",
                               [NSNumber numberWithInt:count], @"countingTime",
                               [NSNumber numberWithInt:wait] , @"waitingTime",
                              music, @"music"
                               , nil];
        [self.userDefault setObject:temp forKey:@"userSetting"];
        return temp;
}
return temp;
}

@end
