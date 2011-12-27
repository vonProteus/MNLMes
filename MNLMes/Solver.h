//
//  Solver.h
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDModel.h"
#import "NodesNoCD.h"
#import "ElementsNoCD.h"

@interface Solver : NSObject{
    CDModel* coreData;
    NSProgressIndicator* progress;
    NSMutableArray* allNodesNoCD;
    NSMutableArray* allElementsNoCD;
}

-(void) go;
-(void) addProgressIndicator:(NSProgressIndicator*)pr;

-(NodesNoCD*) findNodeNoCDWithNumber:(NSUInteger)number;
-(void) noCD2CD;


@end
