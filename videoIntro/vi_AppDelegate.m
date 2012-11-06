//
//  vi_AppDelegate.m
//  videoIntro
//
//  Created by Michael Compas on 11/5/12.
//  Copyright (c) 2012 Concentric. All rights reserved.
//

#import "vi_AppDelegate.h"
#import "vi_ViewController.h"

@implementation vi_AppDelegate
{
	// - MPMoviePlayerViewController CANNOT be used without 2 things:
	//		- 1) In the Summary screen of the project, import the MediaPlayer.framework Framework
	//		- 2) import <MediaPlayer/MediaPlayer.h> in the respective interface file
	// -
	MPMoviePlayerViewController *moviePlayerViewcontroller;
	NSArray *movieArray;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// - Default
	// -
	self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	// - Commented out since moviePlayerViewController is later designated as the rootViewController
	// -
	//self.viewController = [[vi_ViewController alloc] initWithNibName:nil bundle:nil];
	//self.window.rootViewController = self.viewController;
	
	// - Default
	// -
    [self.window makeKeyAndVisible];
	
	// - Custom array used to define names of multiple video assets. Good if using a picker and need to pull indexes.
	// -
	movieArray = [NSArray arrayWithObjects:@"pie", @"trophy_anim1", nil];
	
	// - Returned varable from custom function defined below
	// -
	NSURL *url = [self getURLForIndex:0];
	
	// - If not using multiple videos, this would be the methods to use for one video in one shot
	// -
	//NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"pie" ofType:@"m4v"]];
	
	// - Create a new instance of MPMoviePlayerViewController; it's the view controller needed for playing movies
	// -
	moviePlayerViewcontroller = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
	
	// - Define the control style as 'None' since the movie will be a full-screen movie w/o controls
	// -
	moviePlayerViewcontroller.moviePlayer.controlStyle = MPMovieControlStyleNone;
	
	// - Set the movie player view controller as the rootViewController so the movie is actually visible
	// -
	self.window.rootViewController = moviePlayerViewcontroller;
	
	// - Set the movie to play
	// -
	[moviePlayerViewcontroller.moviePlayer play];
	
	// - Define a new instance of NSNotificationCenter so we can detect when the movie has finished playing
	// -
	NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
	[center addObserver:self
			   selector:@selector(movieFinished)
				   name:MPMoviePlayerPlaybackDidFinishNotification
				 object:moviePlayerViewcontroller.moviePlayer
	 ];
	
	// Override point for customization after application launch.
    return YES;
}

-(NSURL *)getURLForIndex:(NSUInteger)index
{
	return [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[movieArray objectAtIndex:index] ofType:@"m4v"]];
}

-(void)movieFinished
{
	// - Remove the moviePlayerViewcontroller's view to get rid of the movie
	// -
	[moviePlayerViewcontroller.view removeFromSuperview];
	
	// ========================================================================================================
	// - Custom actions from this point forward to handle app behavior after the movie is removed from the view
	
	// - Define a new viewController and set it as the rootViewController
	// -
	vi_ViewController *newViewController = [[vi_ViewController alloc] initWithNibName:nil bundle:nil];
	self.window.rootViewController = newViewController;
	
	// - (Custom action in new view controller's view to confirm removal of movie)
	// -
	newViewController.view.backgroundColor = [UIColor redColor];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
