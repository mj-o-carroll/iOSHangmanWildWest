//
//  AppDelegate.m
//  iOS Hangman Wild West
//
//  Created by MJ O'CARROLL on 07/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window;	

- (void) customizeAppearance
{
    [[UILabel appearance] setFont:[UIFont fontWithName:@"RawhideWF" size:15.0]];
    [[UIButton appearance] setFont:[UIFont fontWithName:@"ShelldrakeWF" size:22.0]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar_bkg.png"]forBarMetrics:UIBarMetricsDefault];
    //[[UIBarButtonItem appearance] setFont:[UIFont fontWithName:@"RawhideWF" size:15.0]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Insert code here to initialize your application
    
    [self customizeAppearance];
    
    NSError *setCategoryError = nil;
	[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&setCategoryError];
	
	// Create audio player with background music
	NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"banjo" ofType:@"mp3"];
	NSURL *backgroundMusicURL = [NSURL fileURLWithPath:backgroundMusicPath];
	NSError *error;
	_backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
	[_backgroundMusicPlayer setDelegate:self];  // We need this so we can restart after interruptions
	[_backgroundMusicPlayer setNumberOfLoops:0];
    // Negative number means loop forever

    // Override point for customization after application launch.
    return YES;
}

- (void)tryPlayMusic {
	
	// Check to see if iPod music is already playing
	UInt32 propertySize = sizeof(_otherMusicIsPlaying);
	AudioSessionGetProperty(kAudioSessionProperty_OtherAudioIsPlaying, &propertySize, &_otherMusicIsPlaying);
	
	// Play the music if no other music is playing and we aren't playing already
	if (_otherMusicIsPlaying != 1 && !_backgroundMusicPlaying)
    {
		[_backgroundMusicPlayer prepareToPlay];
		[_backgroundMusicPlayer play];
		_backgroundMusicPlaying = YES;
	}
}

- (void) audioPlayerBeginInterruption: (AVAudioPlayer *) player
{
	_backgroundMusicInterrupted = YES;
	_backgroundMusicPlaying = NO;
}

- (void) audioPlayerEndInterruption: (AVAudioPlayer *) player
{
	if (_backgroundMusicInterrupted)
    {
		[self tryPlayMusic];
		_backgroundMusicInterrupted = NO;
	}
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
    [self tryPlayMusic];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
