//
//  Nodes.h
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-14.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Nodes : NSManagedObject

@property (nonatomic, retain) NSNumber * dx;
@property (nonatomic, retain) NSNumber * dy;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSNumber * y;

-(NSPoint) pointValue;
-(void) dlog;
@end
