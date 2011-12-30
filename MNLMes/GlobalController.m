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

            


            [coreData makeElementFromNode1:n20 Node2:n21 Node3:n11];
            [coreData makeElementFromNode1:n20 Node2:n11 Node3:n10];
            [coreData makeElementFromNode1:n10 Node2:n11 Node3:n00];
            [coreData makeElementFromNode1:n00 Node2:n11 Node3:n01];
            [coreData makeElementFromNode1:n21 Node2:n22 Node3:n11];
            [coreData makeElementFromNode1:n22 Node2:n12 Node3:n11];
            [coreData makeElementFromNode1:n11 Node2:n12 Node3:n02];
            [coreData makeElementFromNode1:n11 Node2:n02 Node3:n01];
            
            

            
            
        }
        
        
        
        
    }
    
    [coreData saveCD];
    [fEMView display];
    [self.progress stopAnimation:Nil];
    
}

-(IBAction) addMash:(id)sender{
    
    Solver* solver = [[Solver alloc] init];
    [self.progress startAnimation:Nil];
    [solver go];
    fEMView.mode = two;    
    [fEMView display];
    [self.progress stopAnimation:Nil];
    
}


@end
