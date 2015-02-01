//
//  ProjectController.m
//  Time-Tracker
//
//  Created by Daniel Bladh on 1/24/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//


#import <CoreData/CoreData.h>

#import "ProjectController.h"
#import "Entry.h"
#import "Stack.h"

//static NSString* const projectListKey= @"projectList";

@interface ProjectController ()

//@property (nonatomic, strong) NSArray* project;
//@property (nonatomic, strong) Entry *currentEntry;

@end

@implementation ProjectController

+(ProjectController *)sharedInstance {
    static ProjectController *sharedInstance =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ProjectController alloc] init];
    });
    return sharedInstance;
}

//-(void)setProjects:(NSArray *)projects{
//    _projects = projects;
//    
//    [self synchronize];
//}
//
//-(void)addProject:(Project *)project{
//    if(!project){
//        return;
//    }
//    NSMutableArray *mutableProject = [[NSMutableArray alloc] initWithArray:self.projects];
//}

-(void)addEntry:(Entry *)entry{
    
    // THIS NEEDS TO BE UPDATED TO SAVE ENTRY TO CORE DATA
    
//    NSMutableArray *mutableEntries = [[NSMutableArray alloc] initWithArray:self.entries];
//    [mutableEntries addObject:entry];
//    
//    self.entries = mutableEntries;
}

// I THINK THESE WILL GET MOVED TO A VIEW CONTROLLER
//-(void)startNewEntry{
//    Entry *entry = [Entry new];
//    entry.startTime = [NSDate date];
//    
//    self.currentEntry = entry;
//    
//    [self addEntry:entry];
//}
//
//- (void)endCurrentEntry {
//    
//    self.currentEntry.endTime = [NSDate date];
//    [self save];
//}


- (void)addProjectWithTitle:(NSString*)title{
    
    // NEEDS TO BE UPDATED TO INCLUDE CORE DATA WAY OF SAVING DATA
    
//    Project *newProject = [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
//    
//    newProject.title = title;
//    
//    [self save];
}


-(void)removeProject:(Project *)project {
    
    // NEEDS TO BE UPDATED TO INCLUDE CORE DATA WAY OF DELETING DATA
    
//    [[Stack sharedInstance].managedObjectContext deleteObject:project];
//    
//    [self save];
    
}

-(void)save{
    // NOT SURE IF THIS IS STILL NEEEDED
    [[Stack sharedInstance].managedObjectContext save:NULL];
}
@end
