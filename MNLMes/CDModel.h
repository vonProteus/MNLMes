//
//  CDModel.h
//  Fiszki
//
//  Created by Maciej Krok on 11-07-07.
//  Copyright 2011 Freelance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Nodes+Metods.h"
#import "Elements+Metods.h"


@interface CDModel : NSObject {
    
}

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (retain) NSMutableArray *wordsInCategories;

- (NSManagedObjectContext*)managedObjectContext;
- (NSURL*)applicationDocumentsDirectory;
- (void)saveContext;
+ (id)sharedModel;
- (void) saveCD;

- (NSInteger) nextNumber;
- (Nodes*) addNewNodeWithX:(double)x Y:(double)y DX:(double)dx DY:(double)dy;
- (Nodes*) getNodeWithNumber:(NSInteger)number;

- (NSArray*) allNodes;
- (NSArray*) allElements;

- (void) removeNodeByNumber:(NSInteger)number;
- (void) removeElementWithNodeWithNumber:(NSInteger)number;


- (Elements*) makeElementFromNode1:(Nodes*)nn1 Node2:(Nodes*)nn2 Node3:(Nodes*)nn3;



@end
