//
//  ViewController.m
//  delegates
//
//  Created by MacBook Pro  on 21.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "ViewController.h"
#import "Patient.h"
#import "Doctor.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Patient* patient1 = [[Patient alloc] init];
    patient1.name = @"Baron";
    patient1.temperature = 36.6;
    
    Patient* patient2 = [[Patient alloc] init];
    patient2.name = @"Petya";
    patient2.temperature = 40.2;
    
    Patient* patient3 = [[Patient alloc] init];
       patient3.name = @"Vanya";
       patient3.temperature = 40.9;
       
    
    Patient* patient4 = [[Patient alloc] init];
       patient4.name = @"Petya";
       patient4.temperature = 36.2;
       
    
    Doctor* doctor = [[Doctor alloc] init];
    
    patient1.delegate = doctor;
    patient2.delegate = doctor;
    patient3.delegate = doctor;
    patient4.delegate = doctor;

    
    NSLog(@"%@ are you ok? %@", patient1.name, [patient1 howAreYou] ? @"YES" : @"NO");
    NSLog(@"%@ are you ok? %@", patient2.name, [patient2  howAreYou] ? @"YES" : @"NO");
    NSLog(@"%@ are you ok? %@", patient3.name, [patient3  howAreYou] ? @"YES" : @"NO");
    NSLog(@"%@ are you ok? %@", patient4.name, [patient4  howAreYou] ? @"YES" : @"NO");


    [patient1 howAreYou];
    [patient2 howAreYou];
    
    
    
    
}


@end
