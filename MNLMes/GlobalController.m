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
    for (Nodes* n in [coreData allNodes]){
        [coreData removeNodeByNumber:[n.number integerValue]];
    }
    
    [fEMView display];
}

-(IBAction)removeLastNode:(id)sender{
    Nodes* n = [coreData getNodeWithNumber:[coreData nextNumber]-1];
    [n dlog];
    [coreData removeNodeByNumber:[coreData nextNumber]-1];
    
    [fEMView display];
}


-(IBAction) addData:(id)sender{
    [self cleanNodes:nil];
    int r = 50;
    NSMutableArray* elems = [[NSMutableArray alloc] init];
    self.fEMView.mode = blank;
    
    double grUDown = [[PlistConf valueForKey:@"grUDown"] doubleValue];
    double grUUp = [[PlistConf valueForKey:@"grUUp"] doubleValue];
    
    int size = 6;
    int size12 = size/2;
    
    for (int a = -size12; a <= size12; ++a) {
        NSMutableArray* line = [[NSMutableArray alloc] init];
        for (int b = -size12; b <= size12; ++b) {
            double dY = 0;
            NSUInteger status = 0;
            if (b == -size12) {
                status = 1;
                dY = grUUp;
            }
            if (b == size12) {
                status = 1;
                dY = grUDown;
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
    for (int a = 0; a < [elems count]-1; ++a) {
        NSMutableArray* line0 = [elems objectAtIndex:a];
        NSMutableArray* line1 = [elems objectAtIndex:a+1];
        for (int b = 0; b < [line0 count]-1; ++b) {
            Nodes* n00 = (Nodes*)[line0 objectAtIndex:b];
            Nodes* n01 = (Nodes*)[line0 objectAtIndex:b+1];
            Nodes* n10 = (Nodes*)[line1 objectAtIndex:b];
            Nodes* n11 = (Nodes*)[line1 objectAtIndex:b+1];
            
            [coreData makeElementFromNode1:n00 Node2:n10 Node3:n01];
            [coreData makeElementFromNode1:n10 Node2:n11 Node3:n01];
        
        }
    }
    
    [coreData saveCD];
    [fEMView display];
    
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
    Solver* solver = [[Solver alloc] init];
    [self.progress startAnimation:Nil];
    [solver go];
    fEMView.mode = two;    
    [fEMView display];
    [self.progress stopAnimation:Nil];
    
}


@end
