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

#import "HeadlinesList.h"

#import "SVWebViewController.h"

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
        self.tabBarItem.image = [UIImage imageNamed:@"166-newspaper"];
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"CTEvector.png"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
    
    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://www.testserver.com/xml"];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    
    NSXMLParser *headlinexmlParser = [[NSXMLParser alloc] initWithData:data];
    
    ///removed below, moved to appdelegate
    ////headlineParser *theheadlineparser = [[headlineParser alloc] initheadlineParser];
    headlineParser *theheadlineparser = [[headlineParser alloc] initheadlineParser];
    
    [headlinexmlParser setDelegate:theheadlineparser];
    
    //changed setDelegate to theheadlineparser from self, change back if issues
    
    BOOL worked = [headlinexmlParser parse];
    
    if (worked) {
        NSLog(@"Amount %i", [headlineslistArray count]);
        NSMutableArray *headliness = [theheadlineparser headliness];
    }
    else {
        NSLog(@"Headline Parsing Failed - Check Internet Connection");
        
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    headList = [app.headlineslistArray objectAtIndex:indexPath.row];
    
    //Set the text attribute to whatever we are currently looking at in our array
    cell.textLabel.text = headList.content;
    cell.detailTextLabel.text = headList.dateadded;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont fontWithName:@"Optima-Bold" size:17];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Optima-Bold" size:10];
    cell.textLabel.numberOfLines = 0;
    
    //Return the cell
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [[headlineslistArray objectAtIndex:indexPath.row]
                   sizeWithFont:[UIFont fontWithName:@"Optima-Bold" size:17]
                   constrainedToSize:CGSizeMake(300, CGFLOAT_MAX)];
    return size.height + 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSURL *URL = [NSURL URLWithString:headList.url];
    SVWebViewController *webViewController = [[SVWebViewController alloc] initWithURL:URL];
    [self.navigationController pushViewController:webViewController animated:YES];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    headList = [app.headlineslistArray objectAtIndex:indexPath.row];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end
