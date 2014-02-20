//
//  Scheduling.h
//  Scheduling
//
//  Created by Brian Bian on 2/19/14.
//  Copyright (c) 2014 CIV Graphics, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Scheduling : NSObject

@property (strong, nonatomic) NSDictionary *dict;	// For storing the scheduling info
@property (strong, nonatomic) NSMutableSet *volunteerNames;	// For storing unique volunteer names

- (NSDictionary *) run;	// Get a random mapping (schedule)
- (int) score:(NSDictionary *) map;	// Evaluate the mapping (schedule) and return a score for it
@end
