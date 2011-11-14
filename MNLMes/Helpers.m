//
//  Helpers.m
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-13.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Helpers.h"

@implementation Helpers


+(NSPoint) locationInLCS:(NSPoint)p 
            fromCenterIn:(NSPoint)center{
    return NSMakePoint(p.x-center.x, p.y-center.y);
}

+(NSPoint) locationInLCS:(NSPoint)p fromCenterOfRect:(NSRect)rect{
    NSPoint size;
    size.x = rect.size.width/2;
    size.y = rect.size.height/2;
    
    return [Helpers locationInLCS:p fromCenterIn:size];
}


+(NSPoint) locationInGCS:(NSPoint)p 
            fromCenterIn:(NSPoint)center{
    return NSMakePoint(p.x+center.x, p.y+center.y);
}

+(NSPoint) locationInGCS:(NSPoint)p fromCenterOfRect:(NSRect)rect{
    NSPoint size;
    size.x = rect.size.width/2;
    size.y = rect.size.height/2;
    
    return [Helpers locationInGCS:p fromCenterIn:size];
}

+(NSURL*) applicationSupportNsurl{
    NSURL *libraryPath = [[[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory
                                                                 inDomains:NSUserDomainMask] lastObject];
    
    libraryPath = [libraryPath URLByAppendingPathComponent:@"MNLMes" isDirectory:YES];
    
    return libraryPath;
    
}
@end
