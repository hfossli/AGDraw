//
//  AGPenStroke.m
//  Draw
//
//  Created by Håvard Fossli on 19.06.12.
//  Copyright (c) 2012 Håvard Fossli. All rights reserved.
//

#import "AGPenStroke.h"
#import "AGPointsAndVectorHelper.h"
#import "UIColor+Random.h"

#define SMOOTH_ATTEMPT 1

@implementation AGPenStrokePointInfo

- (CGFloat)velocityComparedToPointInfo:(AGPenStrokePointInfo *)otherPointInfo {
    
    // NSTimeInterval timeDiff = fabs(self.timeStamp - otherPointInfo.timeStamp);
    
    CGFloat distance = distanceBetweenPoints(self.point, otherPointInfo.point);
    CGFloat velocity = MIN(distance / 100, 1.0);
        
    return velocity;
}

@end

@implementation AGPenStroke

- (id)init {
    self = [super init];
    if(self) {
        
        self.path = [UIBezierPath bezierPath];
        self.pathInfoArray = [NSMutableArray array];
        self.color = [UIColor randomColorWithAlphaMin:1.0 alphaMax:1.0];
        
    }
    return self;
}

- (AGPenStrokePointInfo *)lastPI {
    return [self.pathInfoArray lastObject];
}

/*
 Subclasses are to subclass and override this method
 @return param CGRect indicates rect that needs to be redrawn
 */
- (CGRect)penStrokeToPoint:(CGPoint)point forTimeStamp:(NSTimeInterval)timeStamp closePath:(BOOL)closePath {
    CGRect redrawRect = CGRectZero;
    return redrawRect;
}

- (void)drawRect:(CGRect)rect {
}

@end

@implementation AGPenStrokeVelocity

- (CGRect)penStrokeToPoint:(CGPoint)point forTimeStamp:(NSTimeInterval)timeStamp closePath:(BOOL)closePath {
    
    AGPenStrokePointInfo *lastPI = self.lastPI;
    
    AGPenStrokePointInfo *currentPI = [[AGPenStrokePointInfo alloc] init];
    currentPI.timeStamp = timeStamp;
    currentPI.point = point;
    
    [self.pathInfoArray addObject:currentPI];
    
    CGRect redrawRect = CGRectZero;
    
    if(lastPI == nil) {
        [self.path moveToPoint:point];
        self.path.lineCapStyle = kCGLineCapRound;
        currentPI.leftOffsetPoint = point;
        currentPI.rightOffsetPoint = point;
    }
    else {
        
        CGFloat velocity = [currentPI velocityComparedToPointInfo:lastPI];
        CGFloat currentStrokeWidth = MAX(1, velocity * 15);
        
        CGSize lastPathP0ToCurrentPathP1A = normalVectorAtEndOfVectorWithLength(pointsToVector(lastPI.point, currentPI.point), currentStrokeWidth);
        CGSize lastPathP0ToCurrentPathP2A = normalVectorAtEndOfVectorWithLength(pointsToVector(lastPI.point, currentPI.point), -currentStrokeWidth);
        
        currentPI.leftOffsetPoint = pointByAddingVectorToPoint(lastPathP0ToCurrentPathP1A, lastPI.point);
        currentPI.rightOffsetPoint = pointByAddingVectorToPoint(lastPathP0ToCurrentPathP2A, lastPI.point);
        
        redrawRect = smallestRectOfPoints(currentPI.leftOffsetPoint,
                                          currentPI.rightOffsetPoint,
                                          lastPI.rightOffsetPoint,
                                          lastPI.leftOffsetPoint);
         
        [self.path moveToPoint:currentPI.leftOffsetPoint];
        [self.path addLineToPoint:currentPI.rightOffsetPoint];
        [self.path addLineToPoint:lastPI.rightOffsetPoint];
        [self.path addLineToPoint:lastPI.leftOffsetPoint];
        [self.path closePath];
        
        redrawRect = rectIncreasedCentered(redrawRect, 15.0);
    }
    
    return redrawRect;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 5.0, [self.shadowColor CGColor]);
    
    [self.color set];
    
    [self.path fill];
    
}

@end


@implementation AGPenStrokeBasic

- (CGRect)penStrokeToPoint:(CGPoint)point forTimeStamp:(NSTimeInterval)timeStamp closePath:(BOOL)closePath {
    
    AGPenStrokePointInfo *lastPI = self.lastPI;
    
    AGPenStrokePointInfo *currentPI = [[AGPenStrokePointInfo alloc] init];
    currentPI.timeStamp = timeStamp;
    currentPI.point = point;
    
    [self.pathInfoArray addObject:currentPI];
    
    CGRect redrawRect = CGRectZero;
    
    if(lastPI == nil) {
        [self.path moveToPoint:point];
        self.path.lineCapStyle = kCGLineCapRound;
        currentPI.leftOffsetPoint = point;
        currentPI.rightOffsetPoint = point;
    }
    else {
        
        if(self.pathInfoArray.count <= 4) {
            return CGRectZero;
        }
        
        CGPoint controlPoint1;
        CGPoint controlPoint2;
        
        NSUInteger currentIndex = self.pathInfoArray.count - 1;
        CGPoint a3 = currentPI.point;
        CGPoint a2 = [[self.pathInfoArray objectAtIndex:currentIndex - 1] point];
        CGPoint a1 = [[self.pathInfoArray objectAtIndex:currentIndex - 2] point];
        CGPoint a0 = [[self.pathInfoArray objectAtIndex:currentIndex - 3] point];
        
        [AGPointsAndVectorHelper calculateControlPointsAnchor1:a1 anchor2:a2 anchor0:a0 anchor3:a3 smoothValue:0.5 control1:&controlPoint1 control2:&controlPoint2];
        
        [self.path moveToPoint:a1];
        [self.path addCurveToPoint:a2 controlPoint1:controlPoint1 controlPoint2:controlPoint2];
        
        redrawRect = smallestRectOfPoints(a1,
                                          a2,
                                          a3,
                                          a0);
        
        redrawRect = rectIncreasedCentered(redrawRect, 20.0);
    }
    
    return redrawRect;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetShadowWithColor(context, CGSizeMake(0, 2), 5.0, [self.shadowColor CGColor]);
    
    [self.color set];
    
    self.path.lineWidth = 6.0;
    [self.path stroke];
    
}

@end
