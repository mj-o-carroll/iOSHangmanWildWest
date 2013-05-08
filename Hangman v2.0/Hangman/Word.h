//
//  Word.h
//  Hangman v1.0
//
//  Created by Robert O'Connor on 03/02/2011.
//  Copyright 2011 Robert O'Connor. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Word : NSObject {
	NSString* word;	// the word that will be used in the game
	NSMutableArray* allWordsArray;	// the array that contains all possible words the game might use
}

- (NSString *) word;
- (void) setWord:(NSString *) theWord;

- (void) seedWord;			// picks a word from allWordsArray and sets it to be word
- (void) seedWords;			// populates the allWordsArray
- (int) length;				// returns the length of word
- (NSString *) letterAtIndex:(int)index;	// returns the character at a particular index of word as an NSString
- (BOOL) checkWordGuess:(NSString *)guess;	// returns a BOOl as to whether guess is the same as word


// you must write a description method too (this is inherited from NSObject)

@end
