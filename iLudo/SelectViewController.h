//
//  SelectViewController.h
//  iLudo
//
//  Created by Guillaume Garcera on 20/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"

@interface SelectViewController : UITableViewController  {
    Game *curGame;
    NSArray *selectItems;
    int     attributeToSelect;
}

@property (nonatomic, retain) Game* curGame;
@property (nonatomic, retain) NSArray *selectItems;
@property (nonatomic, readwrite) int attributeToSelect;



@end
