//
//  AddScoreViewController.m
//  iOS Hangman Wild West
//
//  Created by MJ O'CARROLL on 13/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import "AddScoreViewController.h"

@interface AddScoreViewController ()

@end

@implementation AddScoreViewController

@synthesize delegate, nameTextField, scoreLabel, playerScore, scoreArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    UITapGestureRecognizer *tapgesture=[[UITapGestureRecognizer alloc]initWithTarget:self
                                                                              action:@selector(tableClicked)];
    [tableview addGestureRecognizer:tapgesture];
    
    [super viewDidLoad];
    
    [[UILabel appearance] setFont:[UIFont fontWithName:@"RawhideWF" size:12.0]];
    [scoreLabel setFont:[UIFont fontWithName:@"RawhideWF" size:22.0]];
    [nameTextField setFont:[UIFont fontWithName:@"RawhideWF" size:22.0]];
    scoreLabel.text = playerScore;
}

-(void)tableClicked
{
    [nameTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0)
		[self.nameTextField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)cancel:(id)sender
{
	[self.delegate addScoreViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender
{
    NSString * newName = [nameTextField.text uppercaseString];
    NSString * newScore = playerScore;
    NSDictionary *newScoreToAdd = [[NSDictionary alloc] initWithObjectsAndKeys:
                          newName, @"name", newScore, @"score", nil];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistLocation = [documentsDirectory stringByAppendingPathComponent:@"scores.plist"];
    NSMutableArray* existingPlist = [[NSMutableArray alloc] initWithContentsOfFile:plistLocation];
    
    if(!existingPlist)
    {
        scoreArray = [[NSMutableArray alloc] initWithObjects:newScoreToAdd, nil];
        [scoreArray writeToFile:plistLocation atomically:YES];
        NSLog(@"%@", [scoreArray objectAtIndex:0]);
    }
    
    else
    {
        [existingPlist addObject:newScoreToAdd];
        [existingPlist writeToFile:plistLocation atomically:YES];

    }

	[self.delegate addScoreViewControllerDidSave:self];
}

@end
