//
//  Entry.m
//  Time-Tracker
//
//  Created by Joshua Howland on 6/6/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "Entry.h"

static NSString * const startTimeKey = @"startTime";
static NSString * const endTimeKey = @"endTime";

@implementation Entry


//Create initWithDictionart Method
- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        
        self.startTime = dictionary[startTimeKey];
        self.endTime = dictionary[endTimeKey];
        
    }
    return self;
}

//Create a dictionary 
- (NSDictionary *)entryDictionary {

    NSMutableDictionary *entryDictionary = [NSMutableDictionary new];

    if (self.startTime) {
        [entryDictionary setObject:self.startTime forKey:startTimeKey];
    }
    if (self.endTime) {
        [entryDictionary setObject:self.endTime forKey:endTimeKey];
    }
    
    return entryDictionary;
}

@end
