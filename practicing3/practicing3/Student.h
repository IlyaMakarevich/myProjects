//
//  NSObject+Student.h
//  practicing3
//
//  Created by MacBook Pro  on 19.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//



#import <Foundation/Foundation.h>
#import "Patient.h"
NS_ASSUME_NONNULL_BEGIN

@interface Student: NSObject <Patient>


@property (strong, nonatomic) NSString* favouriteBook;
@property (strong, nonatomic) NSString* name;
-(void) study;


@end

NS_ASSUME_NONNULL_END
