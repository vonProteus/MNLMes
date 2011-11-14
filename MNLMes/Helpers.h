//
//  Helpers.h
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-13.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helpers : NSObject

+ (NSPoint) locationInLCS:(NSPoint)p fromCenterIn:(NSPoint)center;
+ (NSPoint) locationInLCS:(NSPoint)p fromCenterOfRect:(NSRect)rect;

+ (NSPoint) locationInGCS:(NSPoint)p fromCenterIn:(NSPoint)center;
+ (NSPoint) locationInGCS:(NSPoint)p fromCenterOfRect:(NSRect)rect;

+ (NSURL*) applicationSupportNsurl;


@end
