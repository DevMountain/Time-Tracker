//
//  Project.m
//  Time-Tracker
//
//  Created by Daniel Bladh on 1/24/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "Project.h"
#import "Entry.h"

#import "ProjectController.h"

static NSString * const titleKey= @"title";
static NSString * const entriesKey= @"entries";

@interface Project ()

@property (nonatomic, strong) Entry *currentEntry;

@end

@implementation Project

-(id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _entries = dictionary[titleKey];
        
        NSMutableArray *entries= [NSMutableArray new];
        for (NSDictionary *entry in dictionary [entriesKey]) {
            [entries addObject:[[Entry alloc] initWithDictionary:entry]];
        }
        
        _entries = entries;
    }
    
    return self;
}

-(NSDictionary *)projectDictionary {
    
    NSMutableDictionary *projectDictionary= [NSMutableDictionary new];
    if (self.title) {
        [projectDictionary setObject:self.title forKey:titleKey];
        
    }
    
    NSMutableArray *entries= [NSMutableArray new];
    for (Entry *entry in self.entries) {
        [entries addObject:[entry entryDictionary]];
    }
    [projectDictionary setObject:entries forKey:entriesKey];
    
    return projectDictionary;
}

-(NSString *)projectTime {
    
    NSInteger totalHours= 0;
    NSInteger totalMinutes= 0;
    
    for (Entry *entry in self.entries) {
        
        NSTimeInterval  distanceBetweenDates= [entry.endTime timeIntervalSinceDate:entry.startTime];
    
        double secondsInAnHour= 3600;
        NSInteger hoursBetweenDates= distanceBetweenDates / secondsInAnHour;
        
        double secondsInAMinute= 60;
        NSInteger minutesBetweenDates= (distanceBetweenDates - (hoursBetweenDates * secondsInAnHour)) / secondsInAMinute;
        
        totalHours += hoursBetweenDates;
        totalMinutes += minutesBetweenDates;
    }
    
    NSString* hourString= totalHours < 10 ? [NSString stringWithFormat:@"0%ld", (long) totalHours] : [NSString stringWithFormat:@"0%ld", (long) totalHours];
    
    NSString* minutesString= totalMinutes < 10 ? [NSString stringWithFormat:@"0%ld", (long) totalMinutes] : [NSString stringWithFormat:@"0%ld", (long) totalMinutes];
    
    return [NSString stringWithFormat:@"%@:%@", hourString, minutesString];
    
}

-(void)addEntry:(Entry *)entry{
    NSMutableArray *mutableEntries = [[NSMutableArray alloc] initWithArray:self.entries];
    [mutableEntries addObject:entry];
    
    self.entries = mutableEntries;
}

@end
