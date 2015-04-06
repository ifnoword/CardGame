//
//  PlayerTableViewController.m
//  CardGame1
//
//  Created by MEI C on 2/26/14.
//  Copyright (c) 2014 James Cremer. All rights reserved.
//

#import "PlayerTableViewController.h"
#import "DetailedPlayerController.h"

@interface PlayerTableViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *playerList;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation PlayerTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) viewWillAppear:(BOOL)animated{
    self.playerList =[NSArray arrayWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:@"playerlist"]];
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //self.tableView.backgroundColor =[UIColor colorWithRed:0/255.0 green:128.0/255.0 blue:64.0/255.0 alpha:1];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    UINavigationItem *navIterm =self.navigationItem;
    navIterm.backBarButtonItem = [[UIBarButtonItem alloc] init];
    navIterm.backBarButtonItem.title = @"Back";
    if ([segue.identifier isEqualToString:@"ShowPlayerDetail"]) {
        NSLog(@"segue activates");
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailedPlayerController  *childvc = segue.destinationViewController;
        childvc.playerName = [[self.playerList objectAtIndex:indexPath.row] objectForKey:@"name"];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.playerList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"playerTableCell"];
    //cell.textLabel.textColor = [UIColor colorWithRed:0/255.0 green:128.0/255.0 blue:64.0/255.0 alpha:1];
    cell.textLabel.text = [[self.playerList objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    // Configure the cell...
    
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
