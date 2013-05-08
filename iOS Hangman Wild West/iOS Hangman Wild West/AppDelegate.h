//
//  AppDelegate.h
//  iOS Hangman Wild West
//
//  Created by MJ O'CARROLL on 07/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Word.h"
#import "WordBoard.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, AVAudioPlayerDelegate>
{
    UIWindow *window;
    AVAudioPlayer *_backgroundMusicPlayer;
	BOOL _backgroundMusicPlaying;
	BOOL _backgroundMusicInterrupted;
	UInt32 _otherMusicIsPlaying;	
}

@property (strong, nonatomic) UIWindow *window;

- (void)tryPlayMusic;
- (void)customizeAppearance;

@end
