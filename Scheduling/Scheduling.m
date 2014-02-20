//
//  Scheduling.m
//  Scheduling
//
//  Created by Brian Bian on 2/19/14.
//  Copyright (c) 2014 CIV Graphics, LLC. All rights reserved.
//

#import "Scheduling.h"
@interface Scheduling()

@property (nonatomic, strong) NSMutableDictionary *scoreDict;
@end

@implementation Scheduling

// Lazy instantiation to build up the unique volunteer name set
- (NSSet *) volunteerNames
{
	if (!_volunteerNames){
		_volunteerNames = [[NSMutableSet alloc] initWithCapacity:30];
    }
	
	for (NSString *keyString in self.dict) {
		NSArray *valueArray = [self.dict objectForKey:keyString];
		for (NSString *name in valueArray) {
			[_volunteerNames addObject:name];
		}
	}
    return _volunteerNames;
}

#if 0
// Lazy instantiation to build up the unique volunteer name set
- (NSMutableDictionary *) scoreDict
{
	if (!_scoreDict){
		_scoreDict = [[NSMutableDictionary alloc] initWithCapacity:30];
    }
	
	for (NSString *keyString in self.volunteerNames) {
		[_scoreDict setValue:[NSNumber numberWithInt:0] forKey:keyString];
	}
    return _scoreDict;
}
#endif

- (NSDictionary *) run
{
	// Randomly pick a map that has only one value that is associated with a key
	NSMutableDictionary *newMap = [[NSMutableDictionary alloc] init];
	
	NSArray *keyArray =  [self.dict allKeys];
	NSUInteger keyCount = [keyArray count];
	for (int i = 0; i < keyCount; i++) {
		NSString *keyString = [keyArray objectAtIndex:i];
		NSArray *valueArray = [self.dict objectForKey:keyString];
		NSUInteger valueCount = [valueArray count];
		int randomIndex = arc4random() % valueCount;
		[newMap setValue:[valueArray objectAtIndex:randomIndex] forKey:keyString];
	}
	
	return newMap;
}

- (int) score:(NSDictionary *) map
{
	int points = 0;
	
	self.scoreDict = [[NSMutableDictionary alloc] initWithCapacity:30];
	for (NSString *keyString in self.volunteerNames) {
		[self.scoreDict setValue:[NSNumber numberWithInt:0] forKey:keyString];
	}
	
	// Next go over the map and increment the value for each key
	for (NSString *keyString in map) {
		NSString *nameOnDuty = [map objectForKey:keyString];
		NSNumber *number = [self.scoreDict valueForKey:nameOnDuty];
		int intVal = [number intValue];
		intVal++;
		number = [NSNumber numberWithInt:intVal];
		[self.scoreDict setValue:number forKey:nameOnDuty];
	}
	
	// Finally we are about to score this mapping:
	// Scoring criteria
	// If a value never appears: -10
	// If a value appears only once -1
	// If a value appear twice +3
	// If same value appear three times -1
	// If same value appear four times -2
	// If same value appear five times -5
	// If same value appear 6 or greater times -10
	
	for (NSString *volunteerName in self.scoreDict) {
		NSNumber *number = [self.scoreDict valueForKey:volunteerName];
		int intVal = [number intValue];
		switch (intVal) {
			case 0:
				points -= 10;
				break;
				
			case 1:
				points--;
				break;
				
			case 2:
				points += 3;
				break;
				
			case 3:
				points--;
				break;
				
			case 4:
				points -= 2;
				break;
				
			case 5:
				points -= 5;
				break;
				
			default:
				points -= 10;
		}
	}
	
	//NSLog(@"%@", self.scoreDict);
	
	return points;
}
@end
