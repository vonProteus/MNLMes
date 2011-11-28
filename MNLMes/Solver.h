//
//  Solver.h
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDModel.h"

@interface Solver : NSObject{
    CDModel* coreData;
}

-(void) go;


@end
