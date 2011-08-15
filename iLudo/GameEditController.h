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
    UITextField *gameDescriptionTF;
    UITextField *gameMinPlayerTF;
    UITextField *gameMaxPlayerTF;
    
    NSManagedObjectContext *editingContext;
    
    Game *curGame;
    
}


@property (nonatomic, retain) IBOutlet UITextField *gameNameTF;
@property (nonatomic, retain) IBOutlet UITextField *gameDescriptionTF;
@property (nonatomic, retain) IBOutlet UITextField *gameMinPlayerTF;
@property (nonatomic, retain) IBOutlet UITextField *gameMaxPlayer;

@property (nonatomic, retain) Game *currentGame;

@property (nonatomic, retain) NSManagedObjectContext *editingContext;


- (id)iniWithPrimaryManagedObjectContext:(NSManagedObjectContext*)primaryMOC;
@end
