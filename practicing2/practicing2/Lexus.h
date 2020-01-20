//
//  NSObject+Lexus.h
//  practicing2
//
//  Created by MacBook Pro  on 17.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//



#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Lexus: NSObject

@property (nonatomic, strong) NSString* model;
@property (nonatomic, assign) NSInteger power;
@property (nonatomic, assign) NSInteger year;

@end

NS_ASSUME_NONNULL_END
