//
//  ParentClass+ChildClass.m
//  practicing
//
//  Created by MacBook Pro  on 15.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "ChildClass.h"


@implementation ChildClass: ParentClass

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"Instance of Child class is Initialized");
        
    }
    return self;
}


-(NSString*) saySomeNumberString {
    return [NSString stringWithFormat:@"child say: %@", [NSDate date]];
}

-(NSString*) saySomething {
    return [super saySomeNumberString];
}

@end
