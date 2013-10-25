//
//  CPDSleepingBeauty.m
//  SleepingGraph
//
//  Created by hust6 on 4/12/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import "CPDSleepingBeauty.h"
#import "CPDConstants.h"
#import "modelForGraph.h"

@interface CPDSleepingBeauty() 
@property (strong, nonatomic) modelForGraph *modelForGraph;
@end

@implementation CPDSleepingBeauty

-(modelForGraph *)modelForGraph
    {
        if(!_modelForGraph)
        {
            _modelForGraph = [[modelForGraph alloc] init];
        }
        return _modelForGraph;
    }

#pragma mark- Class method
+(CPDSleepingBeauty *)shareInstance
{
    static CPDSleepingBeauty *sharInstance;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharInstance = [[self alloc] init];
    });
    return sharInstance;
}


-(NSArray *)dates{
//    NSArray *dates = nil;
//    if(!dates){
      NSArray  *dates = [NSArray arrayWithArray:[self.modelForGraph datesForGraph]];
 //   }

return dates;
}

-(NSArray *)monthlyData:(NSString *)type{
    if([CPDSleep isEqualToString:[type uppercaseString]] == YES)
    {
        return [self SleepData];
    }
    else if([CPDWake isEqualToString:[type uppercaseString]] == YES)
    {
        return [self WakeData];
    }
    else if([CPDLength isEqualToString:[type uppercaseString]] == YES)
    {
        return [self LengthData];
    }
    return [NSArray array];
}

-(NSArray *)SleepData{
//    static NSArray *sleep = nil;
//    if(!sleep){
      NSArray  *sleep = [NSArray arrayWithArray:[self.modelForGraph sleepForGraph]];
 //   }
    return sleep;
}

-(NSArray *)WakeData{
//    static NSArray *wake = nil;
//    if(!wake){
        NSArray  *wake = [NSArray arrayWithArray:[self.modelForGraph wakeForGraph]];
//    }
    return wake;
}

-(NSArray *)LengthData{
//    static NSArray *length = nil;
//    if(!length){
        NSArray  *length = [NSArray arrayWithArray:[self.modelForGraph lengthForGraph]];
 //   }
    return length;
    }



@end
