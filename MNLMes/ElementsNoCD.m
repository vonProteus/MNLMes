//
//  ElementsNoCD.m
//  MNLMes
//
//  Created by Maciej Krok on 2011-12-27.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ElementsNoCD.h"

@implementation ElementsNoCD
@synthesize n1;
@synthesize n2;
@synthesize n3;

-(id) init{
    self = [super init];
    coreData = [CDModel sharedModel];
    return self;
}

-(double) clcFunkcionalWithA:(double)a 
                        andb:(double)b 
                        andE:(double)E 
                        andk:(double)k {
    double clcFunkcional = 0;
    
    double xi = [((Nodes*)self.n1).x doubleValue];
    double yi = [((Nodes*)self.n1).y doubleValue];
    double xj = [((Nodes*)self.n2).x doubleValue];
    double yj = [((Nodes*)self.n2).y doubleValue];
    double xk = [((Nodes*)self.n3).x doubleValue];
    double yk = [((Nodes*)self.n3).y doubleValue];
    
    double Uxi = [((Nodes*)self.n1).dx doubleValue];
    double Uyi = [((Nodes*)self.n1).dy doubleValue];
    double Uxj = [((Nodes*)self.n2).dx doubleValue];
    double Uyj = [((Nodes*)self.n2).dy doubleValue];
    double Uxk = [((Nodes*)self.n3).dx doubleValue];
    double Uyk = [((Nodes*)self.n3).dy doubleValue];
    
    
    
    double bi = yj - yk;
    double ci = xk - xj;
    double bj = yk - yi;
    double cj = xi - xk;
    double bk = yi - yj;
    double ck = xj - xi;
    
    double Ae = (xj * yk) + (xi * yj) + (yi * xk) - (yi * xj) - (yj * xk) - (xi * yk);
    
    double Ex = ((bi * Uxi) + (bj * Uxj) + (bk * Uxk)) / (2 * Ae); //epsilon x
    double Ey = ((ci * Uyi) + (cj * Uyj) + (ck * Uyk)) / (2 * Ae); //epsilon y
    double Exy = ((bi * Uyi) + (bj * Uyj) + (bk * Uyk) + (ci * Uxi) + (cj * Uxj) + (ck * Uxk)) / (4 * Ae); //epsilon xy
    
    double Ei = 0.47140452079103173  * ((Ex - Ey) * (Ex - Ey) + (Ex * Ex) + (Ey * Ey) + 6 * (Exy * Exy));
    double E0 = (Ex + Ey)/3;
    
    //    double a = [[PlistConf valueForKey:@"aFromSi=a*Ei^b"] doubleValue];
    //    double b = [[PlistConf valueForKey:@"bFromSi=a*Ei^b"] doubleValue];
    //    
    //    double E = [[PlistConf valueForKey:@"EFromClcFunkcional"] doubleValue];
    //    double k = [[PlistConf valueForKey:@"kFromClcFunkcional"] doubleValue];
    
    
    //    double Je = a*pow(Ei, (b + 1)) / (b + 1)*Ae + k*E0*E0*Ae;
    
//    double Si=a* pow(Ei,b);

    double Ei1 = 2;
    
    if (Ei >= Ei1) {
        double oZ_1 = 2;
        double alfa = 1;
        double oZ_ = oZ_1 + alfa*(Ei - Ei1);
        E = oZ_/Ei;
    }
    
    
    double Je = E*Ei*Ei*Ae + k*E0*E0*Ae;
    
    clcFunkcional = Je;
    
    return clcFunkcional;
}

@end
