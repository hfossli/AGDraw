//
//  AGPenStroke.h
//  Draw
//
//  Created by Håvard Fossli on 19.06.12.
//  Copyright (c) 2012 Håvard Fossli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGPenStrokePointInfo : NSObject

@property (nonatomic) NSTimeInterval timeStamp;
@property (nonatomic) CGPoint point;
@property (nonatomic) CGPoint leftOffsetPoint;
@property (nonatomic) CGPoint rightOffsetPoint;

@end


@interface AGPenStroke : NSObject

@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) NSMutableArray *pathInfoArray;
@property (nonatomic, readonly) AGPenStrokePointInfo *lastPI;
@property (nonatomic, retain) UIColor *color; 
@property (nonatomic, retain) UIColor *shadowColor;

- (CGRect)penStrokeToPoint:(CGPoint)point forTimeStamp:(NSTimeInterval)timeStamp closePath:(BOOL)closePath;
- (void)drawRect:(CGRect)rect;

@end

@interface AGPenStrokeBasic : AGPenStroke
@end

@interface AGPenStrokeVelocity : AGPenStroke
@end



/*
 
 Inspiration
 http://blog.effectiveui.com/?p=8105
 
 */
