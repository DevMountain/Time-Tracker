//
//  ProjectController.m
//  Time-Tracker
//
//  Created by Daniel Bladh on 1/24/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "ProjectController.h"
#import "Entry.h"
#import "Stack.h"
#import <CoreData/CoreData.h>

static NSString* const projectListKey= @"projectList";

@interface ProjectController ()

@property (nonatomic, strong) NSArray* project;
@property (nonatomic, strong) Entry *currentEntry;

@end

@implementation ProjectController
//
//+(ProjectController *)sharedInstance {
//    static ProjectController *sharedInstance =nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^){
//        sharedInstance = [[ProjectController alloc] init];
//        
//        [sharedInstance loadFromDefaults];
//    });
//    return sharedInstance;
//}
//
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
    NSMutableArray *mutableEntries = [[NSMutableArray alloc] initWithArray:self.entries];
    [mutableEntries addObject:entry];
    
    self.entries = mutableEntries;
}

-(void)startNewEntry{
    Entry *entry = [Entry new];
    entry.startTime = [NSDate date];
    
    self.currentEntry = entry;
    
    [self addEntry:entry];
}

- (void)endCurrentEntry {
    
    self.currentEntry.endTime = [NSDate date];
    [self save];
}


- (void)addProjectWithTitle:(NSString*)title{
    Project *newProject = [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    newProject.title = title;
    
    [self save];
}


-(void)removeProject:(Project *)project {
    [[Stack sharedInstance].managedObjectContext deleteObject:project];
    
    [self save];
    
}

-(void)save{
    
    [[Stack sharedInstance].managedObjectContext save:NULL];
}
@end
