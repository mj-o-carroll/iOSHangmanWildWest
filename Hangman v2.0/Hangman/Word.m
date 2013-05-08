//
//  Word.m
//  Hangman v1.0
//
//  Created by Robert O'Connor on 03/02/2011.
//  Copyright 2011 Robert O'Connor. All rights reserved.
//

#import "Word.h"


@implementation Word

- (id) init
{
	allWordsArray = [[NSMutableArray alloc] init];
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
	
	return letterAsString;*/
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
