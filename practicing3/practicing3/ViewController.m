//
//  ViewController.m
//  practicing3
//
//  Created by MacBook Pro  on 17.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "ViewController.h"
#import "MyTestClass.h"
#import "Patient.h"
#import "Developer.h"
#import "Dancer.h"
#import "Student.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testObject];
    
    NSLog(@"test is over");
    
    Dancer* dancer1 = [[Dancer alloc] init];
    Dancer* dancer2 = [[Dancer alloc] init];
    Student* student1 = [[Student alloc] init];
    Student* student2 = [[Student alloc] init];
    Student* student3 = [[Student alloc] init];
    Developer* developer1 = [[Developer alloc] init];
    NSArray* patients = [NSArray arrayWithObjects:dancer1, dancer2, student1, student2, student3, developer1, nil];
    
    
    for (id <Patient> patient in patients) {
        
        if([patient respondsToSelector:@selector(howIsYourJob)]) {
            [patient howIsYourJob];
        }
        
        if([patient respondsToSelector:@selector(howIsYourFamily)]) {
            [patient howIsYourFamily];
        }
        
        
        NSLog(@"Patient name = %@", patient.name);
        
        if(![patient areYouOk]) {
            [patient takePill];
            if (![patient areYouOk]) {
                [patient makeShot];
            }
        }
        
    }
    
    
    
}

-(void) testObject {
    MyTestClass* obj = [[MyTestClass alloc] init];
    self.object = obj;
}

@end
