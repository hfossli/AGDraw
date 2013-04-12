//
//  AGPointsAndVectorHelper.h
//  Draw
//
//  Created by Håvard Fossli on 19.06.12.
//  Copyright (c) 2012 Håvard Fossli. All rights reserved.
//

#import "AGPointsAndVectorHelper.h"
#import <UIKit/UIKit.h>

CGRect rectFromPoints(CGPoint pointA, CGPoint pointB) {
    
    CGRect rect = CGRectMake(
                             MIN(pointA.x, pointB.x),
                             MIN(pointA.y, pointB.y),
                             fabs(pointA.x - pointB.x),
                             fabs(pointA.y - pointB.y)
                             );
    
    return rect;
};

CGRect rectIncreasedCentered(CGRect rect, CGFloat points) {
    
    rect.origin.x -= points / 2.0;
    rect.origin.y -= points / 2.0;
    rect.size.width += points;
    rect.size.height += points;
    
    return rect;
}

CGFloat lengthOfVector(CGSize vector) {
    CGFloat length = sqrt((vector.width * vector.width) + (vector.height * vector.height));
    return length;
};

CGSize pointsToVector(CGPoint p1, CGPoint p2) {
    return CGSizeMake(p2.x - p1.x, p2.y - p1.y);
};

CGFloat distanceBetweenPoints(CGPoint p1, CGPoint p2) {
    CGSize vector = pointsToVector(p1, p2);
    return lengthOfVector(vector);
};

CGPoint pointByAddingVectorToPoint(CGSize vector, CGPoint point) {
    return CGPointMake(point.x + vector.width, point.y + vector.height);
};

CGPoint pointBySubtractingVectorToPoint(CGSize vector, CGPoint point) {
    return CGPointMake(point.x - vector.width, point.y - vector.height);
};

CGSize normalVectorAtEndOfVectorWithLength(CGSize vector, CGFloat length) {
    
    // names after illustration: http://en.wikipedia.org/wiki/File:Trigonometry_triangle.svg
    
    CGFloat a = length;
    CGFloat b = lengthOfVector(vector);
    
    CGPoint rotatedAC = CGPointMake(-vector.height, vector.width);
    CGPoint normalizedRotatedAC = CGPointMake(rotatedAC.x / b, rotatedAC.y / b);
    
    CGSize normalizedVectorFromEnd = CGSizeMake(normalizedRotatedAC.x * a, normalizedRotatedAC.y * a);
    CGSize normalizedVectorFromOrigo = CGSizeMake(normalizedVectorFromEnd.width + vector.width, normalizedVectorFromEnd.height + vector.height);
    
    return normalizedVectorFromOrigo;
};

CGRect smallestRectOfPoints(CGPoint p1, CGPoint p2, CGPoint p3, CGPoint p4) {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:p1];
    [bezierPath addLineToPoint:p2];
    [bezierPath addLineToPoint:p3];
    [bezierPath addLineToPoint:p4];
    [bezierPath closePath];
    
    return [bezierPath bounds];
}

@implementation AGPointsAndVectorHelper

+ (void)calculateControlPointsAnchor1:(CGPoint)a1
                              anchor2:(CGPoint)a2
                              anchor0:(CGPoint)a0
                              anchor3:(CGPoint)a3
                          smoothValue:(CGFloat)k
                             control1:(out CGPoint *)c1
                             control2:(out CGPoint *)c2 {
        
    // http://www.antigrain.com/research/bezier_interpolation/
    
    
    // Assume we need to calculate the control
    // points between (a1.x,a1.y) and (a2.x,a2.y).
    // Then a0.x,a0.y - the previous vertex,
    //      a3.x,a3.y - the next one.
    
    double xc1 = (a0.x + a1.x) / 2.0;
    double yc1 = (a0.y + a1.y) / 2.0;
    double xc2 = (a1.x + a2.x) / 2.0;
    double yc2 = (a1.y + a2.y) / 2.0;
    double xc3 = (a2.x + a3.x) / 2.0;
    double yc3 = (a2.y + a3.y) / 2.0;
    
    double len1 = sqrt((a1.x-a0.x) * (a1.x-a0.x) + (a1.y-a0.y) * (a1.y-a0.y));
    double len2 = sqrt((a2.x-a1.x) * (a2.x-a1.x) + (a2.y-a1.y) * (a2.y-a1.y));
    double len3 = sqrt((a3.x-a2.x) * (a3.x-a2.x) + (a3.y-a2.y) * (a3.y-a2.y));
    
    double k1 = len1 / (len1 + len2);
    double k2 = len2 / (len2 + len3);
    
    double xm1 = xc1 + (xc2 - xc1) * k1;
    double ym1 = yc1 + (yc2 - yc1) * k1;
    
    double xm2 = xc2 + (xc3 - xc2) * k2;
    double ym2 = yc2 + (yc3 - yc2) * k2;
    
    // Resulting control points. Here smooth_value is mentioned
    // above coefficient K whose value should be in range [0...1].
    double ctrl1_x = xm1 + (xc2 - xm1) * k + a1.x - xm1;
    double ctrl1_y = ym1 + (yc2 - ym1) * k + a1.y - ym1;
    
    double ctrl2_x = xm2 + (xc2 - xm2) * k + a2.x - xm2;
    double ctrl2_y = ym2 + (yc2 - ym2) * k + a2.y - ym2;
    
    *c1 = CGPointMake(ctrl1_x, ctrl1_y);
    *c2 = CGPointMake(ctrl2_x, ctrl2_y);
    
}

@end