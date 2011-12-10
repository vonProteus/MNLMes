//
//  GlobalController.h
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-13.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDModel.h"
#import "FEMView.h"
#import "Solver.h"
#import "PlistConf.h"

@interface GlobalController : NSObject {
    CDModel* coreData;
}
@property (retain) IBOutlet FEMView *fEMView;
@property (retain) IBOutlet NSProgressIndicator *progress;

-(IBAction) cleanNodes:(id)sender;
-(IBAction) removeLastNode:(id)sender;
-(IBAction) addMash:(id)sender;
-(IBAction) addData:(id)sender;


@end



//NSUInteger line0Count2 = [elems count]/2;
//for (int a = 0; a < [elems count]-1; ++a) {
//    NSMutableArray* line0 = [elems objectAtIndex:a];
//    NSMutableArray* line1 = [elems objectAtIndex:a+1];
//    
//    if (a >= line0Count2) {
//        for (int b = 0; b < [line0 count]-1; ++b) {
//            Nodes* n00 = (Nodes*)[line0 objectAtIndex:b];
//            Nodes* n01 = (Nodes*)[line0 objectAtIndex:b+1];
//            Nodes* n10 = (Nodes*)[line1 objectAtIndex:b];
//            Nodes* n11 = (Nodes*)[line1 objectAtIndex:b+1];
//            
//            //                [coreData makeElementFromNode1:n00 Node2:n10 Node3:n01];
//            //                [coreData makeElementFromNode1:n10 Node2:n11 Node3:n01];
//        }
//    } else {
//        for (int b = 0; b < [line0 count]-1; ++b) {
//            Nodes* n00 = (Nodes*)[line0 objectAtIndex:b];
//            Nodes* n01 = (Nodes*)[line0 objectAtIndex:b+1];
//            Nodes* n10 = (Nodes*)[line1 objectAtIndex:b];
//            Nodes* n11 = (Nodes*)[line1 objectAtIndex:b+1];
//            
//            [coreData makeElementFromNode1:n10 Node2:n00 Node3:n11];
//            [coreData makeElementFromNode1:n00 Node2:n01 Node3:n11];
//        }
//        
//    }
//}
