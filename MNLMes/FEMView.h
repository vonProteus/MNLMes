//
//  FEMView.h
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-07.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CDModel.h"


@interface FEMView : NSView {
    CDModel* coreData;
}

- (void)makeCoordinateSistem;
- (void)drawNodes;
- (void)drawElemenys;
- (void)drawCircleX: (double)x
                  Y: (double)y 
                  R: (double)r;

- (void)drawCirclePoint: (NSPoint)center
                      R: (double)r;

- (void)drawElement:(Elements*)elem;
@end
