//
//  vi_AppDelegate.h
//  videoIntro
//
//  Created by Michael Compas on 11/5/12.
//  Copyright (c) 2012 Concentric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@class vi_ViewController;

@interface vi_AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) vi_ViewController *viewController;

@end
