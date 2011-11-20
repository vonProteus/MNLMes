//
//  FEMView.m
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-07.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FEMView.h"

@implementation FEMView

@synthesize mode;

-(id) init{
    self = [super init];
    
    DLog(@"init");
    coreData = [CDModel sharedModel];    
    return self;
}


- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        DLog(@"ok");
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    coreData = [CDModel sharedModel];    
    // Drawing code here.
    [self makeCoordinateSistem];
    [self drawNodes];
    [self drawElemenys];

}

- (void)makeCoordinateSistem{
    NSBezierPath* path = [NSBezierPath bezierPath];
    NSPoint size;
    size.x = self.bounds.size.width;
    size.y = self.bounds.size.height;

    //x
    [path moveToPoint:NSMakePoint(0.0, size.y/2)];   
    [path lineToPoint:NSMakePoint(size.x, size.y/2)];
    
    //y
    [path moveToPoint:NSMakePoint(size.x/2, 0.0)];   
    [path lineToPoint:NSMakePoint(size.x/2, size.y)];
    
    [path stroke];
}

- (void)drawNodes{
    NSColor* rgba;
    
    switch (self.mode) {
        case blank:
            rgba = [NSColor blackColor];
            break;
        case dxdy:
            rgba = [NSColor blueColor];
            break;
            
        default:
            rgba = [NSColor blackColor];
            break;
    }

//    DLog(@"start");
    for (Nodes* n in [coreData allNodes]) {
//        [n dlog];
        [self drawCirclePoint:[Helpers locationInGCS:[n pointValue] 
                                    fromCenterOfRect:self.bounds]
                            R:3 
                    WithColor:rgba];
        
    }
    
}

- (void)drawCircleX: (double)x 
                  Y: (double)y 
                  R: (double)r
          WithColor:(NSColor *)rgba{
//    DLog(@"ok");
    NSRect rect = NSMakeRect(x-r, y-r, 2*r, 2*r);
    NSBezierPath* path = [NSBezierPath bezierPath];
    [path appendBezierPathWithOvalInRect:rect];
    
    [rgba set];

    [path stroke];

}

- (void)drawCirclePoint: (NSPoint)center
                      R: (double)r
              WithColor:(NSColor *)rgba{
    [self drawCircleX:center.x Y:center.y R:r WithColor:rgba];
}

- (void) mouseDown:(NSEvent*)someEvent {
//    DLog(@"It worked!");
    NSPoint location = [self.window convertScreenToBase:[NSEvent mouseLocation]];
//    DLog(@"%f %f", location.x,location.y);
    location = [Helpers locationInLCS:location fromCenterOfRect:self.bounds];
//    DLog(@"%f %f", location.x,location.y);
    [coreData addNewNodeWithX:location.x Y:location.y DX:0 DY:0];
//    location = [Helpers locationInGCS:location fromCenterOfRect:fEMView.bounds];
//    DLog(@"%f %f", location.x,location.y);
    [coreData saveCD];
    //    [self drawCirclePoint:[Helpers locationInGCS:location 
    //                                fromCenterOfRect:self.bounds] 
    //                        R:10];
    //    [self needsDisplay];
    [self display];
}

-(void) drawElemenys{
    NSColor* rgba;
    
    switch (self.mode) {
        case blank:
            rgba = [NSColor greenColor];
            break;
        case dxdy:
            rgba = [NSColor redColor];
            break;
            
        default:
            rgba = [NSColor blackColor];
            break;
    }
    
    
    for (Elements* e in [coreData allElements]) {
        [self drawElement:e WithColor:rgba];
    }
    
}

-(void) drawElement:(Elements *)elem WithColor:(NSColor *)rgba{
    NSBezierPath* path = [NSBezierPath bezierPath];
    [rgba set];
    NSPoint p1,p2,p3;
    switch (self.mode) {
        case blank:
            p1 = [elem.n1 pointValue];
            p2 = [elem.n2 pointValue];
            p3 = [elem.n3 pointValue];
            break;
        case dxdy:
            p1 = [elem.n1 pointValueDxDy];
            p2 = [elem.n2 pointValueDxDy];
            p3 = [elem.n3 pointValueDxDy];
            break;
            
        default:
            p1 = [elem.n1 pointValue];
            p2 = [elem.n2 pointValue];
            p3 = [elem.n3 pointValue];
            break;
    }
    
    
    [path moveToPoint:[Helpers locationInGCS:p1  
                            fromCenterOfRect:self.bounds]];  
    
    //1-2
    [path lineToPoint:[Helpers locationInGCS:p2  
                            fromCenterOfRect:self.bounds]];

    //2-3
    [path lineToPoint:[Helpers locationInGCS:p3  
                            fromCenterOfRect:self.bounds]];

    //3-1
    [path lineToPoint:[Helpers locationInGCS:p1  
                            fromCenterOfRect:self.bounds]];

    
    
    [path stroke];

}


@end
