//
//  NSObject+Developer.m
//  practicing3
//
//  Created by MacBook Pro  on 19.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "Developer.h"



@implementation Developer

-(void) makeCode {
    
}

#pragma mark - Patient Methods -
-(BOOL) areYouOk{
    BOOL isOk = arc4random() % 2;
    NSLog(@"is developer %@ ok? -  %@?", self.name, isOk? @"YES" : @"NO");
    return isOk;
}

-(void) takePill {
    NSLog(@"Developer %@ taking pill", self.name);
}

-(void) makeShot{
   NSLog(@"Developer %@ making shot", self.name);
}

@end
