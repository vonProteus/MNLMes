//
//  Nodes.m
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-14.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Nodes.h"


@implementation Nodes

@dynamic dx;
@dynamic dy;
@dynamic number;
@dynamic x;
@dynamic y;


-(NSPoint) pointValue{
    return NSMakePoint([self.x doubleValue], [self.y doubleValue]);
}

-(void) dlog{
    DLog(@"%i (%f,%f) dx:%f dy:%f", self.number, self.x, self.y, self.dx, self.dy);
}

@end
