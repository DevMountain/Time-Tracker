//
//  Project.m
//  Project
//
//  Created by Joshua Howland on 5/30/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "Project.h"
#import "Entry.h"

#import "ProjectController.h"

static NSString * const titleKey = @"title";
static NSString * const entriesKey = @"entries";

@interface Project ()

@property (nonatomic, strong) Entry *currentEntry;

@end

@implementation Project

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _title = dictionary[titleKey];

        NSMutableArray *entries = [NSMutableArray new];
        for (NSDictionary *entry in dictionary[entriesKey]) {
            [entries addObject:[[Entry alloc] initWithDictionary:entry]];
        }
        
        _entries = entries;

    }
    return self;
}

- (NSDictionary *)projectDictionary {

    NSMutableDictionary *projectDictionary = [NSMutableDictionary new];
    if (self.title) {
        [projectDictionary setObject:self.title forKey:titleKey];
    }
    
    NSMutableArray *entries = [NSMutableArray new];
    for (Entry *entry in self.entries) {
        [entries addObject:[entry entryDictionary]];
    }
    [projectDictionary setObject:entries forKey:entriesKey];
    
    return projectDictionary;
}

- (NSString *)projectTime {
    return @"00:00";
}

- (void)synchronize {

    [[ProjectController sharedInstance] synchronize];

}

- (void)setEntries:(NSArray *)entries {
    _entries = entries;
    
    [self synchronize];
}

- (void)startNewEntry {

    Entry *entry = [Entry new];
    entry.startTime = [NSDate date];
    
    self.currentEntry = entry;
    
    [self addEntry:entry];
    
}

- (void)endCurrentEntry {
    
    self.currentEntry.endTime = [NSDate date];
    [self synchronize];
    
}

- (void)addEntry:(Entry *)entry {

    if (!entry) {
        return;
    }
    
    NSMutableArray *mutableEnries = [[NSMutableArray alloc] initWithArray:self.entries];
    [mutableEnries addObject:entry];
    
    self.entries = mutableEnries;

}

- (void)removeEntry:(Entry *)entry {

    if (!entry) {
        return;
    }
 
    NSMutableArray *mutableEntries = self.entries.mutableCopy;
    [mutableEntries removeObject:entry];
    
    self.entries = mutableEntries;
    
}

@end
