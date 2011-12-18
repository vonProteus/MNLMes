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
    
    
    double a = [[PlistConf valueForKey:@"aFromSi=a*Ei^b"] doubleValue];
    double b = [[PlistConf valueForKey:@"bFromSi=a*Ei^b"] doubleValue];
    
    double E = [[PlistConf valueForKey:@"EFromClcFunkcional"] doubleValue];
    double k = [[PlistConf valueForKey:@"kFromClcFunkcional"] doubleValue];
    
    
    for (NSUInteger iter = 0; iter < numberOfIteration; ++iter) {
        if(iter %100 == 0){
            NSString* stringTMP = [NSString stringWithFormat:@"jeszcze :%ld\n", numberOfIteration - iter];
            DLog(@"%@",stringTMP);
        }
//        [progress setDoubleValue:iter];

        for (Nodes* node in [coreData allNodes]) {
            if ([node.status unsignedIntegerValue] == 0) {
                F0 = [node getFunNodeWithA:a
                                      andb:b
                                      andE:E
                                      andk:k];
                
                double dx = [node.dx doubleValue];
                double newDx = dx + grDVel;
                node.dx = [NSNumber numberWithDouble:newDx];
                Fplus = [node getFunNodeWithA:a
                                         andb:b
                                         andE:E
                                         andk:k];
                if (Fplus > F0) {
                    newDx = dx - grDVel;
                    node.dx = [NSNumber numberWithDouble:newDx];
                }

                
                double dy = [node.dy doubleValue];
                double newDy = dy + grDVel;
                node.dy = [NSNumber numberWithDouble:newDy];
                Fplus = [node getFunNodeWithA:a
                                         andb:b
                                         andE:E
                                         andk:k];
                
                if (Fplus > F0) {
                    newDy = dy - grDVel;
                    node.dy = [NSNumber numberWithDouble:newDy];
                }
                
//                if (abs(F0) < 0.000000001) {
//                    F0 = 0.000000001;
//                }
                
//                double dF = abs((Fplus - F0) / F0);
                [coreData saveCD];
            }
        }
    }
    [progress stopAnimation:nil];
    
    {
        NSString* stringTMP = [NSString stringWithFormat:@"ok\n"];
        DLog(@"%@",stringTMP);
    }

    
    [coreData saveCD];
    
}
-(void) addProgressIndicator:(NSProgressIndicator*)pr{
    progress = pr;
}

@end
