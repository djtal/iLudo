//
//  Game.m
//  iLudo
//
//  Created by Guillaume Garcera on 09/08/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Game.h"


@implementation Game
@dynamic name;
@dynamic level;
@dynamic target;
@dynamic min_player;
@dynamic max_player;

- (BOOL)validateName:(id*)ioValue error:(NSError**)outError{
    NSString *proposedName = *ioValue;
    if (!proposedName || [proposedName isEqualToString:@" "]) {
        NSString *localizedDesc = NSLocalizedString(@"Vous devez saisir un nom", @"Vous devez saisir un nom");
        NSDictionary *errorUserInfo = [NSDictionary dictionaryWithObject:localizedDesc forKey:NSLocalizedDescriptionKey];
        if (outError) {
            *outError = [NSError errorWithDomain:NSCocoaErrorDomain code:NSValidationStringTooShortError userInfo:errorUserInfo];
        }
        return NO;
    }
    return YES;
    
}

@end
