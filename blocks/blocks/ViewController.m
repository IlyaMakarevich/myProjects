//
//  ViewController.m
//  blocks
//
//  Created by Ilya Makarevich on 1/30/20.
//  Copyright © 2020 apalon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];



    NSString* (^testBlock) (NSString*, NSInteger) = ^(NSString* name, NSInteger age) {
        return [NSString stringWithFormat:@"%@ %ld", name, (long)age];
    };

    NSString* result = testBlock(@"Ilya", 30);
    NSLog(@"%@", result);


    [self testBlocksMethod:^{
        NSLog(@"inside block");
    }];

    //объявляем блок
    void(^ccc)(void);
    ccc = ^{
        NSLog(@"ccc block");
    };
    //вызываем метод вместе с блоком
    [self testBlocksMethod:ccc];

}


//метод который принимает блок
-(void) testBlocksMethod:(void (^)(void)) callback{
    NSLog(@"start");


    callback();
}


@end
