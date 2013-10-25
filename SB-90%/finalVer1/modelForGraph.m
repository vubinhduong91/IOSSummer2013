//
//  modelForGraph.m
//  sleepingMain
//
//  Created by hust6 on 4/13/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//
//Store max for 14 days.

#import "modelForGraph.h"
#define expire 14


@interface modelForGraph ()
@property (strong,  nonatomic) NSMutableArray *date;
@property (strong , nonatomic) NSMutableArray *sleep;
@property (strong , nonatomic) NSMutableArray *wake;
@property (strong , nonatomic) NSMutableArray *length;
@property (weak ,nonatomic) NSUserDefaults *userDefault;

@end

@implementation modelForGraph

-(NSMutableArray *)date{
    if(!_date){
        _date = [[NSMutableArray alloc] init];
    }
    return _date;
}

-(NSMutableArray *)sleep{
    if(!_sleep){
        _sleep = [[NSMutableArray alloc] init];
    }
    return _sleep;
}

-(NSMutableArray *)wake{
    if(!_wake){
        _wake = [[NSMutableArray alloc] init];
    }
    return _wake;
}

-(NSMutableArray *)length{
    if(!_length){
        _length = [[NSMutableArray alloc] init];
    }
    return _length;
}

-(NSUserDefaults *)userDefault{
    if(!_userDefault)
    {
        _userDefault = [NSUserDefaults standardUserDefaults];
    }
    return _userDefault;
}


-(NSArray *)datesForGraph
{
    NSArray *temp = [self.userDefault objectForKey:@"dates"];
    return temp;
}

-(NSArray *)sleepForGraph
{
    NSArray *temp = [self.userDefault objectForKey:@"sleep"];
    return temp;
}

-(NSArray *)wakeForGraph
{
    NSArray *temp = [self.userDefault objectForKey:@"wake"];
    return temp;
}

-(NSArray *)lengthForGraph
{
    NSArray *temp = [self.userDefault objectForKey:@"length"];
    return temp;
}

// handle array.
-(NSArray *)handleNSString:(NSArray *)inputArray :(NSString *)newElement
{
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:inputArray];
    [tempArray removeObjectAtIndex:0];
    [tempArray addObject:newElement];
    NSArray *returnArray = [[NSArray alloc] initWithArray:tempArray];
    return returnArray;
}
-(NSArray *)handleFloat:(NSArray *)inputArray :(float)newElement
{
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:inputArray];
    [tempArray removeObjectAtIndex:0];
    [tempArray addObject:[NSNumber numberWithFloat:newElement]];
    NSArray *returnArray = [[NSArray alloc] initWithArray:tempArray];
    return returnArray;
}


-(void)updateAfterWakeUp:(NSString *)dates :(float) sleep :(float) wake :(float) length:(int) newSheepComeToUs
{
    
    NSArray *temp = [self.userDefault objectForKey:@"dates"];
    NSLog (@"%@", temp);
    if(temp == nil) // fisrt time.
    {
        NSArray *datesArray = [NSArray arrayWithObject:dates];
        [self.userDefault setObject:datesArray forKey:@"dates"];
        
        NSArray *sleepArray = [NSArray arrayWithObject:[NSNumber numberWithFloat:sleep]];
        [self.userDefault setObject:sleepArray forKey:@"sleep"];
        
        NSArray *wakeArray = [NSArray arrayWithObject:[NSNumber numberWithFloat:wake]];
        [self.userDefault setObject:wakeArray forKey:@"wake"];
        
        NSArray *lengthArray = [NSArray arrayWithObject:[NSNumber numberWithFloat:length]];
        [self.userDefault setObject:lengthArray forKey:@"length"];
        
        int sheep = 0;
        [self.userDefault setObject:
         [NSNumber numberWithInt:sheep] forKey:@"totalSheeps"];
        
        //NSLog(@" I am here: %@", sleepArray);
        
    }
    else // not the first time
        // YOu need to handle when > expire.
    {
        if([temp count] < expire)
        {
        self.date = [NSMutableArray arrayWithArray:[self datesForGraph]];
        [self.date addObject:dates];
        NSArray *datesArray = [[NSArray alloc] initWithArray:self.date];
        [self.userDefault setObject:datesArray forKey:@"dates"];

        
        self.sleep = [NSMutableArray arrayWithArray:[self sleepForGraph]];
        [self.sleep addObject:[NSNumber numberWithFloat:sleep]];
        NSArray *sleepArray = [[NSArray alloc] initWithArray:self.sleep];
        [self.userDefault setObject:sleepArray forKey:@"sleep"];
        
        self.wake = [NSMutableArray arrayWithArray:[self wakeForGraph]];
        [self.wake addObject:[NSNumber numberWithFloat:wake]];
        NSArray *wakeArray = [[NSArray alloc] initWithArray:self.wake];
        [self.userDefault setObject:wakeArray forKey:@"wake"];
        
        self.length = [NSMutableArray arrayWithArray:[self lengthForGraph]];
        [self.length addObject:[NSNumber numberWithFloat:length]];
        NSArray *lengthArray = [[NSArray alloc] initWithArray:self.length];
        [self.userDefault setObject:lengthArray forKey:@"length"];
            
        }
        
        else if([temp count] == expire)
        {
            NSArray *datesArray = [[NSArray alloc] initWithArray:[self handleNSString:[self datesForGraph] :dates]];
            [self.userDefault setObject:datesArray forKey:@"dates"];
            
            NSArray *sleepArray = [[NSArray alloc] initWithArray:[self handleFloat:[self sleepForGraph] :sleep]];
            [self.userDefault setObject:sleepArray forKey:@"sleep"];
            
            NSArray *wakeArray = [[NSArray alloc] initWithArray:[self handleFloat:[self wakeForGraph] :wake]];
            [self.userDefault setObject:wakeArray forKey:@"wake"];
            
            NSArray *lengthArray = [[NSArray alloc] initWithArray:[self handleFloat:[self lengthForGraph] :length]];
            [self.userDefault setObject:lengthArray forKey:@"length"];
            
    
                        
        }
        int temp = [[self.userDefault objectForKey:@"totalSheeps"] integerValue];
        temp += newSheepComeToUs;
        [self.userDefault setObject:[NSNumber numberWithInteger:temp] forKey:@"totalSheeps"];
    }
    
    //synchornize
    if([self.userDefault synchronize] == YES)
    {
        NSLog(@"synchronize done!");
    }
}
//Here i am stop.



-(NSString *)averageSleepingTime
{
    NSArray *length = [self.userDefault objectForKey:@"length"];
    int i;
    float sum = 0;
    float avg;
    int totalElements = [length count];
    for(i = 0 ; i < totalElements; i++)
    {
        sum = sum + [[length objectAtIndex:i] floatValue];
    }
    avg = sum / totalElements;
    avg = [self rounded:avg];
     NSString *averageSleepingTime = [NSString stringWithFormat:@"%.2f hours",avg];
    return averageSleepingTime;
}

-(NSString *)shortestSleepingTime
{
    NSArray *length = [self.userDefault objectForKey:@"length"];
    NSArray *dates = [self.userDefault objectForKey:@"dates"];
    int i,j;
    float shortest;
    int totalElements = [length count];
    int temp;
    shortest = [[length objectAtIndex:0] floatValue];
    for(i = 1 ; i < totalElements; i++)
    {
        temp = [[length objectAtIndex:i] floatValue];
        if(temp< shortest)
        {
        shortest = temp;
        }
    }
    NSString *string;
    for(j = 0; j < totalElements; j++)
    {
        if([[length objectAtIndex:j] floatValue] == shortest)
        {
            string = [dates objectAtIndex:j];
            break;
        }
    }
    
    NSString *shortestSleepTime = [NSString stringWithFormat:@"%.2f hours on %@", [self rounded:shortest], string];
    return shortestSleepTime;
}

-(NSString *)longestSleepingTime
{
    NSArray *length = [self.userDefault objectForKey:@"length"];
    NSArray *dates = [self.userDefault objectForKey:@"dates"];
    int i,j;
    float longest;
    int totalElements = [length count];
    int temp;
    longest = [[length objectAtIndex:0] floatValue];
    for(i = 1 ; i < totalElements; i++)
    {
        temp = [[length objectAtIndex:i] floatValue];
        if(temp > longest)
        {
            longest = longest;
        }
    }
    NSString *string;
    for(j = 0; j < totalElements; j++)
        {
            if([[length objectAtIndex:j] floatValue] == longest)
            {
                string = [dates objectAtIndex:j];
                break;
            }
        }
    NSString *longestSleepTime = [NSString stringWithFormat:@"%.2f hours on %@", [self rounded:longest],string];
    return longestSleepTime;
}

-(int)totalSheepsHadBeenCounted
{
    return [[self.userDefault objectForKey:@"totalSheeps"] integerValue];
}


-(float)rounded:(float) value
{
    value = value * 100;
    value = roundf(value);
    value = value / 100;
    return value;
}

@end

