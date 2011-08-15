//
//  GameEditController.m
//  iLudo
//
//  Created by Guillaume Garcera on 09/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameEditController.h"


@implementation GameEditController

@synthesize gameNameTF;
@synthesize gameMaxPlayer;
@synthesize gameMinPlayerTF;
@synthesize gameDescriptionTF;
@synthesize editingContext;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)iniWithPrimaryManagedObjectContext:(NSManagedObjectContext *)primaryMOC{
    if (self = [super initWithNibName:@"GameEditController" bundle:nil]) {
        editingContext = [[NSManagedObjectContext alloc] init];
        [editingContext setPersistentStoreCoordinator: [primaryMOC persistentStoreCoordinator]];
    }
    return self;
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (curGame)
    {
        gameNameTF.text = curGame.name;
        gameMinPlayerTF.text = [NSString stringWithFormat:@"%i", curGame.min_player];
        gameMaxPlayerTF.text = [NSString stringWithFormat:@"%i", curGame.max_player];        
    }
        
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Custom Methods

-(void)setCurrentGame:(Game*)aGame{
    if (!aGame) {
        self.title = @"Ajout Jeux";
        aGame = [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:self.editingContext];
    }
    else if ([aGame managedObjectContext] != self.editingContext) {
        self.title = @"Edition Jeu";
        aGame = (id)[self.editingContext objectWithID:[aGame objectID]];
    }
    if (curGame != aGame) {
        [curGame release];
        curGame = [aGame retain];
    }
}



@end
