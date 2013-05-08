//
//  WordGuess.h
//  Hangman v1.0
//
//  Created by Robert O'Connor on 03/02/2011.
//  Copyright 2011 Robert O'Connor. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Word.h"

@interface WordBoard : NSObject {
	NSMutableArray *wordBoard;		// Stores the word, each letter is stored as an individual NSString in the array
	NSMutableArray *displayBoard;	// Stores the word as displayed to user (blanks _ at the start)
	NSMutableArray *usedLetters;	// Stores guessed letters
}

- (id) initWithWord: (Word *) w;		// sets up the various board with a word
- (BOOL) checkLetter: (NSString *) c;	// checks if a letter is valid, makes appropriate adjustments to arrays and returns a BOOL
- (BOOL) checkLetterWin;				// returns a BOOL if final letter guesses the word
- (BOOL) checkIfLetterUsed: (NSString *) c;	// returns a BOOL as to whether c is already in usedLetters
- (void) addUsedLetter: (NSString *) c;	//adds c to the usedLetters array
- (void) setNewWord:(Word *) w; /* Set up for a new game */

/* Getters for the Arrays */
- (NSMutableArray *) wordBoard;
- (NSMutableArray *) displayBoard;
- (NSMutableArray *) usedLetters;

/* Returns the displayBoard as a String */
- (NSString *) displayBoardAsString;

@end
