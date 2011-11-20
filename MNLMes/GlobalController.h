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

@interface GlobalController : NSObject {
    CDModel* coreData;
}
@property (retain) IBOutlet FEMView *fEMView;

-(IBAction) cleanNodes:(id)sender;
-(IBAction) removeLastNode:(id)sender;
-(IBAction) addMash:(id)sender;
-(IBAction) addData:(id)sender;


@end
