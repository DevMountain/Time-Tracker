//
//  TTListViewController.m
//  Time-Tracker
//
//  Created by Joshua Howland on 6/6/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "TTListViewController.h"
#import "TTListDataSource.h"

#import "ProjectController.h"
#import "TTDetailViewController.h"

//TableViewDelegate propery
@interface TTListViewController () <UITableViewDelegate>

@property (nonatomic, strong) TTListDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

//Instatiate a new dataSource
@implementation TTListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataSource = [TTListDataSource new];
    }
    return self;
}

//Reload the tableView
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

//Instatiate a newTableView
//Add that TableView as a subView
//set the delegate to self and the dataSource to the dataSource property we created
//Create a bar button item
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataSource;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newProject)];
    
    self.navigationItem.rightBarButtonItem = addButton;

}
//Create a new project and add the project to the project array
//Instatiate a new TTDetailViewController and set the new project to the project property on that VC
- (void)newProject
{
    Project *project = [Project new];
    [[ProjectController sharedInstance] addProject:project];
    
    TTDetailViewController *viewController = [TTDetailViewController new];
    viewController.project = project;
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

//Create a new project using the projects array and indexPath
//Instatiate a new TTDetailViewController and set the new project to the project property on that VC
//push to the TTDetailViewController
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Project *project = [ProjectController sharedInstance].projects[indexPath.row];
    
    TTDetailViewController *viewController = [TTDetailViewController new];
    viewController.project = project;
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

@end
