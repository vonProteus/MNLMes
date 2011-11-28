//
//  Nodes.h
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-20.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Elements;

@interface Nodes : NSManagedObject

@property (nonatomic, retain) NSNumber * dx;
@property (nonatomic, retain) NSNumber * dy;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSNumber * y;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSNumber * ex;
@property (nonatomic, retain) NSNumber * ey;
@property (nonatomic, retain) NSSet *lok;


@end

@interface Nodes (CoreDataGeneratedAccessors)

- (void)addLokObject:(Elements *)value;
- (void)removeLokObject:(Elements *)value;
- (void)addLok:(NSSet *)values;
- (void)removeLok:(NSSet *)values;

@end
