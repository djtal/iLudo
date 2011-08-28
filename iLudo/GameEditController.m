//
//  GameEditController.m
//  iLudo
//
//  Created by Guillaume Garcera on 09/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameEditController.h"

#define kSelectTableAttrCount   2
#define kSectionTarget          0
#define kSectionTime            1

@implementation GameEditController

@synthesize gameNameTF;
@synthesize gameMaxPlayerTF;
@synthesize gameMinPlayerTF;
@synthesize gameLevelSegmentedField;
@synthesize attrTableSelect;
@synthesize editingContext;
@synthesize selectViewController;
@synthesize curGame;


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
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveGame:)];
    self.navigationItem.rightBarButtonItem = doneButton;
    [doneButton release];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelGame:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];  
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.gameLevelSegmentedField = nil;
    self.gameMaxPlayerTF = nil;
    self.gameMinPlayerTF = nil;
    self.gameNameTF =  nil;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateInterfaceForCurrentPerson];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender{
    [gameNameTF resignFirstResponder];
    [gameMinPlayerTF resignFirstResponder];
    [gameMaxPlayerTF resignFirstResponder];
}

-(void)dealloc{
    [gameNameTF release];
    [gameMaxPlayerTF release];
    [gameMinPlayerTF release];
    [gameLevelSegmentedField release];
    [attrTableSelect release];
    [super dealloc];
}

#pragma mark - Table view DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return kSelectTableAttrCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* AttrCellIdentifier = @"AttrCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AttrCellIdentifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AttrCellIdentifier] autorelease];
    }
    switch (indexPath.section) {
        case kSectionTarget:
            cell.textLabel.text =  [curGame valueForKeyPath:@"target.name"];
            break;
        case kSectionTime:
            cell.textLabel.text =  [curGame valueForKeyPath:@"time.name"];;
        default:
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *title;
    switch (section) {
        case kSectionTarget:
            
            title = @"Public";
            break;
        case kSectionTime:
            title =  @"Duree";
            break;
            
        default:
            title = @"";
            break;
    }
    return title;
}

#pragma mark - tableView Delegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self showSelectViewController: indexPath];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    [self showSelectViewController: indexPath];
}





#pragma mark - Custom Methods

- (void)showSelectViewController:(NSIndexPath*)indexPath{
    SelectViewController *viewController;
    if (!self.selectViewController) {
        viewController = [[SelectViewController alloc] initWithStyle:UITableViewStylePlain ];
        viewController.curGame = self.curGame;
        self.selectViewController = viewController;
        [viewController release];
    }
    self.selectViewController.curGame = curGame;
    switch ([indexPath section]) {
        case kSectionTime:
            [self.selectViewController setRelationToSelect:@"time"];
            break;
            
        case kSectionTarget:
            [self.selectViewController setRelationToSelect:@"target"];
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:self.selectViewController animated:YES];  
}

- (IBAction)saveGame:(id)sender{
    curGame.name = gameNameTF.text;
    curGame.min_player = [NSNumber numberWithInt:gameMinPlayerTF.text.integerValue];
    curGame.max_player = [NSNumber numberWithInt:gameMaxPlayerTF.text.integerValue];
    curGame.level = [NSNumber numberWithInt:[gameLevelSegmentedField selectedSegmentIndex]];
    
    NSError *anyError = nil;
    BOOL success = [[curGame managedObjectContext] save:&anyError];
    if (!success) {
        NSLog(@"Error saving %@", anyError);
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:[anyError localizedDescription] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [errorAlert show];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)cancelGame:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateInterfaceForCurrentPerson{
    gameNameTF.text = curGame.name;
    gameMinPlayerTF.text = curGame.min_player.description;
    gameMaxPlayerTF.text = curGame.max_player.description;  
    gameLevelSegmentedField.selectedSegmentIndex = curGame.level.integerValue;
    [self.attrTableSelect reloadData];
}

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
