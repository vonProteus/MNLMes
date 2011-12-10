//
//  Nodes+Metods.h
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Nodes.h"

@interface Nodes (Metods)

-(NSPoint) pointValue;
-(NSPoint) pointValueDxDy;
-(void) dlog;
-(double) getFunNodeWithA:(double)a 
                     andb:(double)b 
                     andE:(double)E 
                     andk:(double)k;


@end
