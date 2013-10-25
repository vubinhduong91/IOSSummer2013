//
//  modelForGraph.h
//  sleepingMain
//
//  Created by hust6 on 4/13/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface modelForGraph : NSObject
-(NSArray *)datesForGraph;
-(NSArray *)sleepForGraph;
-(NSArray *)wakeForGraph;
-(NSArray *)lengthForGraph;
-(void)updateAfterWakeUp:(NSString *)dates :(float)sleep :(float)wake :(float)length:(int)newSheepComeToUs;

-(NSString *)averageSleepingTime;

-(NSString *)shortestSleepingTime;

-(NSString *)longestSleepingTime;

-(int)totalSheepsHadBeenCounted;

@end
