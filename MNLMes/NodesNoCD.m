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

@dynamic dx;
@dynamic dy;
@dynamic number;
@dynamic x;
@dynamic y;
@dynamic status;
@dynamic ex;
@dynamic ey;
@dynamic lok;

-(id) init{
    coreData = [CDModel sharedModel];
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


@end
