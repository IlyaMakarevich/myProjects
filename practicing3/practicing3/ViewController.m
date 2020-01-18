//
//  ViewController.m
//  practicing3
//
//  Created by MacBook Pro  on 17.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "ViewController.h"
#import "MyTestClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testObject];
    
    NSLog(@"test is over");
    
    
}

-(void) testObject {
    MyTestClass* obj = [[MyTestClass alloc] init];
    self.object = obj;
}

@end
