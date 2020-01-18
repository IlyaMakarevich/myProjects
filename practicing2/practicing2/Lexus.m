//
//  NSObject+Lexus.m
//  practicing2
//
//  Created by MacBook Pro  on 17.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import "Lexus.h"

@interface Lexus()
@property (nonatomic, assign) NSInteger nameCount;

@end

@implementation Lexus

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.model = @"RX400h";
        self.power = 280;
        self.year = 2006;
    }
    return self;
}

-(void) setModel:(NSString *)model {
    _model = @"RX450h";
}

-(NSInteger) year {
    return 2019;
}

- (NSInteger)nameCount {
    return 1989;
}


@end
