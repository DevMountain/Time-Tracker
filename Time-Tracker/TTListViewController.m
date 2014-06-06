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

@interface TTListViewController () <UITableViewDelegate>

@property (nonatomic, strong) TTListDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation TTListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataSource = [TTListDataSource new];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

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

- (void)newProject
{
    Project *project = [Project new];
    [[ProjectController sharedInstance] addProject:project];
    
    TTDetailViewController *viewController = [TTDetailViewController new];
    viewController.project = project;
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Project *project = [ProjectController sharedInstance].projects[indexPath.row];
    
    TTDetailViewController *viewController = [TTDetailViewController new];
    viewController.project = project;
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

@end
