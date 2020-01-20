//
//  NSObject+MyTestClass.m
//  practicing3
//
//  Created by MacBook Pro  on 17.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "MyTestClass.h"




@implementation MyTestClass: NSObject


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"object is created");
    }
    return self;
}
-(void) dealloc {
    NSLog(@"object is deallocated");
}

@end
