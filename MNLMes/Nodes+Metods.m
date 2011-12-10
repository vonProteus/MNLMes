//
//  Nodes+Metods.m
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Nodes+Metods.h"
#import "Elements+Metods.h"
#import "PlistConf.h"

@implementation Nodes (Metods)

-(NSPoint) pointValue{
    return NSMakePoint([self.x doubleValue], [self.y doubleValue]);
}

-(NSPoint) pointValueDxDy{
    return NSMakePoint([self.x doubleValue] + [self.dx doubleValue], [self.y doubleValue]+ [self.dy doubleValue]);
}

-(void) dlog{
    DLog(@"%@ (%f,%f) dx:%f dy:%f ex:%f ey:%f status:%@", self.number, [self.x doubleValue], [self.y doubleValue], [self.dx doubleValue], [self.dy doubleValue], [self.ex doubleValue], [self.ey doubleValue], self.status);
}

-(double) getFunNodeWithA:(double)a 
                     andb:(double)b 
                     andE:(double)E 
                     andk:(double)k{
    double getFunNode = 0;
    double Je = 0;
    
    for (Elements* e in self.lok) {
        Je = [e clcFunkcionalWithA:a 
                              andb:b 
                              andE:E 
                              andk:k];
        getFunNode += Je;
    }
    
    
    return getFunNode;
}



@end
