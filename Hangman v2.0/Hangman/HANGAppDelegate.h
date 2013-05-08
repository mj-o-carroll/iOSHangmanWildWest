//
//  HANGAppDelegate.h
//  Hangman
//
//  Created by Robert O'Connor on 05/02/2013.
//  Copyright (c) 2013 WIT. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Word.h"
#import "WordBoard.h"

@interface HANGAppDelegate : NSObject <NSApplicationDelegate>{
    int badLetterCount;
	Word *w;
	WordBoard *wb;
	BOOL winner;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *wordDisplayLabel;
@property (weak) IBOutlet NSTextField *badLetterCountLabel;
@property (weak) IBOutlet NSTextField *userMessageLabel;
@property (weak) IBOutlet NSImageView *displayHangmanImage;
@property (weak) IBOutlet NSBox *playAgainBox;

@property (weak) IBOutlet NSButton *buttonQ;
@property (weak) IBOutlet NSButton *buttonW;
@property (weak) IBOutlet NSButton *buttonE;
@property (weak) IBOutlet NSButton *buttonR;
@property (weak) IBOutlet NSButton *buttonT;
@property (weak) IBOutlet NSButton *buttonY;
@property (weak) IBOutlet NSButton *buttonU;
@property (weak) IBOutlet NSButton *buttonI;
@property (weak) IBOutlet NSButton *buttonO;
@property (weak) IBOutlet NSButton *buttonP;

@property (weak) IBOutlet NSButton *buttonA;
@property (weak) IBOutlet NSButton *buttonS;
@property (weak) IBOutlet NSButton *buttonD;
@property (weak) IBOutlet NSButton *buttonF;
@property (weak) IBOutlet NSButton *buttonG;
@property (weak) IBOutlet NSButton *buttonH;
@property (weak) IBOutlet NSButton *buttonJ;
@property (weak) IBOutlet NSButton *buttonK;
@property (weak) IBOutlet NSButton *buttonL;

@property (weak) IBOutlet NSButton *buttonZ;
@property (weak) IBOutlet NSButton *buttonX;
@property (weak) IBOutlet NSButton *buttonC;
@property (weak) IBOutlet NSButton *buttonV;
@property (weak) IBOutlet NSButton *buttonB;
@property (weak) IBOutlet NSButton *buttonN;
@property (weak) IBOutlet NSButton *buttonM;

/* Set up a new game */
- (IBAction) setUpNewGame:(id)sender;

/* Quit the Application */
- (IBAction) quitGame: (id) sender;

/* Invoked each time a letter is guessed */
- (IBAction)guessLetter:(id)sender;

/* Used to display the Hangman image stored in hangmanImage*/
- (void) displayHangman:(int) stage;

/* Enables/disables all the letter buttons */
- (void) enableAllLetterButtons:(bool) enabled;

@end
