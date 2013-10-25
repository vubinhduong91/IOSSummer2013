//
//  CPDSleepingBeauty.h
//  SleepingGraph
//
//  Created by hust6 on 4/12/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPDSleepingBeauty : NSObject

+(CPDSleepingBeauty *)shareInstance;

-(NSArray *)dates;
-(NSArray *)monthlyData:(NSString *)type;

@end
