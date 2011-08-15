//
//  RootViewController.h
//  iLudo
//
//  Created by Guillaume Garcera on 09/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "GameEditController.h"

@class GameEditController;

@interface RootViewController : UITableViewController <NSFetchedResultsControllerDelegate> {
    GameEditController *gameEditController;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (readonly, retain) GameEditController *gameEditController;

- (void)addNewGame;

@end
