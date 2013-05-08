//
//  Word.h
//  iOS Hangman Wild West
//
//  Created by MJ O'CARROLL on 08/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <Foundation/Foundation.h>

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
