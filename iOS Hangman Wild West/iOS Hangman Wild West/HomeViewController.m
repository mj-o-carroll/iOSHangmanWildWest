//
//  HomeViewController.m
//  iOS Hangman Wild West
//
//  Created by MJ O'CARROLL on 11/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "HomeViewController.h"
#include <sys/time.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize startGame;

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
    
    NSString *gunShotPath = [[NSBundle mainBundle] pathForResource:@"gunShot2" ofType:@"wav"];
	NSURL *gunShotURL = [NSURL fileURLWithPath:gunShotPath];
	AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(gunShotURL), &_gunShotSound);
    
    _homeBackground.backgroundColor  = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_bkg.gif"]];
}

- (IBAction)gunFired:(id)sender
{
    AudioServicesPlaySystemSound(_gunShotSound);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
