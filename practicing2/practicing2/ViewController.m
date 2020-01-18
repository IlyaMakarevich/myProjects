//
//  ViewController.m
//  practicing2
//
//  Created by MacBook Pro  on 16.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "ViewController.h"
#import "IMObject.h"
#import "IMChild.h"
#import "IOSDEVELOPER.h"
#import "Lexus.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    IOSDEVELOPER* developer = [[IOSDEVELOPER alloc] init];
    Lexus* myLexus = [[Lexus alloc] init];
    
    [developer setName:@"Ilya"];
    [developer setAge:30];
    developer.weight = 78.0;
    
    myLexus.model = @"123";
    myLexus.power = 123;
    myLexus.year = 123;
    
//    NSLog(@"name = %@", developer.name);
//    NSLog(@"age = %ld", [developer age]);
//    NSLog(@"weight = %f", developer.weight);
//
    NSLog(@"age = %ld",[developer howOldAreYOu]);
    NSLog(@"name = %@", developer.name);
    NSLog(@"name = %@", [developer name]);
    
    NSLog(@"model = %@", myLexus.model);
    NSLog(@"power = %ld", (long)myLexus.power);
    NSLog(@"year = %ld", (long)myLexus.year);
    

    NSArray* developers = [[NSArray alloc] initWithObjects:@"Kolya", @"Petya",@"Vasya",@"Dima", nil];
    
    NSArray* designers = @[@"Katya", @"Vera"];
    
    for (NSString* dev in developers) {
        NSLog(@"%@", dev);
    }

    IMObject* obj1 = [[IMObject alloc] init];
    IMObject* obj2 = [[IMObject alloc] init];
    IMChild* obj3 = [[IMChild alloc] init];
    obj1.name = @"object_1";
    obj2.name = @"object_2";
    [obj3 setName:@"object_3"];
    obj3.lastName = @"Last Name";
    
    NSArray* array = [NSArray arrayWithObjects:obj1,obj2,obj3,nil];
    for (IMObject* obj in array) {
        NSLog(@"====%@=====",obj.name);
        [obj action];
        
        if ([obj isKindOfClass:[IMChild class]]) {
            IMChild* child = (IMChild*)obj;
            NSLog(@"last name = %@", child.lastName);  
        }
    }
    

    
}


@end
