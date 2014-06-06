//
//  TTDetailDataSource.h
//  Time-Tracker
//
//  Created by Joshua Howland on 6/6/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Project;

@interface TTDetailDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, strong) Project *project;

@end
