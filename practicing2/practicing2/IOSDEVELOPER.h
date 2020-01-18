//
//  NSObject+IOSDEVELOPER.h
//  practicing2
//
//  Created by MacBook Pro  on 16.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//




#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IOSDEVELOPER: NSObject

@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) NSInteger age;
@property (assign, nonatomic) float weight;
@property (assign, nonatomic) int height;

//@property (assign, nonatomic) NSInteger count;

-(NSInteger) howOldAreYOu;

 
@end

NS_ASSUME_NONNULL_END
