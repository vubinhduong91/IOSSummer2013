//
//  SpriteModel.h
//  finalVer1
//
//  Created by hust6 on 4/27/13.
//  Copyright (c) 2013 hust6. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Sprite)

-(NSArray *)spritesWithSpriteSheetImage:(UIImage *)image inRange:(NSRange)range spriteSize:(CGSize)size;

@end