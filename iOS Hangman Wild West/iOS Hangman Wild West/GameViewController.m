//
//  GameViewController.m
//  iOS Hangman Wild West
//
//  Created by MJ O'CARROLL on 07/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

@synthesize wb, w, badLetterCountLabel;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Insert code here to initialize your application
    w = [[Word alloc] init];
    NSLog(@"Word is : %@",[w description]);
    wb = [[WordBoard alloc] initWithWord:w];
    badLetterCount = 0;
    winner = NO;
    
    [_playAgain setHidden:YES];
    [_playAgainYes setHidden:YES];
    [_userMessageLabel setHidden:YES];
    [_addScore setHidden:YES];
    [_addScore setEnabled:NO];
    [self displayHangman:0];
    
    [_wordDisplayLabel setText:[wb displayBoardAsString]];
    [badLetterCountLabel setText:[NSString stringWithFormat:@"%d", 10-badLetterCount]];
    
    _generalBackground.backgroundColor  = [UIColor colorWithPatternImage:[UIImage imageNamed:@"general_bkg.gif"]];
    [_header setFont:[UIFont fontWithName:@"CliffordEightWF" size:24.0f]];
    [_wordDisplayLabel setFont:[UIFont fontWithName:@"ShelldrakeWF" size:33.0f]];
    [_userMessageLabel setFont:[UIFont fontWithName:@"ShelldrakeWF" size:55.0f]];
    
    [self fadeInElements];
    [self setUpEndMusic];
}

- (void)setUpEndMusic
{
    NSError *setCategoryError = nil;
	[[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:&setCategoryError];
	
	// Create audio player with background music
	NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:@"goodbadugly" ofType:@"mp3"];
	NSURL *backgroundMusicURL = [NSURL fileURLWithPath:backgroundMusicPath];
	NSError *error;
	_backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
	[_backgroundMusicPlayer setDelegate:self];  // We need this so we can restart after interruptions
	[_backgroundMusicPlayer setNumberOfLoops:0
     ];	// Negative number means loop forever
    
    NSString *gunShotPath = [[NSBundle mainBundle] pathForResource:@"gunShot2" ofType:@"wav"];
	NSURL *gunShotURL = [NSURL fileURLWithPath:gunShotPath];
	AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(gunShotURL), &_gunShotSound);
}

- (IBAction)gunFired:(id)sender
{
    AudioServicesPlaySystemSound(_gunShotSound);
}

- (void)tryPlayMusic
{
	// Check to see if iPod music is already playing
	UInt32 propertySize = sizeof(_otherMusicIsPlaying);
	AudioSessionGetProperty(kAudioSessionProperty_OtherAudioIsPlaying, &propertySize, &_otherMusicIsPlaying);
	
	// Play the music if no other music is playing and we aren't playing already
	if (_otherMusicIsPlaying != 1 && !_backgroundMusicPlaying)
    {
		[_backgroundMusicPlayer prepareToPlay];
		[_backgroundMusicPlayer play];
		_backgroundMusicPlaying = YES;
	}
}

- (void) audioPlayerBeginInterruption: (AVAudioPlayer *) player
{
	_backgroundMusicInterrupted = YES;
	_backgroundMusicPlaying = NO;
}

- (void) audioPlayerEndInterruption: (AVAudioPlayer *) player
{
	if (_backgroundMusicInterrupted)
    {
		[self tryPlayMusic];
		_backgroundMusicInterrupted = NO;
	}
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self tryPlayMusic];
}

- (void) fadeInElements
{
    //fade in elements
    _header.alpha = 0.0;
    [UILabel animateWithDuration:2.0 animations:^{
    _header.alpha = 1.0;
    }];
    
    _livesLbl.alpha = 0.0;
    [UILabel animateWithDuration:2.0 animations:^{
        _livesLbl.alpha = 1.0;
    }];
    
    badLetterCountLabel.alpha = 0.0;
    [UILabel animateWithDuration:2.0 animations:^{
        badLetterCountLabel.alpha = 1.0;
    }];
    
    _wordDisplayLabel.alpha = 0.0;
    [UILabel animateWithDuration:2.0 animations:^{
        _wordDisplayLabel.alpha = 1.0;
    }];
    
    _displayHangmanImage.alpha = 0.0;
    [UIView animateWithDuration:2.0 animations:^{
        _displayHangmanImage.alpha = 1.0;
    }];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) setUpNewGame:(id)sender
{
    [w seedWord];
    [wb setNewWord:w];
    
    NSLog(@"Word is : %@",[w description]);
    
    badLetterCount = 0;
	winner = NO;
    
    [_playAgain setHidden:YES];
    [_playAgainYes setHidden:YES];
    [_userMessageLabel setHidden:YES];
    [_addScore setHidden:YES];
    [_addScore setEnabled:NO];
    [self displayHangman:0];
    
    [self enableAllLetterButtons:YES];
    [self showAllLetterButtons:NO];
    [_wordDisplayLabel setText:[wb displayBoardAsString]];
    [badLetterCountLabel setText:[NSString stringWithFormat:@"%d", 10-badLetterCount]];
    
    [self fadeInElements];
    [_backgroundMusicPlayer pause
     ];
    _backgroundMusicPlayer.currentTime = 0.0;
    
}

-(IBAction)guessLetter:(id)sender
{
    if(badLetterCount < 10 && !winner)
    {
        /* checks the title attribute of the button that has just been pressed
         By default the title is set to whatever text the button displays.
         In our case, it's the individual letter
         */
        
        if([wb checkLetter:[sender currentTitle]])
        {
            NSLog(@"Button Pressed: %@", [sender currentTitle]);
            if([wb checkLetterWin])
            {
				NSLog(@"We have a winner");
                winner = YES;
                
                /*
                 1. Disable all keys
                 2. Show congrats
                 3. Enable Play Again button
                 */
                [self enableAllLetterButtons:NO];
                [_playAgain setHidden:NO];  
                [_playAgainYes setHidden:NO];
                
                [_userMessageLabel setText:@"WELL DONE COWBOY!"];
                [_addScore setHidden:NO];
                [_addScore
                 setEnabled:YES];
                [self enableAllLetterButtons:NO];
                [self showAllLetterButtons:YES];
                [_userMessageLabel setTextColor:[UIColor whiteColor]];
                [_userMessageLabel setHidden:NO];
                _backgroundMusicPlayer.currentTime = 0.0;
                [_backgroundMusicPlayer play];
            }
            
            [_wordDisplayLabel setText:[wb displayBoardAsString]];
        }
        else
        {
            if(badLetterCount == 6)
            {
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"We don't like your type around here gringo..."
                                      message: @"C'mon now. You're gonna have to do better, your friend needs your help!"
                                      delegate: nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
            }
			if(![wb checkIfLetterUsed:[sender currentTitle]])
			{
				badLetterCount++;
                [badLetterCountLabel setText:[NSString stringWithFormat:@"%d", 10-badLetterCount]];
                [self displayHangman:badLetterCount];
			}
		}
        
        [wb addUsedLetter:[sender currentTitle]];
        [sender setEnabled:NO];
        [sender setHidden:YES];
    }
    /* if the player has used up all their guesses */
    
    if(badLetterCount == 10)
    {
        NSLog(@"GAME OVER!");
        [self enableAllLetterButtons:NO];
        [self showAllLetterButtons:YES];
        [_playAgain setHidden:NO];
        [_playAgainYes setHidden:NO];
        
        
        [_userMessageLabel setText:@"GAME OVER PILGRIM!"];
        [_userMessageLabel setTextColor:[UIColor redColor]];
        [_userMessageLabel setHidden:NO];
        _backgroundMusicPlayer.currentTime = 0.0;
        [_backgroundMusicPlayer play];
    }
}

- (void) displayHangman:(int)stage
{
    NSLog(@"Amount of wrong letters: %d (Letters left: %d)\n\n", stage, 10-stage);
    [badLetterCountLabel setText:[NSString stringWithFormat:@"%d", 10-stage]];
    NSString *path = [[NSString alloc] initWithFormat:@"hang%d.gif",stage];
    _displayHangmanImage.image = [UIImage imageNamed:path];
    
    //add fade to hangman - not effective
/*
    _displayHangmanImage.alpha = 0.0;
    [UIView animateWithDuration:2.0 animations:^{_displayHangmanImage.alpha = 1.0;}];
*/ 
}

- (void) showAllLetterButtons:(BOOL)hidden
{
    [_buttonA setHidden:hidden];
    [_buttonB setHidden:hidden];
    [_buttonC setHidden:hidden];
    [_buttonD setHidden:hidden];
    [_buttonE setHidden:hidden];
    [_buttonF setHidden:hidden];
    [_buttonG setHidden:hidden];
    [_buttonH setHidden:hidden];
    [_buttonI setHidden:hidden];
    [_buttonJ setHidden:hidden];
    [_buttonK setHidden:hidden];
    [_buttonL setHidden:hidden];
    [_buttonM setHidden:hidden];
    [_buttonN setHidden:hidden];
    [_buttonO setHidden:hidden];
    [_buttonP setHidden:hidden];
    [_buttonQ setHidden:hidden];
    [_buttonR setHidden:hidden];
    [_buttonS setHidden:hidden];
    [_buttonT setHidden:hidden];
    [_buttonU setHidden:hidden];
    [_buttonV setHidden:hidden];
    [_buttonW setHidden:hidden];
    [_buttonX setHidden:hidden];
    [_buttonY setHidden:hidden];
    [_buttonZ setHidden:hidden];
}

- (void) enableAllLetterButtons:(BOOL) enabled
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

#pragma mark - AddScoreViewControllerDelegate

- (void)addScoreViewControllerDidCancel:(AddScoreViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addScoreViewControllerDidSave:(AddScoreViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
    [_addScore setHidden:YES];
    [_addScore setEnabled:NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"AddScore"])
	{
		UINavigationController *navigationController =
        segue.destinationViewController;
        AddScoreViewController * addScoreViewController = [[navigationController viewControllers] objectAtIndex:0];
        addScoreViewController.delegate = self;
        addScoreViewController.playerScore = [NSString stringWithFormat:@"%@", badLetterCountLabel.text];
	}
}

@end
