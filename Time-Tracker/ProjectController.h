//
//  ProjectController.h
//  Project
//
//  Created by Joshua Howland on 5/30/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"

@interface ProjectController : NSObject

@property (nonatomic, strong, readonly) NSArray *projects;

+ (ProjectController *)sharedInstance;

- (void)addProject:(Project *)project;
- (void)removeProject:(Project *)project;

- (void)synchronize;

@end
