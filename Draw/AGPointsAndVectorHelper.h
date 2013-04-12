//
//  AGPointsAndVectorHelper.h
//  Draw
//
//  Created by Håvard Fossli on 19.06.12.
//  Copyright (c) 2012 Håvard Fossli. All rights reserved.
//

#import <Foundation/Foundation.h>

CGRect rectFromPoints(CGPoint pointA, CGPoint pointB);
CGRect rectIncreasedCentered(CGRect rect, CGFloat points);
CGFloat lengthOfVector(CGSize vector);
CGSize pointsToVector(CGPoint p1, CGPoint p2);
CGFloat distanceBetweenPoints(CGPoint p1, CGPoint p2);
CGPoint pointByAddingVectorToPoint(CGSize vector, CGPoint point);
CGPoint pointBySubtractingVectorToPoint(CGSize vector, CGPoint point);
CGSize normalVectorAtEndOfVectorWithLength(CGSize vector, CGFloat length);
CGRect smallestRectOfPoints(CGPoint p1, CGPoint p2, CGPoint p3, CGPoint p4);

@interface AGPointsAndVectorHelper : NSObject

+ (void)calculateControlPointsAnchor1:(CGPoint)a1
                              anchor2:(CGPoint)a2
                              anchor0:(CGPoint)a0
                              anchor3:(CGPoint)a3
                          smoothValue:(CGFloat)k
                             control1:(out CGPoint *)c1
                             control2:(out CGPoint *)c2;

@end