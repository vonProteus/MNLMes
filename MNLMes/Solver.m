//
//  Solver.m
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Solver.h"


@implementation Solver

- (id) init{
    coreData = [CDModel sharedModel];
    
    return self;
}

-(void) go{
    
//    NSUInteger grnh = [[coreData allNodes] count];
    
    double FO = 0;
    
    for (NSUInteger iter = 0; iter < 800; ++iter) {
        for (Nodes* node in [coreData allNodes]) {
            if (node.status == 0) {
                F0 = 
            }
        }
    }
    
}

@end
