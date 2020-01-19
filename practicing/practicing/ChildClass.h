//
//  ParentClass+ChildClass.h
//  practicing
//
//  Created by MacBook Pro  on 15.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//



#import "ParentClass.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    GenderMale,
    GenderFemale
} ChildGender;




@interface ChildClass: ParentClass
 
@property (assign, nonatomic) ChildGender gender;


@end

NS_ASSUME_NONNULL_END
