//
//  HANGAppDelegate.m
//  Hangman
//
//  Created by Robert O'Connor on 05/02/2013.
//  Copyright (c) 2013 WIT. All rights reserved.
//

#import "HANGAppDelegate.h"

@implementation HANGAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    w = [[Word alloc] init];
    NSLog(@"Word is : %@",[w description]);
    
	wb = [[WordBoard alloc] initWithWord:w];
	badLetterCount = 0;
	winner = NO;
    
    [_wordDisplayLabel setStringValue:[wb displayBoardAsString]];
    [_badLetterCountLabel setStringValue:[NSString stringWithFormat:@"%d", 10-badLetterCount]];
}

- (IBAction) setUpNewGame:(id)sender
{
    [w seedWord];
    [wb setNewWord:w];
    
    NSLog(@"Word is : %@",[w description]);
    
    badLetterCount = 0;
	winner = NO;
    
    [_playAgainBox setHidden:YES];
    [_userMessageLabel setHidden:YES];
    [self displayHangman:0];
    
    [self enableAllLetterButtons:YES];
    [_wordDisplayLabel setStringValue:[wb displayBoardAsString]];
    [_badLetterCountLabel setStringValue:[NSString stringWithFormat:@"%d", 10-badLetterCount]];
}

- (IBAction) quitGame: (id) sender
{
    [NSApp terminate:nil];
}

-(IBAction)guessLetter:(id)sender
{
    if(badLetterCount < 10 && !winner){
        /* checks the title attribute of the button that has just been pressed 
            By default the title is set to whatever text the button displays. 
         In our case, it's the individual letter
         */
        if([wb checkLetter:[sender title]]){
            NSLog(@"Button Pressed: %@", [sender title]);
            if([wb checkLetterWin]){
				NSLog(@"We have a winner");
                winner = YES;
                
                /*
                 1. Disable all keys
                 2. Show congrats
                 3. Enable Play Again button
                 */
                [self enableAllLetterButtons:NO];
                [_playAgainBox setHidden:NO];
                
                [_userMessageLabel setStringValue:@"CONGRATULATIONS!!!"];
                [_userMessageLabel setTextColor:[NSColor greenColor]];
                [_userMessageLabel setHidden:NO];
            }
            
            [_wordDisplayLabel setStringValue:[wb displayBoardAsString]];
        }
        else{
			if(![wb checkIfLetterUsed:[sender title]])
			{
				badLetterCount++;
                [_badLetterCountLabel setStringValue:[NSString stringWithFormat:@"%d", 10-badLetterCount]];
                [self displayHangman:badLetterCount];
			}
		}
        
        [wb addUsedLetter:[sender title]];
        [sender setEnabled:NO];
    }
    /* if the player has used up all their guesses */
    
    if(badLetterCount == 10){
        NSLog(@"GAME OVER!");
        [self enableAllLetterButtons:NO];
        [_playAgainBox setHidden:NO];
        
        [_userMessageLabel setStringValue:@"GAME OVER"];
        [_userMessageLabel setTextColor:[NSColor redColor]];
        [_userMessageLabel setHidden:NO];
        
        /*
         1. Disable all keys
         2. Show Play Again
         */
    }
}

- (void) displayHangman:(int)stage
{
    NSString *path = [[NSString alloc] initWithFormat:@"hang%d.gif",stage];    
    _displayHangmanImage.image = [NSImage imageNamed:path];
}

- (void) enableAllLetterButtons:(bool) enabled
{
    [_buttonA setEnabled:enabled];
    [_buttonB setEnabled:enabled];
    [_buttonC setEnabled:enabled];
    [_buttonD setEnabled:enabled];
    [_buttonE setEnabled:enabled];
    [_buttonF setEnabled:enabled];
    [_buttonG setEnabled:enabled];
    [_buttonH setEnabled:enabled];
    [_buttonI setEnabled:enabled];
    [_buttonJ setEnabled:enabled];
    [_buttonK setEnabled:enabled];
    [_buttonL setEnabled:enabled];
    [_buttonM setEnabled:enabled];
    [_buttonN setEnabled:enabled];
    [_buttonO setEnabled:enabled];
    [_buttonP setEnabled:enabled];
    [_buttonQ setEnabled:enabled];
    [_buttonR setEnabled:enabled];
    [_buttonS setEnabled:enabled];
    [_buttonT setEnabled:enabled];
    [_buttonU setEnabled:enabled];
    [_buttonV setEnabled:enabled];
    [_buttonW setEnabled:enabled];
    [_buttonX setEnabled:enabled];
    [_buttonY setEnabled:enabled];
    [_buttonZ setEnabled:enabled];
}

@end
