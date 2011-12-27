//
//  ElementsNoCD.h
//  MNLMes
//
//  Created by Maciej Krok on 2011-12-27.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NodesNoCD.h"
#import "CDModel.h"

@interface ElementsNoCD : NSObject{
    CDModel* coreData;    
}

@property (nonatomic, retain) NodesNoCD *n1;
@property (nonatomic, retain) NodesNoCD *n2;
@property (nonatomic, retain) NodesNoCD *n3;


-(double) clcFunkcionalWithA:(double)a 
                        andb:(double)b 
                        andE:(double)E 
                        andk:(double)k;

@end
