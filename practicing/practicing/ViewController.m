//
//  ViewController.m
//  practicing
//
//  Created by MacBook Pro  on 15.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "ViewController.h"
#import "ParentClass.h"
#import "ChildClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ChildClass* parent = [[ChildClass alloc] init];
    [parent sayHello];
    [parent say:@"just a one sentence"];
    [parent say:@"how are you?" and: @"yo"];
    [parent say:@"1" and:@"2" andAfterThat:@"3"];
    NSLog(@"%@", [parent saySomething]); 
    [ChildClass whoAreYou];
}


@end
