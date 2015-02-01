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

@interface ProjectController ()

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

- (void)addProjectWithTitle:(NSString*)title {
    
    // This is how you create new instances of the objects you're storing in Core Data
    Project *project = [NSEntityDescription insertNewObjectForEntityForName:@"Project" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    project.title = title;
    
    [self save];
}

- (void)removeProject:(Project *)project {
    
   // This is how you remove an object from Core Data
   [[Stack sharedInstance].managedObjectContext deleteObject:project];
    
    [self save];
    
}

// ** Basically, instead of having an array of your objects inside this ProjectController, you'll have access to
// different "get" or "fetch" methods that will grab it from Core Data and hand it back so you can use it **
- (NSArray *)getProjects {
    
    // This is how you "fetch" objects from core data so you can use them in your app
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Project"];
    NSArray *array = [[Stack sharedInstance].managedObjectContext executeFetchRequest:request error:nil];

    return array;
}


- (void)addEntryToProject:(Project *)project withStartTime:(NSDate*)startTime andEndTime:(NSDate*)endTime {
    
    // You'll have to update this to work with Core Data like the methods above do
    // note that adding an try to a project will be slightly more difficult than the example above
    // because its a relation, not just a simple string
   
    
    
//    NSMutableArray *mutableEntries = [[NSMutableArray alloc] initWithArray:self.entries];
//    [mutableEntries addObject:entry];
//    
//    self.entries = mutableEntries;
}

- (NSArray*)getEntriesForProject:(Project *)project {
    
    // Same thing, you'll have to implement this
    
    return nil;
}

-(void)save{
    
    [[Stack sharedInstance].managedObjectContext save:NULL];
}
@end
