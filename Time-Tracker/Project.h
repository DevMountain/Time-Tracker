//
//  Project.h
//  Time-Tracker
//
//  Created by Daniel Bladh on 1/31/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Entry;

@interface Project : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Entry *entries;

@end
