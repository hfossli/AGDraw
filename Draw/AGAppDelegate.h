//
//  AGAppDelegate.h
//  Draw
//
//  Created by Håvard Fossli on 17.06.12.
//  Copyright (c) 2012 Håvard Fossli. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AGViewController;

@interface AGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) AGViewController *viewController;

@end
