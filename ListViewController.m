//
//  ListViewController.m
//  Time-Tracker
//
//  Created by Daniel Bladh on 1/24/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ListViewController.h"
#import "ProjectController.h"
#import "DetailViewController.h"

@interface ListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView =[[UITableView alloc]initWithFrame:self.view.bounds];
    
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"The Cell"];
    
    UIBarButtonItem *addItem= [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newProject:)];
    self.navigationItem.rightBarButtonItem = addItem;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"The Cell"];
    return cell;
}
  
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(void)newProject: (id)sender{
    
//    Project *newProject = [Project new]; // We can't instantiate objects like this anymore because of Core Data
    DetailViewController *detailViewController = [DetailViewController new];
//    detailViewController.project= newProject;
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
