//
//  WordGuess.m
//  Hangman v1.0
//
//  Created by Robert O'Connor on 03/02/2011.
//  Copyright 2011 Robert O'Connor. All rights reserved.
//

#import "WordBoard.h"


@implementation WordBoard

/*
 Alloc and inits the various arrays.
 Adds the letters of the word to wordBoard and the appropriate number of blanks _ to displayBoard
 */
- (id) initWithWord:(Word *) w
{
	if(!wordBoard)
		wordBoard = [[NSMutableArray alloc] init];
	if(!displayBoard)
		displayBoard = [[NSMutableArray alloc] init];
	if(!usedLetters)
		usedLetters = [[NSMutableArray alloc] init];
	
	// add letters to wordBoard
	
	for(int i = 0;i<[w length];i++){
		[wordBoard addObject:[[w letterAtIndex:i] uppercaseString]];
		[displayBoard addObject:@"_"];
	}
	return self;
}

/* Set up for a new game */
- (void) setNewWord:(Word *) w
{
    /* Empty the existing arrays */
    [wordBoard removeAllObjects];
    [displayBoard removeAllObjects];
    [usedLetters removeAllObjects];
    
    for(int i = 0;i<[w length];i++){
		[wordBoard addObject:[[w letterAtIndex:i] uppercaseString]];
		[displayBoard addObject:@"_"];
	}
}

/*
 Deallocs everything set up in init
 */
/*
- (void) dealloc
{
	[wordBoard release];
	[displayBoard release];
	[usedLetters release];
	
	[super dealloc];
}
*/

/*
 Checks to see if a letter is contained in wordBoard.
 If YES, reveal appropriate letters in displayBoard
 If NO, do nothing
 return result
 
 All checks should be CASE INSENSTIVE (look up documentation on NSString
 */
- (BOOL) checkLetter:(NSString *) c
{
	BOOL result = NO;
	
	for(int i=0;i<[wordBoard count];i++){
		if(![[wordBoard objectAtIndex:i] caseInsensitiveCompare:c]){
			result = YES;
			[displayBoard replaceObjectAtIndex:i withObject:c]; 
		}		
	}
	
	return result;
}

- (NSMutableArray *) wordBoard
{
	return wordBoard;
}

- (NSMutableArray *) displayBoard
{
	return displayBoard;
}

- (NSMutableArray *) usedLetters
{
	return usedLetters;
}


/* Returns the displayBoard as a String */
- (NSString *) displayBoardAsString
{
    NSMutableString *displayBoardString = [[NSMutableString alloc] init];
    
    for(int i=0;i<[displayBoard count];i++){
        [displayBoardString appendString:[displayBoard objectAtIndex:i]];
        [displayBoardString appendString:@" "];
    }
    //NSLog(@"displayBoardAsString is: %@", displayBoardString);
    
    return (NSString *) displayBoardString;
}



/*
 Adds c to the usedLetters array
 */
- (void) addUsedLetter: (NSString *) c
{
	[usedLetters addObject:c];
}

/*
 Returns a BOOL indicating whether c is a member of usedLetters
 */
- (BOOL) checkIfLetterUsed: (NSString *) c
{
	if([usedLetters containsObject:c])
		return YES;
	else
		return NO;
}

/*
 Returns a BOOL indicating if c is the final letter to be guessed
 */
- (BOOL) checkLetterWin
{
	for(int i=0;i<[displayBoard count];i++){
		if(![[displayBoard objectAtIndex:i] caseInsensitiveCompare:@"_"])
			return NO;
	}	
	return YES;
}

@end
