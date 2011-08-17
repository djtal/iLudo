//
//  GameEditController.h
//  iLudo
//
//  Created by Guillaume Garcera on 09/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface GameEditController : UIViewController{
    
    UITextField *gameNameTF;

    UITextField *gameMinPlayerTF;
    UITextField *gameMaxPlayerTF;
    
    NSManagedObjectContext *editingContext;
    
    Game *curGame;
    
}


@property (nonatomic, retain) IBOutlet UITextField *gameNameTF;
@property (nonatomic, retain) IBOutlet UITextField *gameMinPlayerTF;
@property (nonatomic, retain) IBOutlet UITextField *gameMaxPlayerTF;

@property (nonatomic, retain) Game *curGame;

@property (nonatomic, retain) NSManagedObjectContext *editingContext;


- (id)iniWithPrimaryManagedObjectContext:(NSManagedObjectContext*)primaryMOC;
- (void)updateInterfaceForCurrentPerson;
@end
