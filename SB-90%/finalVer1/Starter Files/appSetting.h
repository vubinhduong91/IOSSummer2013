//
//  appSetting.h
//  finalVer1
//
//  Created by hust6 on 4/28/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface appSetting : NSObject

-(void)upDateSetting:(NSDictionary *)newSetting;

-(NSDictionary *)getSettingValue;

@end
