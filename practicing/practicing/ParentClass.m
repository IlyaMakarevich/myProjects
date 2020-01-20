//
//  NSObject+ParentClass.m
//  practicing
//
//  Created by MacBook Pro  on 15.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "ParentClass.h"

@implementation ParentClass: NSObject


- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"Instance of Parent class is initialied");
        
    }
    return self;
}

//так как статик, выведет имя класса
+(void) whoAreYou {
    NSLog(@"I AM ParentClass %@", self);
}

//выведет адрес в памяти, так как направлен как объекту класса
-(void) sayHello {
    NSLog(@"parent say: HELLO MOTHERFUCKER %@", self);
}

-(void) say:(NSString*) speech{
    NSLog(@"%@", speech);
}

-(void) say:(NSString*) speech and:(NSString*) speech2 {
    NSLog(@"%@, %@", speech, speech2);
}

-(void) say:(NSString*) speech and:(NSString*) speech2 andAfterThat:(NSString*) speech3 {
    NSLog(@"%@, %@, %@",speech, speech2, speech3);
}

//чтобы был приватный - не объявлять в хедере
-(NSString*) saySomeNumberString {
    return [NSString stringWithFormat:@"parent say: %@", [NSDate date]];
}

-(NSString*) saySomething {
    NSString* string = [self saySomeNumberString];
    return string;
}


@end
