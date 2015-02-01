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

@property (strong, nonatomic) NSArray *entries;
@property (strong, nonatomic) NSDate *entryStartTime;
@property (strong, nonatomic) NSDate *entryEndTime;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // since we have to create objects using Core Data now, a new project will result in self.project being nil
    if (self.project != nil) {
        
        self.timeLabel.text = [self projectTime];
        self.titleTextField.text= self.project.title;
        
        // here we're telling our ProjectController to go into core Data give us back all the entries for our project
        self.entries = [[ProjectController sharedInstance] getEntriesForProject:self.project];
    }
    
    self.detailTableView.dataSource = self;
    
    UITableView* detailTableView= [[UITableView alloc] initWithFrame:self.view.bounds];
    self.detailTableView= detailTableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // we have to take into consideration now that self.entries will be nil if it's a new project
    if (self.entries != nil) return self.entries.count;
    else return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EntryCell"];
    
    // I *THINK* this should still work
    Entry *entry = self.entries[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", entry.startTime, entry.endTime];
    
    return cell;
}

- (IBAction)add:(id)sender {
    
    CustomEntryViewController* customEntryController= [CustomEntryViewController new];
    [self.navigationController pushViewController:customEntryController animated:YES];
    
}
- (IBAction)clockIn:(id)sender {
    
    // When you clock in/out you just need to store the time so that when you tell your ProjectController to add an entry
    // to the project you have a start and end time to send to it
    self.entryStartTime = [NSDate new];
}
- (IBAction)clockOut:(id)sender {

    self.entryEndTime = [NSDate new];
}
- (IBAction)report:(id)sender {
    
}

-(NSString *)projectTime {
    
    NSInteger totalHours= 0;
    NSInteger totalMinutes= 0;
    
    for (Entry *entry in self.entries) {
        
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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

