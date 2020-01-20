//
//  NSObject+IOSDEVELOPER.m
//  practicing2
//
//  Created by MacBook Pro  on 16.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "IOSDEVELOPER.h"

@interface IOSDEVELOPER ()
@property (assign, nonatomic) NSInteger count;
@end


@implementation IOSDEVELOPER: NSObject
@synthesize name = _name;

- (id)init
{
    self = [super init];
    if (self) {
        self.count = 0;
        self.name = @"Default";
        self.age = 1;
        self.weight = 1;
        self.height = 1;
    }
    return self;
}

-(void) setName:(NSString *) inputName {
    NSLog(@"setter setName: is called");

    //private access
    _name = inputName;
}

-(void) setWeight:(float)weight {
    NSLog(@"setter setWeight: is called");
    //_weight = 35;
    _weight = weight;
}

//переопределяем геттер
- (NSString*) name {
    self.count +=1;
    NSLog(@"name getter is called %ld times", (long)self.count);
    return _name;
}

-(NSInteger) age {
    NSLog(@"age getter is called");
    return _age;
}

-(NSInteger) howOldAreYOu {
    return self.age;
}

@end
