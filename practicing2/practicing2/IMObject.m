//
//  NSObject+IMObject.m
//  practicing2
//
//  Created by MacBook Pro  on 18.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "IMObject.h"

@interface IMObject()
@property (strong, nonatomic) NSString* nameHidden;
@end


@implementation IMObject : NSObject

-(void) action {
    NSLog(@"ACTION!!!! - %@", self.name);
    
}

@end
