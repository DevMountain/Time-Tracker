//
//  ProjectController.h
//  Time-Tracker
//
//  Created by Daniel Bladh on 1/24/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"

@interface ProjectController : NSObject

+(ProjectController *)sharedInstance;

-(void)addProjectWithTitle:(Project *)project;
-(void)removeProject:(Project *)project;
- (NSArray *)getProjects;

- (void)addEntryToProject:(Project *)project withStartTime:(NSDate*)startTime andEndTime:(NSDate*)endTime;
- (NSArray*)getEntriesForProject:(Project *)project;


@end
