//
//  SelectViewController.m
//  iLudo
//
//  Created by Guillaume Garcera on 20/08/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SelectViewController.h"


@implementation SelectViewController

@synthesize curGame;
@synthesize selectItems;
@synthesize attribute;
@synthesize entity;
@synthesize localizedName;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.entity = nil;
    self.selectItems = nil;
    self.curGame = nil;
    self.attribute = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
	if (entity != NULL)
    {
        NSManagedObjectContext *context = [curGame managedObjectContext];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:entity];
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        NSError *error = nil;
        NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
        self.selectItems = items;
        [fetchRequest release];
        [sortDescriptor release];
        [sortDescriptors release];
        [self.tableView reloadData];
        
        NSString *title = [[NSString alloc] initWithFormat:@"Choix %@", self.localizedName];
        self.title = title;
        [title release];

    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [selectItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SelectCell";
    NSManagedObject *relationCellValue, *relationValue;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    relationCellValue = [selectItems objectAtIndex:indexPath.row];
    relationValue = [curGame valueForKey:attribute];
    // Configure the cell...
    cell.textLabel.text = [relationCellValue valueForKey:@"name"];
    if (curGame != NULL && [relationValue isEqual:relationCellValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSManagedObject *relationValueSet;
    relationValueSet = [selectItems objectAtIndex:indexPath.row];
    if (relationValueSet != NULL)
        [curGame setValue:relationValueSet forKey:attribute];
}

#pragma mark custom methods

- (void)setRelationToSelect:(NSString *)relationName{
    NSEntityDescription *gameEntity = [curGame entity];
    NSDictionary *relationships = [gameEntity relationshipsByName];
    NSRelationshipDescription *relationDescription = [relationships objectForKey:relationName];
    if (relationDescription != NULL)
    {
        self.attribute = relationName;
        self.entity = [relationDescription destinationEntity];
        NSString *name =  [[entity userInfo] objectForKey:@"UIName"];
        if (name != NULL)
        {
            self.localizedName =name;
            [name release];
        }
    }
    else
        NSLog(@"no relation named %@ in object", relationName);
    
}

@end
