//
//  Game.h
//  iLudo
//
//  Created by Guillaume Garcera on 09/08/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>




@interface Game : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSNumber * target;
@property (nonatomic, retain) NSNumber * min_player;
@property (nonatomic, retain) NSNumber * max_player;

@end
