//
//  SecondNavigationViewController.m
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import "SecondNavigationViewController.h"

#import "SecondNavDetailViewController.h"

#import "headlineParser.h"

@interface SecondNavigationViewController ()

@end

@implementation SecondNavigationViewController

//@synthesize app;

@synthesize headlineslistArray;

@synthesize headList;

#pragma mark - View Life Cycle Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Headlines";
        // Custom Tab Image
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    NSURL *url = [[NSURL alloc] initWithString:@"http://nst.us.to/AppSupport/headlines.xml"];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    
    NSXMLParser *headlinexmlParser = [[NSXMLParser alloc] initWithData:data];
    
    ///removed below, moved to appdelegate
    ////headlineParser *theheadlineparser = [[headlineParser alloc] initheadlineParser];
    
    [headlinexmlParser setDelegate:self];
    
    BOOL worked = [headlinexmlParser parse];
    
    if (worked) {
        NSLog(@"Amount %i", [headlineslistArray count]);
    }
    else {
        NSLog(@"boo");
        
    }
    
    
    [self.tableView reloadData];
    
    
}

#pragma mark - Table View Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [app.headlineslistArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Create an NSString object that we can use as the reuse identifier
    static NSString *CellIdentifier =@"Cell";
    
    //Check to see if we can reuse a cell from a row that has just rolled off the screen
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    //If there are no cells to be reused, create a new cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    headList = [app.headlineslistArray objectAtIndex:indexPath.row];
    
    //Set the text attribute to whatever we are currently looking at in our array
    cell.textLabel.text = headList.content;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont fontWithName:@"Optima" size:17];
    cell.textLabel.numberOfLines = 2;
    
    //Return the cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SecondNavDetailViewController *SNDVC = [[SecondNavDetailViewController alloc] init];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    headList = [app.headlineslistArray objectAtIndex:indexPath.row];
    
    SNDVC.headList = headList;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:SNDVC animated:YES];
    
}



@end
