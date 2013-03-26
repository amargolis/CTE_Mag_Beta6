//
//  NavigationViewController.m
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import "NavigationViewController.h"

#import "NavDetailViewController.h"

#import "articleParser.h"

#import "ArticleList.h"


@interface NavigationViewController ()

@end

@implementation NavigationViewController

//@synthesize app;

@synthesize articlelistArray;

@synthesize artList;


#pragma mark - View Life Cycle Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Articles";
        // Custom Tab Image
        self.tabBarItem.image = [UIImage imageNamed:@"162-receipt"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.tableView.rowHeight = 50;
    
    UIImage *image = [UIImage imageNamed:@"CTEvector.png"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];

    self.navigationController.navigationBar.barStyle=UIBarStyleBlack;
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://nst.us.to/AppSupport/articles.xml"];
    
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    
    NSXMLParser *articlexmlParser = [[NSXMLParser alloc] initWithData:data];
    
    ///removed below, moved to appdelegate
    ////articleParser *thearticleparser = [[articleParser alloc] initarticleParser];
    articleParser *thearticleparser = [[articleParser alloc] initarticleParser];
    
    [articlexmlParser setDelegate:thearticleparser];
    
    //changed setDelegate to thearticleparser from self, change back if issues
    
    BOOL worked = [articlexmlParser parse];
    
    if (worked) {
        NSLog(@"Amount %i", [articlelistArray count]);
        NSMutableArray *articless = [thearticleparser articless];
    }
    else {
        NSLog(@"boo");
        
    }
    
}

#pragma mark - Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [app.articlelistArray count];
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
    artList = [app.articlelistArray objectAtIndex:indexPath.row];
    
    //Set the text attribute to whatever we are currently looking at in our array    
    cell.textLabel.text = artList.ARTICLE_TITLE;
    cell.detailTextLabel.text = artList.ARTICLE_PAGE;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont fontWithName:@"Optima-Bold" size:17];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Optima-Bold" size:11];
    cell.textLabel.numberOfLines = 0;
    
    
    //Return the cell
    return cell;
    
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [[articlelistArray objectAtIndex:indexPath.row]
                   sizeWithFont:[UIFont fontWithName:@"Optima-Bold" size:17]
                   constrainedToSize:CGSizeMake(300, CGFLOAT_MAX)];
    return size.height + 65;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NavDetailViewController *NDVC = [[NavDetailViewController alloc] init];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    artList = [app.articlelistArray objectAtIndex:indexPath.row];
    
    NDVC.artList = artList;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController pushViewController:NDVC animated:YES];
    
}




@end
