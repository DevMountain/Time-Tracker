//
//  CustomEntryViewController.m
//  Time-Tracker
//
//  Created by Daniel Bladh on 1/25/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "CustomEntryViewController.h"
#import "DetailViewController.h"
#import "Entry.h"

@interface CustomEntryViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *startTimePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *endTimePicker;
@property (weak, nonatomic) IBOutlet UILabel *startPickerLabel;

@end

@implementation CustomEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)donePressed:(id)sender {
    
    Entry* newEntry= [Entry new];
    newEntry.startTime = self.startTimePicker.date;
    newEntry.endTime =  self.endTimePicker.date;
    
    DetailViewController *dvc = [DetailViewController new];
//    [dvc.project addEntry:newEntry];
    NSLog(@"%@", newEntry.startTime);
    
    [self.navigationController pushViewController:dvc animated:YES];
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
