//
//  main.m
//  Scheduling
//
//  Created by Brian Bian on 2/19/14.
//  Copyright (c) 2014 CIV Graphics, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Scheduling.h"
int main(int argc, const char * argv[])
{

	@autoreleasepool {
	    	    
		Scheduling *mySchedule = [[Scheduling alloc] init];
		mySchedule.dict = @{@"3/1" : @[@"Rebecca", @"Lily", @"Chen"],
							@"3/2" : @[@"Brian", @"Zenya"],
							@"3/3" : @[@"Keira"],
							@"3/4" : @[@"Lily", @"Brian"],
							@"3/5" : @[@"Rebecca", @"Chen", @"Keira"],
							@"3/6" : @[@"Keira", @"Zenya"],
							@"3/7" : @[@"Lily", @"Brian"],
							@"3/8" : @[@"Rebecca", @"Chen", @"Brian"]
							};
		
		int currentScore, bestScore = -999;
		NSDictionary *runMap, *bestMap;
		for (int i = 0; i < 1000; i ++) {
			// mySchedule.run() will return a random dictionary with single mapping
			runMap = [[mySchedule run] copy];
			currentScore = [mySchedule score:runMap];
			if (currentScore > bestScore) {
				// Remeber the mapping and score
				bestMap = [runMap copy];
				bestScore = currentScore;
				NSLog(@"Found new best score:%d", bestScore);
			}
		}
		
		// output mapping
		NSLog(@"Total number of days: %lu", (unsigned long)[bestMap count]);
		NSLog(@"Volunteers: %@", mySchedule.volunteerNames);
		NSArray *sortedKeys = [[bestMap allKeys] sortedArrayUsingSelector: @selector(compare:)];
		for (NSString *keyString in sortedKeys) {
			NSLog(@"%@: %@", keyString, [bestMap valueForKey:keyString]);
		}
	}
    return 0;
}

