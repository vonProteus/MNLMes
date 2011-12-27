//
//  GlobalController.m
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-13.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GlobalController.h"

@implementation GlobalController
-(id) init{
    coreData = [CDModel sharedModel];
    return self;
}
@synthesize fEMView;
@synthesize progress;

-(IBAction)cleanNodes:(id)sender{
    [self.progress startAnimation:Nil];
    for (Nodes* n in [coreData allNodes]){
        [coreData removeNodeByNumber:[n.number integerValue]];
    }
    
    [fEMView display];
    [self.progress stopAnimation:Nil];
}

-(IBAction)removeLastNode:(id)sender{
    Nodes* n = [coreData getNodeWithNumber:28];
    [n dlog];
    [coreData removeNodeByNumber:28];
    
    [fEMView display];
    
}


-(IBAction) addData:(id)sender{
    [self.progress startAnimation:Nil];
    [self cleanNodes:nil];
    int r = [[PlistConf valueForKey:@"rInNodes"] doubleValue];
    NSMutableArray* elems = [[NSMutableArray alloc] init];
    self.fEMView.mode = blank;
    
    double grUDown = [[PlistConf valueForKey:@"grUDown"] doubleValue];
    double grUUp = [[PlistConf valueForKey:@"grUUp"] doubleValue];
    
    int size = [[PlistConf valueForKey:@"numberOfNodes"] doubleValue];

    int size12 = size/2;
    
    for (int a = -size12; a <= size12; ++a) {
        NSMutableArray* line = [[NSMutableArray alloc] init];
        for (int b = -size12; b <= size12; ++b) {
            double dY = 0;
            NSUInteger status = 0;
            if (b == -size12) {
                status = 1;
                dY = grUDown;
            }
            if (b == size12) {
                status = 1;
                dY = grUUp;
            }
            Nodes* tmp = [coreData addNewNodeWithX:a*r 
                                                 Y:b*r 
                                                DX:0 
                                                DY:dY];
            tmp.status = [NSNumber numberWithUnsignedInteger:status];
            
            [line addObject:tmp];
        }
        [elems addObject:line];
    }
    
    NSUInteger line0Count2 = [elems count]/2;
    for (int a = 0; a < [elems count]-2; a+=2) {
        NSMutableArray* line0 = [elems objectAtIndex:a];
        NSMutableArray* line1 = [elems objectAtIndex:a+1];
        NSMutableArray* line2 = [elems objectAtIndex:a+2];
        for (int b = 0; b < [line0 count]-2; b+=2) {
            Nodes* n00 = (Nodes*)[line0 objectAtIndex:b];
            Nodes* n01 = (Nodes*)[line0 objectAtIndex:b+1];
            Nodes* n02 = (Nodes*)[line0 objectAtIndex:b+2];
            
            Nodes* n10 = (Nodes*)[line1 objectAtIndex:b];
            Nodes* n11 = (Nodes*)[line1 objectAtIndex:b+1];
            Nodes* n12 = (Nodes*)[line1 objectAtIndex:b+2];
            
            Nodes* n20 = (Nodes*)[line2 objectAtIndex:b];
            Nodes* n21 = (Nodes*)[line2 objectAtIndex:b+1];
            Nodes* n22 = (Nodes*)[line2 objectAtIndex:b+2];
            
            
//            n20--n21--n22
//             |\   |   /|
//             | \  |  / |
//             |  \ | /  |
//            n10--n11--n12
//             |  / | \  |     
//             | /  |  \ |     
//             |/   |   \|       
//            n00--n01--n02

            
//            [coreData makeElementFromNode1:n11 Node2:n00 Node3:n01];
//            [coreData makeElementFromNode1:n11 Node2:n10 Node3:n00];
//            [coreData makeElementFromNode1:n11 Node2:n20 Node3:n10];
//            [coreData makeElementFromNode1:n11 Node2:n21 Node3:n20];
//            [coreData makeElementFromNode1:n11 Node2:n22 Node3:n21];
//            [coreData makeElementFromNode1:n11 Node2:n12 Node3:n22];
//            [coreData makeElementFromNode1:n11 Node2:n02 Node3:n12];
//            [coreData makeElementFromNode1:n11 Node2:n01 Node3:n02];

            [coreData makeElementFromNode1:n20 Node2:n21 Node3:n11];
            [coreData makeElementFromNode1:n20 Node2:n11 Node3:n10];
            [coreData makeElementFromNode1:n10 Node2:n11 Node3:n00];
            [coreData makeElementFromNode1:n00 Node2:n11 Node3:n01];
            [coreData makeElementFromNode1:n21 Node2:n22 Node3:n11];
            [coreData makeElementFromNode1:n22 Node2:n12 Node3:n11];
            [coreData makeElementFromNode1:n11 Node2:n12 Node3:n02];
            [coreData makeElementFromNode1:n11 Node2:n02 Node3:n01];
            
            
            
//            [coreData makeElementFromNode1:n10 Node2:n00 Node3:n11];
//            [coreData makeElementFromNode1:n00 Node2:n10 Node3:n11];
//            [coreData makeElementFromNode1:n10 Node2:n11 Node3:n20];
//            [coreData makeElementFromNode1:n20 Node2:n11 Node3:n21];
//            [coreData makeElementFromNode1:n11 Node2:n01 Node3:n02];
//            [coreData makeElementFromNode1:n11 Node2:n02 Node3:n12];
//            [coreData makeElementFromNode1:n11 Node2:n12 Node3:n22];
//            [coreData makeElementFromNode1:n11 Node2:n22 Node3:n21];
            
            
        }
        
        
        
        
//        if (a >= line0Count2) {
//            for (int b = 0; b < [line0 count]-1; ++b) {
//                Nodes* n00 = (Nodes*)[line0 objectAtIndex:b];
//                Nodes* n01 = (Nodes*)[line0 objectAtIndex:b+1];
//                Nodes* n10 = (Nodes*)[line1 objectAtIndex:b];
//                Nodes* n11 = (Nodes*)[line1 objectAtIndex:b+1];
//                
//                [coreData makeElementFromNode1:n00 Node2:n10 Node3:n01];
//                [coreData makeElementFromNode1:n10 Node2:n11 Node3:n01];
//            }
//        } else {
//            for (int b = 0; b < [line0 count]-1; ++b) {
//                Nodes* n00 = (Nodes*)[line0 objectAtIndex:b];
//                Nodes* n01 = (Nodes*)[line0 objectAtIndex:b+1];
//                Nodes* n10 = (Nodes*)[line1 objectAtIndex:b];
//                Nodes* n11 = (Nodes*)[line1 objectAtIndex:b+1];
//                
//                [coreData makeElementFromNode1:n00 Node2:n10 Node3:n11];
//                [coreData makeElementFromNode1:n11 Node2:n01 Node3:n00];
//            }
//        }
    }
    
    [coreData saveCD];
    [fEMView display];
    [self.progress stopAnimation:Nil];
    
}

-(IBAction) addMash:(id)sender{
//    DLog(@"---------------");
//    Nodes* n = [[coreData allNodes] objectAtIndex:50];
//    NSMutableSet* sett = [[NSMutableSet alloc] init];
//    DLog(@"lok: %ld", [n.lok count]);
//    for (Elements* elm in n.lok){
//        [sett addObject:elm.n1.number];
//        [sett addObject:elm.n2.number];
//        [sett addObject:elm.n3.number];
//    }
//    
//    for (NSNumber* n in sett) {
//        DLog(@"%@",n);
//    }
//    DLog(@"count %ld", [sett count]);
//    
//    [coreData removeNodeByNumber:[n.number integerValue]];
//    
    
//    for (Nodes* n in [coreData allNodes]) {
//        NSUInteger nNumber = [n.number unsignedIntegerValue];
//        NSUInteger nLokCount = [n.lok count];
//        NSUInteger nStatus = [n.status unsignedIntegerValue];
//        {
//            NSString* stringTMP = [NSString stringWithFormat:@"%ld: lok %ld statius %ld\n", nNumber, nLokCount, nStatus];
//            DLog(@"%@",stringTMP);
//        }
//
//    }
    
    
    
    
    Solver* solver = [[Solver alloc] init];
    [self.progress startAnimation:Nil];
    [solver go];
    fEMView.mode = two;    
    [fEMView display];
    [self.progress stopAnimation:Nil];
    
}


@end
