//
//  Project.h
//  Time-Tracker
//
//  Created by Daniel Bladh on 1/24/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Entry.h"

@interface Project : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *entries;

-(NSDictionary *)projectDictionary;
-(id)initWithDictionary: (NSDictionary *)dictionary;

-(NSString *)projectTime;

-(void)startNewEntry;
-(void)endCurrentEntry;

-(void)addEntry:(Entry *)entry;
-(void)removeEntry:(Entry *)entry;

-(void)synchronize;
@end
