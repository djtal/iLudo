//
//  GameEditController.h
//  iLudo
//
//  Created by Guillaume Garcera on 09/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "SelectViewController.h"

@interface GameEditController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    UITextField         *gameNameTF;
    UITextField         *gameMinPlayerTF;
    UITextField         *gameMaxPlayerTF;
    UISegmentedControl  *gameLevelSegmentedField;
    UITableView         *attrTableSelect;
    
    NSManagedObjectContext *editingContext;
    
    SelectViewController *selectViewController;
    
    Game *curGame;
    
}


@property (nonatomic, retain) IBOutlet UITextField *gameNameTF;
@property (nonatomic, retain) IBOutlet UITextField *gameMinPlayerTF;
@property (nonatomic, retain) IBOutlet UITextField *gameMaxPlayerTF;
@property (nonatomic, retain) IBOutlet UISegmentedControl *gameLevelSegmentedField;
@property (nonatomic, retain) IBOutlet UITableView *attrTableSelect;

@property (nonatomic, retain) Game *curGame;
@property (nonatomic, retain) SelectViewController *selectViewController;
@property (nonatomic, retain) NSManagedObjectContext *editingContext;


- (id)iniWithPrimaryManagedObjectContext:(NSManagedObjectContext*)primaryMOC;
- (void)updateInterfaceForCurrentPerson;
- (IBAction)textFieldDoneEditing:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (void)showSelectViewController:(NSIndexPath*)indexPath;
@end
