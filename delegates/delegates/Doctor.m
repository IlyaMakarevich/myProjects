//
//  Doctor.m
//  delegates
//
//  Created by MacBook Pro  on 21.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "Doctor.h"
#import "Patient.h"

@implementation Doctor


# pragma mark  - PatienDelegate

-(void) patientFeelsBad:(Patient*) patient {
    NSLog(@"Patient %@ feels bad", patient.name);
    
    if (patient.temperature >= 37.f && patient.temperature <= 39.f) {
        [patient takePill];
    }
     else if (patient.temperature > 39.f) {
        [patient makeShot];
     } else {
         NSLog(@"patient %@ should rest" , patient.name);
     }
}

-(void) patient:(Patient*) patient hasQuestion:(NSString*) question {
    NSLog(@"Patient %@ has question: %@", patient.name, question);

}

@end
