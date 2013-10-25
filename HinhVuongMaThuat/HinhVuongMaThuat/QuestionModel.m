//
//  QuestionModel.m
//  hinhVuongMaThuat
//
//  Created by hust6 on 3/31/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import "QuestionModel.h"

@interface QuestionModel ()
@property (nonatomic) int questionNumber;
@end

@implementation QuestionModel



- (NSMutableArray *) readFromPlist{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
        int temp = [array count];
        NSLog(@"Shit here %d",temp);
    NSMutableArray *question;
    question = [[NSMutableArray alloc] initWithCapacity:4];
    for (NSDictionary *dict in array) {
        
        NSString *id = [dict objectForKey:@"QuestionId"];
        int temp = [id integerValue];
        if(temp == self.questionNumber)
            {
        
            NSString *questionDetail = [dict objectForKey:@"Question"];
     
            NSString *questionImage = [dict objectForKey:@"Image"];
            NSMutableArray *questionAnswers = [dict objectForKey:@"Answers"];
            NSString *questionCorrect = [dict objectForKey:@"Correct"];
            question[0] = questionDetail;
            question[1] = questionImage;
            question[2] = questionAnswers;
            question[3] = questionCorrect;
            }
        }
  
    return question;
   
}

-(NSMutableArray *)getQuestion:(int) questionNumber{
    self.questionNumber = questionNumber;
    return [self readFromPlist];
}

@end
