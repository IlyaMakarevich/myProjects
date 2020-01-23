//
//  Patient.m
//  delegates
//
//  Created by MacBook Pro  on 21.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "Patient.h"

@implementation Patient

-(BOOL) howAreYou {
    BOOL iFeelGood = arc4random() % 2;
    
    if (!iFeelGood) {
        if ([self.delegate respondsToSelector:@selector(patientFeelsBad:)]) {
            [self.delegate patientFeelsBad:self];
        }
    }
    
    return iFeelGood;
}

-(void) takePill {
    NSLog(@"%@ takes a pill", self.name);
}

-(void) makeShot{
    NSLog(@"%@ make a shot", self.name);
}

@end
