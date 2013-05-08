//
//  HomeViewController.h
//  iOS Hangman Wild West
//
//  Created by MJ O'CARROLL on 11/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>



@interface HomeViewController : UIViewController{
    SystemSoundID _gunShotSound;
    
}

@property (strong, nonatomic) UIButton* startGame;
@property (strong, nonatomic) IBOutlet UIView * homeBackground;

- (IBAction)gunFired:(id)sender;

@end
