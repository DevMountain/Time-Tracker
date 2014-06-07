//
//  TTCustomEntryViewController.m
//  Time-Tracker
//
//  Created by Joshua Howland on 6/7/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "TTCustomEntryViewController.h"

@interface TTCustomEntryViewController ()

@property (nonatomic, strong) IBOutlet UIDatePicker *startDatePicker;
@property (nonatomic, strong) IBOutlet UIDatePicker *endDatePicker;

@end

@implementation TTCustomEntryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)save:(id)sender {

    Entry *entry = [Entry new];
    entry.startTime = self.startDatePicker.date;
    entry.endTime = self.endDatePicker.date;
    
    [self.project addEntry:entry];
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
