//
//  ElementsNoCD.m
//  MNLMes
//
//  Created by Maciej Krok on 2011-12-27.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ElementsNoCD.h"

@implementation ElementsNoCD
@dynamic n1;
@dynamic n2;
@dynamic n3;

-(id) init{
    coreData = [CDModel sharedModel];
    return self;
}


@end
