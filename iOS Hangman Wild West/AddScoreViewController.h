//
//  AddScoreViewController.h
//  iOS Hangman Wild West
//
//  Created by MJ O'CARROLL on 13/03/2013.
//  Copyright (c) 2013 MJ O'CARROLL. All rights reserved.
//

#import <UIKit/UIKit.h>



@class AddScoreViewController;

@protocol AddScoreViewControllerDelegate <NSObject>
- (void)addScoreViewControllerDidCancel:(AddScoreViewController *)controller;
- (void)addScoreViewControllerDidSave:(AddScoreViewController *)controller;
@end

@interface AddScoreViewController : UITableViewController
{
    IBOutlet UITableView *tableview;
}

@property (nonatomic, weak) id <AddScoreViewControllerDelegate> delegate;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet NSString *playerScore;
@property (strong, nonatomic) NSMutableArray *scoreArray;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end


