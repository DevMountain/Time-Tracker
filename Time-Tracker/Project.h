//
//  Project.h
//  Project
//
//  Created by Joshua Howland on 5/30/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entry.h"

@interface Project : NSObject

//Create a title and entires property
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *entries;

//Make methods public
- (NSDictionary *)projectDictionary;
- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSString *)projectTime;

- (void)startNewEntry;
- (void)endCurrentEntry;

- (void)addEntry:(Entry *)entry;
- (void)removeEntry:(Entry *)entry;

- (void)synchronize;

@end
