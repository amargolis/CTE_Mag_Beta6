//
//  AboutNavController.m
//  CTE_Mag_Beta6
//
//  Created by Andy Margolis on 3/4/13.
//  Copyright (c) 2013 Northshore Technology Services. All rights reserved.
//

#import "AboutNavController.h"

@interface AboutNavController ()

@end

@implementation AboutNavController

@synthesize aboutlist = _aboutlist;

#pragma mark - view life cycle methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"About", @"About");
        self.tabBarItem.image = [UIImage imageNamed:@"37-suitcase"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //Set up NSArray with some objects
    //_aboutlist = [[NSArray alloc] initWithObjects:@"Cutting Tool Engineering", @"Visit CTEMag.com", nil];
}

#pragma mark - Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return nil;
            break;
            
        case 1:
            return @"Corporate Office";
            break;
            
        case 2:
            return @"Legal";
            break;
            
        default:
            break;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
            
        case 1:
            return 4;
            break;
            
        case 2:
            return 2;
            break;
            
        default:
            break;
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Create an NSString object that we can use as the reuse identifier
    static NSString *CellIdentifier =@"Cell";
    
    //Check to see if we can reuse a cell from a row that has just rolled off the screen
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    //If there are no cells to be reused, create a new cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                //cell.textLabel.text = @"Cutting Tool Engineering (Image)";
                cell.detailTextLabel.text = @"Cutting Tool Engineering (Image)";
                break;
                
            case 1:
                //cell.textLabel.text = @"Visit us at CTEMag.com";
                cell.detailTextLabel.text = @"Visit us at CTEMag.com";
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"address";
                cell.detailTextLabel.text = @"1 Northfield Plaza                Suite 240                   Northfield, IL 60093";
                cell.detailTextLabel.numberOfLines = 3;
                cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
                [cell sizeToFit];
                break;
                
            case 1:
                cell.textLabel.text = @"phone";
                cell.detailTextLabel.text = @"+1 (847) 498-9100";
                break;
                
            case 2:
                cell.textLabel.text = @"fax";
                cell.detailTextLabel.text = @"+1 (847) 559-4444";
                break;
                
            case 3:
                cell.textLabel.text = @"email";
                cell.detailTextLabel.text = @"ctenews@jwr.com";
                break;
                
            default:
                break;
        }
    } else if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"fax";
                cell.detailTextLabel.text = @"+1 (847) 559-4444";
                break;
                
            case 1:
                cell.textLabel.text = @"email";
                cell.detailTextLabel.text = @"ctenews@jwr.com";
                break;
                
            default:
                break;
        }
        
    }

    //Return the cell
    return cell;
}

@end

