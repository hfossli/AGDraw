//
//  AGColorHelper.h
//  Draw
//
//  Created by Håvard Fossli on 20.06.12.
//  Copyright (c) 2012 Håvard Fossli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGColorPalette : NSObject

@property (nonatomic, retain) NSArray *colors;
@property (nonatomic, retain) UIColor *backgroundColor;
@property (nonatomic, retain) UIColor *shadowColor;
@property (nonatomic, retain) NSString *source;
@property (nonatomic, retain) NSString *name;

- (UIColor *)pickRandomColor;

@end

@interface AGColorHelper : NSObject

+ (NSArray *)allPalettes;
+ (AGColorPalette *)pickRandomPalette;

@end
