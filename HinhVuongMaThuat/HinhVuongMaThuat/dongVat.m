//
//  dongVat.m
//  HinhVuongMaThuat
//
//  Created by hust6 on 5/11/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import "dongVat.h"

@implementation dongVat
- (id) initWithName: (NSString *) name :(NSString *) image :(NSString *) description
{
    self = [super init];
    if(self)
    {
        _name = name;
        _image = image;
        _description = description;
    }
    return self;
}

- (id) init {
	return  [self initWithName:@"no name" :nil :nil];
}



@end
