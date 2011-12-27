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
    {
        NSString* stringTMP = [NSString stringWithFormat:@"start\n"];
        DLog(@"%@",stringTMP);
    }

    coreData = [CDModel sharedModel];
    progress = Nil;
    allNodesNoCD = [[NSMutableArray alloc] init];
    allElementsNoCD = [[NSMutableArray alloc] init];
    
    for (Nodes *nCD in [coreData allNodes]) {
        NodesNoCD* nNCD = [[NodesNoCD alloc] initWithNodesCD:nCD];
        [allNodesNoCD addObject:nNCD];
    }
   
    
    for (Elements* eCD in [coreData allElements]) {
        ElementsNoCD* eNCD = [[ElementsNoCD alloc] init];
        Nodes* n1 = eCD.n1;
        Nodes* n2 = eCD.n2;
        Nodes* n3 = eCD.n3;
        
        NodesNoCD* nNCD1 = [self findNodeNoCDWithNumber:[n1.number unsignedIntegerValue]];
        NodesNoCD* nNCD2 = [self findNodeNoCDWithNumber:[n2.number unsignedIntegerValue]];
        NodesNoCD* nNCD3 = [self findNodeNoCDWithNumber:[n3.number unsignedIntegerValue]];
        
        eNCD.n1 = nNCD1;
        eNCD.n2 = nNCD2;
        eNCD.n3 = nNCD3;
        
        [nNCD1.lok addObject:eNCD];
        [nNCD2.lok addObject:eNCD];
        [nNCD3.lok addObject:eNCD];
        
        [allElementsNoCD addObject:eNCD];
        
    }
    
    {
        NSString* stringTMP = [NSString stringWithFormat:@"nodes %ld/%ld elements %ld/%ld \n",[[coreData allNodes] count], [allNodesNoCD count], [[coreData allElements] count], [allElementsNoCD count]];
        DLog(@"%@",stringTMP);
    }
    
    for (NodesNoCD* n in allNodesNoCD) {
        NSUInteger nNumber = [n.number unsignedIntegerValue];
        NSUInteger nLokCount = [n.lok count];
        NSUInteger nStatus = [n.status unsignedIntegerValue];
        {
            NSString* stringTMP = [NSString stringWithFormat:@"%ld: lok %ld statius %ld\n", nNumber, nLokCount, nStatus];
            DLog(@"%@",stringTMP);
        }
        
    }

    
    {
        NSString* stringTMP = [NSString stringWithFormat:@"ok\n"];
        DLog(@"%@",stringTMP);
    }

    
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

        for (NodesNoCD* node in allNodesNoCD) {
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
                }
        }
    }
    [progress stopAnimation:nil];
    
    [self noCD2CD];
    
    {
        NSString* stringTMP = [NSString stringWithFormat:@"ok\n"];
        DLog(@"%@",stringTMP);
    }

    
    [coreData saveCD];
    
}
-(void) addProgressIndicator:(NSProgressIndicator*)pr{
    progress = pr;
}





-(NodesNoCD*) findNodeNoCDWithNumber:(NSUInteger)number{
    for (NodesNoCD* n in allNodesNoCD) {
        if ([n.number unsignedIntegerValue] == number) {
            return n;
        }
    }
    {
        NSString* stringTMP = [NSString stringWithFormat:@"error nie ma noda o nr %ld\n",number];
        DLog(@"%@",stringTMP);
    }

    return nil;
}


//@property (nonatomic, retain) NSNumber * dx;
//@property (nonatomic, retain) NSNumber * dy;
//@property (nonatomic, retain) NSNumber * number;
//@property (nonatomic, retain) NSNumber * x;
//@property (nonatomic, retain) NSNumber * y;
//@property (nonatomic, retain) NSNumber * status;
//@property (nonatomic, retain) NSNumber * ex;
//@property (nonatomic, retain) NSNumber * ey;

-(void)noCD2CD{
    for (Nodes* nCD in [coreData allNodes]) {
        NodesNoCD* nNCD = [self findNodeNoCDWithNumber:[nCD.number unsignedIntegerValue]];
        if (nNCD != nil) {
            nCD.dx = nNCD.dx;
            nCD.dy = nNCD.dy;
            nCD.x = nNCD.x;
            nCD.y = nNCD.y;
            nCD.ex = nNCD.ex;
            nCD.ey = nNCD.ey;
        }
    }
    [coreData saveCD];
}
@end
