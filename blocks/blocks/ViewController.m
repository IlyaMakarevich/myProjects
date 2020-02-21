//
//  ViewController.m
//  blocks
//
//  Created by Ilya Makarevich on 1/30/20.
//  Copyright © 2020 apalon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {

}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];



    NSString* (^testBlock) (NSString*, NSInteger) = ^(NSString* name, NSInteger age) {
        return [NSString stringWithFormat:@"%@ %ld", name, (long)age];
    };

    NSString* result = testBlock(@"Ilya", 30);
    NSLog(@"%@", result);

//2. Вызываем метод который умеет принимать блок
    [self testBlocksMethod:^(NSString* a){
        NSLog(@"%@", a);
    }];

    //объявляем блок
    void(^ccc)(void);
    ccc = ^{
        NSLog(@"ccc block");
    };
    //вызываем метод вместе с блоком
    //[self testBlocksMethod:ccc()];

    [self beginTaskWithName:@"YO" completion:^{
        NSLog(@"the task is complete");
    }];
}


// 1. объявляем метод который принимает блок
-(void) testBlocksMethod:(void (^)(NSString*)) callback{
    NSLog(@"start");
    NSString* sroka = @"hi";
    callback(sroka);
}

- (void)beginTaskWithName:(NSString *)name completion:(void(^)(void))callback {
    NSLog(@"task started");
    callback();

}


@end
