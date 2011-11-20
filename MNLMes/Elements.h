//
//  Elements.h
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-20.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Nodes;

@interface Elements : NSManagedObject

@property (nonatomic, retain) Nodes *n1;
@property (nonatomic, retain) Nodes *n2;
@property (nonatomic, retain) Nodes *n3;

@end
