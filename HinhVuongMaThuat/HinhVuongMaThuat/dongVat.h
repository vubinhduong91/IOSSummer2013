//
//  dongVat.h
//  HinhVuongMaThuat
//
//  Created by hust6 on 5/11/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dongVat : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *description;
- (id) initWithName: (NSString *) name :(NSString *) image :(NSString *) description;
@end
