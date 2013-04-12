//
//  UIColor+Random.m
//  Draw
//
//  Created by Håvard Fossli on 19.06.12.
//  Copyright (c) 2012 Håvard Fossli. All rights reserved.
//

#import "UIColor+Random.h"

@implementation UIColor (Random)

+ (UIColor *)randomColorWithAlphaMin:(CGFloat)alphaMin alphaMax:(CGFloat)alphaMax {
    
    CGFloat red = (CGFloat)(rand() % 10) / 10.0;
    CGFloat blue = (CGFloat)(rand() % 10) / 10.0;
    CGFloat green = (CGFloat)(rand() % 10) / 10.0;
    CGFloat randomAlpha = (CGFloat)(rand() % 10) / 10.0;
    
    CGFloat alpha = MAX(alphaMin, MIN(randomAlpha, alphaMax));
    
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    return randomColor;
}

@end