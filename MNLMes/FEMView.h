//
//  FEMView.h
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-07.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CDModel.h"

typedef enum FEMViewMode {
    blank,
    dxdy
}FEMViewMode;


@interface FEMView : NSView {
    CDModel* coreData;
}

@property (assign) FEMViewMode mode;

- (void)makeCoordinateSistem;
- (void)drawNodes;
- (void)drawElemenys;
- (void)drawCircleX: (double)x
                  Y: (double)y 
                  R: (double)r
          WithColor:(NSColor*) rgba;

- (void)drawCirclePoint: (NSPoint)center
                      R: (double)r
              WithColor:(NSColor *)rgba;

- (void)drawElement:(Elements*)elem 
          WithColor:(NSColor*) rgba;;
@end
