//
//  NodesNoCD.m
//  MNLMes
//
//  Created by Maciej Krok on 2011-12-27.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NodesNoCD.h"
#include "ElementsNoCD.h"

@implementation NodesNoCD

@synthesize dx;
@synthesize dy;
@synthesize number;
@synthesize x;
@synthesize y;
@synthesize status;
@synthesize ex;
@synthesize ey;
@synthesize lok;

-(id) init{
    coreData = [CDModel sharedModel];
    self.lok = [[NSMutableSet alloc] init];
    return self;
}

-(id) initWithNodesCD:(Nodes *)n{
    self = [self init];
    self.dx = n.dx;
    self.dy = n.dy;
    self.number = n.number;
    self.x = n.x;
    self.y = n.y;
    self.status = n.status;
    self.ex = n.ex;
    self.ey = n.ey;
    
    
    return self;
}


-(NSPoint) pointValue{
    return NSMakePoint([self.x doubleValue], [self.y doubleValue]);
}

-(NSPoint) pointValueDxDy{
    return NSMakePoint([self.x doubleValue] + [self.dx doubleValue], [self.y doubleValue]+ [self.dy doubleValue]);
}

-(void) dlog{
    NSUInteger lokCount = [self.lok count];
    DLog(@"%@ (%f,%f) dx:%f dy:%f ex:%f ey:%f status:%@ lokSize:%ld", self.number, [self.x doubleValue], [self.y doubleValue], [self.dx doubleValue], [self.dy doubleValue], [self.ex doubleValue], [self.ey doubleValue], self.status, lokCount);
}

-(double) getFunNodeWithA:(double)a 
                     andb:(double)b 
                     andE:(double)E 
                     andk:(double)k{
    double getFunNode = 0;
    double Je = 0;
    
    for (ElementsNoCD* e in self.lok) {
        Je = [e clcFunkcionalWithA:a 
                              andb:b 
                              andE:E 
                              andk:k];
        getFunNode += Je;
    }
    
    
    return getFunNode;
}


@end
