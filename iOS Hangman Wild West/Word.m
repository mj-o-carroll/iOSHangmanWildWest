//
//  Word.m
//  iOS Hangman Wild West
//
//  Created by MJ O'CARROLL on 08/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "Word.h"

@implementation Word

- (id) init
{
	// Get the words.plist and save it in completePlist array
    NSString *mjPList = [[NSBundle mainBundle] pathForResource:@"mj" ofType:@"plist"];
    allWordsArray = [[NSMutableArray alloc]initWithContentsOfFile:mjPList];
    
	[self seedWords];
	
	word = [[NSString alloc] init];
	[self seedWord];
    
	return self;
}
/*
 -(void)dealloc
 {
 [word release];
 [allWordsArray release];
 [super dealloc];
 }*/

- (NSString *) word
{
	return word;
}

- (void) setWord:(NSString *) theWord
{
	//[word release];
	word = [[NSString alloc] initWithString: theWord];
}

/* This could be changed to do something a little more interesting */

- (void) seedWords
{
	[allWordsArray addObject:@"PENCIL"];
	[allWordsArray addObject:@"RUBBER"];
	[allWordsArray addObject:@"RULER"];
	[allWordsArray addObject:@"COMPASS"];
	[allWordsArray addObject:@"TOPPER"];
	[allWordsArray addObject:@"SATCHEL"];
	[allWordsArray addObject:@"PROTRACTOR"];
}

- (void) seedWord
{
	//srandom(time(NULL));
	srandom([[NSDate date] timeIntervalSince1970]);
    int totalWords = (int)[allWordsArray count];
	
	int rnd = (random() % totalWords);
	
	[self setWord:[allWordsArray objectAtIndex:rnd]];
}

- (int) length
{
	return (int)[word length];
}

// Returns and autorelease NSString representation of a character at position
- (NSString *) letterAtIndex:(int)position
{
	/*
     unichar letter = [word characterAtIndex:position];
     NSString *letterAsString = [NSString stringWithFormat: @"%C", letter];
     
     return letterAsString;
     */
	return [NSString stringWithFormat: @"%C", [word characterAtIndex:position]];
}

- (BOOL) checkWordGuess:(NSString *)guess
{
	if([word caseInsensitiveCompare:guess]){
		// Not the same
		return NO;
	}
	else{
		// The same
		return YES;
	}
}

-(NSString *) description
{
	return word;
}

@end

