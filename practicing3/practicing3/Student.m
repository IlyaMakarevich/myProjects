//
//  NSObject+Student.m
//  practicing3
//
//  Created by MacBook Pro  on 19.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "Student.h"



@implementation Student
-(void) study {
    
}

#pragma mark - Patient Methods -
-(BOOL) areYouOk{
    BOOL isOk = arc4random() % 2;
    NSLog(@"is student %@ ok? -  %@?", self.name, isOk? @"YES" : @"NO");
    return isOk;
}

-(void) takePill {
    NSLog(@"student %@ taking pill", self.name);
}

-(void) makeShot{
   NSLog(@"student %@ making shot", self.name);
}
@end
