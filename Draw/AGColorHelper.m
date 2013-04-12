//
//  AGColorHelper.m
//  Draw
//
//  Created by Håvard Fossli on 20.06.12.
//  Copyright (c) 2012 Håvard Fossli. All rights reserved.
//

#import "AGColorHelper.h"

@implementation AGColorPalette

- (id)init {
    self = [super init];
    if(self) {
        
        self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
        self.shadowColor = [UIColor colorWithWhite:0.0 alpha:0.4];

    }
    return self;
}

- (UIColor *)pickRandomColor {
    NSUInteger randomIndex = arc4random() % [self.colors count];
    return [self.colors objectAtIndex:randomIndex];
}

@end

@implementation AGColorHelper

+ (NSArray *)allPalettes {
    
    static NSArray *s_allPaletts;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        AGColorPalette *p1 = [[AGColorPalette alloc] init];
        p1.backgroundColor = [UIColor colorWithRed:20.0/255.0 green:20.0/255.0 blue:20.0/255.0 alpha:1.0];
        p1.colors = [NSArray arrayWithObjects:
                     [UIColor colorWithRed:38.0/255.0 green:24.0/255.0 blue:34.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:38.0/255.0 green:24.0/255.0 blue:34.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:115.0/255.0 green:22.0/255.0 blue:48.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:204.0/255.0 green:30.0/255.0 blue:44.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:255.0/255.0 green:84.0/255.0 blue:52.0/255.0 alpha:1.0],
                     nil];
        p1.source = @"http://kuler.adobe.com/#themeID/1928864";
        
        AGColorPalette *p2 = [[AGColorPalette alloc] init];
        p2.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
        p2.colors = [NSArray arrayWithObjects:
                     [UIColor colorWithRed:91.0/255.0 green:204.0/255.0 blue:248.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:244.0/255.0 green:184.0/255.0 blue:4.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:250.0/255.0 green:252.0/255.0 blue:35.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:250.0/255.0 green:189.0/255.0 blue:6.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:255.0/255.0 green:83.0/255.0 blue:8.0/255.0 alpha:1.0],
                     nil];
        p2.source = @"http://www.colourlovers.com/pattern/2638644/Ill_Follow";
        
        AGColorPalette *p3 = [[AGColorPalette alloc] init];
        p3.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
        p3.colors = [NSArray arrayWithObjects:
                     [UIColor colorWithRed:208.0/255.0 green:106.0/255.0 blue:101.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:154.0/255.0 green:86.0/255.0 blue:101.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:127.0/255.0 green:94.0/255.0 blue:105.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:45.0/255.0 green:87.0/255.0 blue:101.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:131.0/255.0 green:158.0/255.0 blue:123.0/255.0 alpha:1.0],
                     nil];
        p3.source = @"http://www.colourlovers.com/palette/2240035/disposition";
        
        AGColorPalette *p4 = [[AGColorPalette alloc] init];
        p4.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
        p4.colors = [NSArray arrayWithObjects:
                     [UIColor colorWithRed:171.0/255.0 green:14.0/255.0 blue:242.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:2.0/255.0 green:255.0/255.0 blue:0.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:0.0/255.0 green:82.0/255.0 blue:255.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:255.0/255.0 green:90.0/255.0 blue:0.0/255.0 alpha:1.0],
                     [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:60.0/255.0 alpha:1.0],
                     nil];
        p4.source = @"http://www.colourlovers.com/palette/2240032/BRIGHT";
        
        s_allPaletts = [NSArray arrayWithObjects:p1, p2, p3, nil];
        
    });
    
    return s_allPaletts;
}

+ (AGColorPalette *)pickRandomPalette {
    NSArray *allPalettes = [AGColorHelper allPalettes];
    NSUInteger randomIndex = arc4random() % [allPalettes count];
    return [allPalettes objectAtIndex:randomIndex];
}

@end
