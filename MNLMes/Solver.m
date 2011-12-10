//
//  Solver.m
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Solver.h"
#import "PlistConf.h"


@implementation Solver

- (id) init{
    coreData = [CDModel sharedModel];
    progress = Nil;
    
    return self;
}

-(void) go{
    
//    NSUInteger grnh = [[coreData allNodes] count];
    
    double F0 = 0;
    double Fplus = 0;
    NSUInteger numberOfIteration = [[PlistConf valueForKey:@"numberOfIteration"] unsignedIntegerValue];
    double grDVel = [[PlistConf valueForKey:@"grDVel"] doubleValue];
//    if(progress != nil){
//        progress.maxValue = numberOfIteration;
//        progress.minValue = 0;
//        [progress startAnimation:Nil];
//        {
//            NSString* stringTMP = [NSString stringWithFormat:@"jest progress\n"];
//            DLog(@"%@",stringTMP);
//        }
//    }
    
    for (NSUInteger iter = 0; iter < numberOfIteration; ++iter) {
//        {
//            NSString* stringTMP = [NSString stringWithFormat:@"iteracja :%ld\n", iter];
//            DLog(@"%@",stringTMP);
//        }
//        [progress setDoubleValue:iter];

        for (Nodes* node in [coreData allNodes]) {
            if ([node.status unsignedIntegerValue] == 0) {
                F0 = [node getFunNode];
                
                double newDx = [node.dx doubleValue];
                newDx += grDVel;
                node.dx = [NSNumber numberWithDouble:newDx];
                Fplus = [node getFunNode];
                if (Fplus > F0) {
                    newDx -= 2*grDVel;
                    node.dx = [NSNumber numberWithDouble:newDx];
                }

                
                double newDy = [node.dy doubleValue];
                newDy += grDVel;
                node.dy = [NSNumber numberWithDouble:newDy];
                Fplus = [node getFunNode];
                if (Fplus > F0) {
                    newDy -= 2*grDVel;
                    node.dy = [NSNumber numberWithDouble:newDy];
                }
                
                if (abs(F0) < 0.000000001) {
                    F0 = 0.000000001;
                }
                
                double dF = abs((Fplus - F0) / F0);
            }
        }
    }
    [progress stopAnimation:nil];
    
    [coreData saveCD];
    
}
-(void) addProgressIndicator:(NSProgressIndicator*)pr{
    progress = pr;
}

@end
