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

@property (nonatomic, strong, readonly) NSArray *projects;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *entries;

+(ProjectController *)sharedInstance;

-(void)addProjectWithTitle:(Project *)project;
-(void)removeProject:(Project *)project;
-(void)save;

@end
