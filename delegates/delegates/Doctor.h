//
//  Doctor.h
//  delegates
//
//  Created by MacBook Pro  on 21.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

@protocol PatientDelegate;


@interface Doctor : NSObject <PatientDelegate>

@end

