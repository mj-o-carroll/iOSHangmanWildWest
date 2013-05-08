//
//  GameViewController.h
//  iOS Hangman Wild West
//
//  Created by MJ O'CARROLL on 07/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "Word.h"
#import "WordBoard.h"
#import "AddScoreViewController.h"



@interface GameViewController : UIViewController <AddScoreViewControllerDelegate, AVAudioPlayerDelegate>
{
    int badLetterCount;
    BOOL winner;
    AVAudioPlayer *_backgroundMusicPlayer;
	BOOL _backgroundMusicPlaying;
	BOOL _backgroundMusicInterrupted;
	UInt32 _otherMusicIsPlaying;
    SystemSoundID _gunShotSound;
}

@property (strong, nonatomic) Word *w;
@property (strong, nonatomic) WordBoard *wb;
@property (strong, nonatomic) IBOutlet UIView * generalBackground;

@property (weak) IBOutlet UILabel *wordDisplayLabel;
@property (weak) IBOutlet UILabel *badLetterCountLabel;
@property (weak) IBOutlet UILabel*userMessageLabel;
@property (weak) IBOutlet UIImageView *displayHangmanImage;
@property (weak) IBOutlet UILabel *playAgain;
@property (weak) IBOutlet UIButton *playAgainYes;
@property (weak) IBOutlet UILabel *header;
@property (strong, nonatomic) IBOutlet UIButton *addScore;
@property (weak) IBOutlet UILabel *livesLbl;


@property (weak) IBOutlet UIButton *buttonQ;
@property (weak) IBOutlet UIButton *buttonW;
@property (weak) IBOutlet UIButton *buttonE;
@property (weak) IBOutlet UIButton *buttonR;
@property (weak) IBOutlet UIButton *buttonT;
@property (weak) IBOutlet UIButton *buttonY;
@property (weak) IBOutlet UIButton *buttonU;
@property (weak) IBOutlet UIButton *buttonI;
@property (weak) IBOutlet UIButton *buttonO;
@property (weak) IBOutlet UIButton *buttonP;

@property (weak) IBOutlet UIButton *buttonA;
@property (weak) IBOutlet UIButton *buttonS;
@property (weak) IBOutlet UIButton *buttonD;
@property (weak) IBOutlet UIButton *buttonF;
@property (weak) IBOutlet UIButton *buttonG;
@property (weak) IBOutlet UIButton *buttonH;
@property (weak) IBOutlet UIButton *buttonJ;
@property (weak) IBOutlet UIButton *buttonK;
@property (weak) IBOutlet UIButton *buttonL;

@property (weak) IBOutlet UIButton *buttonZ;
@property (weak) IBOutlet UIButton *buttonX;
@property (weak) IBOutlet UIButton *buttonC;
@property (weak) IBOutlet UIButton *buttonV;
@property (weak) IBOutlet UIButton *buttonB;
@property (weak) IBOutlet UIButton *buttonN;
@property (weak) IBOutlet UIButton *buttonM;

/* Set up a new game */
- (IBAction) setUpNewGame:(id)sender;

/* Invoked each time a letter is guessed */
- (IBAction)guessLetter:(id)sender;

/* Used to display the Hangman image stored in hangmanImage*/
- (void) displayHangman:(int) stage;

/* Enables/disables all the letter buttons */
- (void) enableAllLetterButtons:(BOOL) enabled;

- (void) showAllLetterButtons:(BOOL) hidden;

- (void) fadeInElements;

- (void)tryPlayMusic;

- (IBAction)gunFired:(id)sender;

- (void)setUpEndMusic;


@end

