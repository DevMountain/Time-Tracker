//
//  DetailViewController.m
//  Time-Tracker
//
//  Created by Daniel Bladh on 1/25/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "DetailViewController.h"
#import "CustomEntryViewController.h"
#import "Project.h"
#import "Entry.h"


@interface DetailViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.timeLabel.text = [self.project projectTime];
    self.titleTextField.text= self.project.title;
    self.detailTableView.dataSource = self;
    
    UITableView* detailTableView= [[UITableView alloc] initWithFrame:self.view.bounds];
    self.detailTableView= detailTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.project.entries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EntryCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"EntryCell"];
    }
    
    Entry *entry = [self.project entries][indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", entry.startTime, entry.endTime];
    
    return cell;
}

- (IBAction)add:(id)sender {
    CustomEntryViewController* customEntryController= [CustomEntryViewController new];
    [self.navigationController pushViewController:customEntryController animated:YES];
    
}
- (IBAction)clockIn:(id)sender {
    [self.project startNewEntry];
    [self.detailTableView reloadData];
}
- (IBAction)clockOut:(id)sender {
    [self.project endCurrentEntry];
    [self.detailTableView reloadData];
}
- (IBAction)report:(id)sender {
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)detailTableView :(UITableView *)detailTableView numberOfRowsInSection:(NSInteger)section{
    return [self.project.entries count];
}


-(NSString *)projectTime {
    
    NSInteger totalHours= 0;
    NSInteger totalMinutes= 0;
    
    for (Entry *entry in self.project.entries) {
        
        NSTimeInterval  distanceBetweenDates= [entry.endTime timeIntervalSinceDate:entry.startTime];
        
        double secondsInAnHour= 3600;
        NSInteger hoursBetweenDates= distanceBetweenDates / secondsInAnHour;
        
        double secondsInAMinute= 60;
        NSInteger minutesBetweenDates= (distanceBetweenDates - (hoursBetweenDates * secondsInAnHour)) / secondsInAMinute;
        
        totalHours += hoursBetweenDates;
        totalMinutes += minutesBetweenDates;
    }
    
    NSString* hourString= totalHours < 10 ? [NSString stringWithFormat:@"0%ld", (long) totalHours] : [NSString stringWithFormat:@"0%ld", (long) totalHours];
    
    NSString* minutesString= totalMinutes < 10 ? [NSString stringWithFormat:@"0%ld", (long) totalMinutes] : [NSString stringWithFormat:@"0%ld", (long) totalMinutes];
    
    return [NSString stringWithFormat:@"%@:%@", hourString, minutesString];
    
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

