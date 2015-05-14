//
//  TTDetailViewController.m
//  Time-Tracker
//
//  Created by Joshua Howland on 6/6/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "TTDetailViewController.h"
#import "ProjectController.h"

#import "TTDetailDataSource.h"

#import "TTCustomEntryViewController.h"

#import <MessageUI/MessageUI.h>

@interface TTDetailViewController () <UITableViewDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate>

//Link up properties
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UITextField *titleField;

@property (nonatomic, strong) TTDetailDataSource *datasource;

- (IBAction)add:(id)sender;
- (IBAction)clockIn:(id)sender;
- (IBAction)clockOut:(id)sender;
- (IBAction)report:(id)sender;

@end

@implementation TTDetailViewController

//instatiate a new dataSource
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.datasource = [TTDetailDataSource new];
    }
    return self;
}

//reload the tableViews data
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

//set the titleField/timeLabel.texts using the project.title
//set the titleFields delegate to self
//set the dataSource.project to the project property
//set the tableView.dataSouce to the dataSource property
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.titleField.text = self.project.title;
    self.titleField.delegate = self;
    self.timeLabel.text = [self.project projectTime];

    self.datasource.project = self.project;
    self.tableView.dataSource = self.datasource;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Add action on storyboard create a newViewController and set the vcs property to the project property
- (IBAction)add:(id)sender {
    
    TTCustomEntryViewController *entryViewController = [TTCustomEntryViewController new];
    entryViewController.project = self.project;
    
    [self presentViewController:entryViewController animated:YES completion:nil];
    
}

//create a new entry
- (IBAction)clockIn:(id)sender {

    [self.project startNewEntry];
    [self.tableView reloadData];
}

//end the currentEntry
- (IBAction)clockOut:(id)sender {

    [self.project endCurrentEntry];
    [self.tableView reloadData];
    
}

- (IBAction)report:(id)sender {

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//set the project.title to the textFields.text
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    self.project.title = textField.text;
    [[ProjectController sharedInstance] synchronize];
    
    return YES;
}
//Create a MFMailCompseViewController
//set the delegate on the mailComposrVC
- (IBAction)sendEmail:(id)sender {
    
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
    mailViewController.mailComposeDelegate = self;
    
    //Create a message body
    NSString *messageBody;
    
    for (Entry *entry in self.project.entries) {
        
        if (messageBody) {
            messageBody = [NSString stringWithFormat:@"%@\n%@ to %@\n", messageBody, entry.startTime, entry.endTime];
        } else {
            messageBody = [NSString stringWithFormat:@"\n%@ to %@\n", entry.startTime, entry.endTime];
        
        }
    }
    
    //set the message body to the message body string
    [mailViewController setMessageBody:messageBody isHTML:NO];
    
    [self presentViewController:mailViewController animated:YES completion:nil];
    
}
//enable the cancel button
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
