//
//  ProjectController.m
//  Project
//
//  Created by Joshua Howland on 5/30/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "ProjectController.h"

static NSString * const projectListKey = @"projectList";

@interface ProjectController ()

@property (nonatomic, strong) NSArray *projects;

@end

@implementation ProjectController

+ (ProjectController *)sharedInstance {
    static ProjectController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ProjectController alloc] init];
    
        [sharedInstance loadFromDefaults];
    });
    return sharedInstance;
}

- (void)setProjects:(NSArray *)projects {
    _projects = projects;
    
    [self synchronize];
}

- (void)addProject:(Project *)project {

    if (!project) {
        return;
    }
    
    NSMutableArray *mutableProject = [[NSMutableArray alloc] initWithArray:self.projects];
    [mutableProject addObject:project];

    self.projects = mutableProject;
}

- (void)removeProject:(Project *)project {
    
    if (!project) {
        return;
    }

    NSMutableArray *mutableProject = self.projects.mutableCopy;
    [mutableProject removeObject:project];
    
    self.projects = mutableProject;
    
}

- (void)loadFromDefaults {
    
    NSArray *projectDictionaries = [[NSUserDefaults standardUserDefaults] objectForKey:projectListKey];
    
    NSMutableArray *projects = [NSMutableArray new];
    for (NSDictionary *project in projectDictionaries) {
        [projects addObject:[[Project alloc] initWithDictionary:project]];
    }
    
    self.projects = projects;
    
}

- (void)synchronize {
    
    NSMutableArray *projectDictionaries = [NSMutableArray new];
    for (Project *project in self.projects) {
        [projectDictionaries addObject:[project projectDictionary]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:projectDictionaries forKey:projectListKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

@end
