//
//  Project.m
//  TVVN
//
//  Created by James Cremer on 3/7/13.
//  Copyright (c) 2013 James Cremer. All rights reserved.
//

#import "animal1.h"

@implementation animal

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
