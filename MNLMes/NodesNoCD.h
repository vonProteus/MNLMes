//
//  NodesNoCD.h
//  MNLMes
//
//  Created by Maciej Krok on 2011-12-27.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "CDModel.h"


@interface NodesNoCD : NSObject{
    CDModel* coreData;
}

-(id) initWithNodesCD:(Nodes*)n;


@property (nonatomic, retain) NSNumber * dx;
@property (nonatomic, retain) NSNumber * dy;
@property (nonatomic, retain) NSNumber * number;
@property (nonatomic, retain) NSNumber * x;
@property (nonatomic, retain) NSNumber * y;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSNumber * ex;
@property (nonatomic, retain) NSNumber * ey;
@property (nonatomic, retain) NSSet *lok;

-(NSPoint) pointValue;
-(NSPoint) pointValueDxDy;
-(void) dlog;
-(double) getFunNodeWithA:(double)a 
                     andb:(double)b 
                     andE:(double)E 
                     andk:(double)k;



@end
