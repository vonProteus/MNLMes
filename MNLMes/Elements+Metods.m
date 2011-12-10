//
//  Elements+Metods.m
//  MNLMes
//
//  Created by Maciej Krok on 2011-11-28.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Elements+Metods.h"
#import "Nodes+Metods.h"
#import "PlistConf.h"

@implementation Elements (Metods)


-(double) clcFunkcional {
    double clcFunkcional = 0;
    
    double x1 = [((Nodes*)self.n1).x doubleValue];
    double y1 = [((Nodes*)self.n1).y doubleValue];
    double x2 = [((Nodes*)self.n2).x doubleValue];
    double y2 = [((Nodes*)self.n2).y doubleValue];
    double x3 = [((Nodes*)self.n3).x doubleValue];
    double y3 = [((Nodes*)self.n3).y doubleValue];
    
    double Ux1 = [((Nodes*)self.n1).dx doubleValue];
    double Uy1 = [((Nodes*)self.n1).dy doubleValue];
    double Ux2 = [((Nodes*)self.n2).dx doubleValue];
    double Uy2 = [((Nodes*)self.n2).dy doubleValue];
    double Ux3 = [((Nodes*)self.n3).dx doubleValue];
    double Uy3 = [((Nodes*)self.n3).dy doubleValue];
    
    
    
    double bi = y2 - y3;
    double ci = x3 - x2;
    double bj = y3 - y1;
    double cj = x1 - x3;
    double bk = y1 - y2;
    double ck = x2 - x1;
    
    double Ae = x2*y3 + x1*y2 + y1*x3 - y1*x2 - y2*x3 - x1*y3;
    
    double Ex = (bi*Ux1 + bj*Ux2 + bk*Ux3)/(2.0*Ae);
    double Ey = (ci*Uy1 + cj*Uy2 + ck*Uy3)/(2.0*Ae);
    double Exy = (bi*Uy1 + bj*Uy2 + bk*Uy3 + ci*Ux1 + cj*Ux2 + ck*Ux3)/(4.0*Ae);
    
    double Ei = (sqrt(2)/3)*((Ex - Ey)*(Ex - Ey) + Ex*Ex + Ey*Ey + 6*Exy*Exy);
    double E0 = (Ex + Ey)/3;
    
    double a = [[PlistConf valueForKey:@"aFromSi=a*Ei^b"] doubleValue];
    double b = [[PlistConf valueForKey:@"bFromSi=a*Ei^b"] doubleValue];
    
    double E = [[PlistConf valueForKey:@"EFromClcFunkcional"] doubleValue];
    double k = [[PlistConf valueForKey:@"kFromClcFunkcional"] doubleValue];
    
    
    double Je = a*pow(Ei, (b + 1)) / (b + 1)*Ae + k*E0*E0*Ae;
//    double Je = E*Ei*Ei*Ae + k*E0*E0*Ae;

    clcFunkcional = Je;
    
    return clcFunkcional;
}


@end
