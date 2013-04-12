//
//  UnitTest.m
//  UnitTest
//
//  Created by Håvard Fossli on 19.06.12.
//  Copyright (c) 2012 Håvard Fossli. All rights reserved.
//

#import "UnitTest.h"
#import "AGPointsAndVectorHelper.h"

@implementation UnitTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testVector
{
    
    CGPoint p1 = CGPointMake(20, 20);
    CGPoint p2 = CGPointMake(90, 40);
    
    CGSize p1VectorToP2 = pointsToVector(p1, p2);
    CGSize p1VectorToP3 = normalVectorAtEndOfVectorWithLength(p1VectorToP2, 10.0);
    
    CGPoint p3 = pointByAddingVectorToPoint(p1VectorToP3, p1);
    
    STAssertEqualsWithAccuracy(p3.x, 87.25, 0.5, @"calculation is wrong");
    STAssertEqualsWithAccuracy(p3.y, 49.61, 0.5, @"calculation is wrong");
    
    STFail(@"Unit tests are not implemented yet in UnitTest");
}

@end
