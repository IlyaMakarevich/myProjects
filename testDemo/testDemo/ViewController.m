//
//  ViewController.m
//  testDemo
//
//  Created by Ilya Makarevich on 2/11/20.
//  Copyright © 2020 apalon. All rights reserved.
//

#import "ViewController.h"

typedef void(^EmptyBlock)(NSString* str);
typedef void (^CompletionBlock)(void);


@interface ViewController ()

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];

//1.
   EmptyBlock emptyBlock;
   emptyBlock = ^(NSString* stroka) {
        NSLog(@"hoooorrrayy %@", stroka);
    };

    emptyBlock(@"dddd");

//2.
    [self methodWithBlock:^{
        NSLog(@"second");
    }];

//3.
    [self methodWithBlock2:^(BOOL smth) {
        if (smth) {
            NSLog(@"cucumber");
        } else
        {
            NSLog(@"meat");
        }
    }];

    [self methodWithBlockReturnString:^(NSString * surname) {
        surname = @"Makarevich";
    }];

    //4.
      [self performActionWithCompletion:^{
        //method body execution first NSLog(@"Action Performed");
       NSLog(@"Completion is called to intimate action is performed.");
    }];
}



- (void)methodWithBlock:(void (^)(void))textBlock {
    NSLog(@"first");
    textBlock();
    NSLog(@"third");
}

- (void)methodWithBlock2:(void (^)(BOOL))block {
    NSLog(@"Can I have the");
    block(NO);
    NSLog(@"burger");
}

- (NSString*)methodWithBlockReturnString:(void(^)(NSString*)) block {
    NSString* name = @"Ilya";
    block(@"makarevich");
    return name;
}

- (void)performActionWithCompletion:(CompletionBlock)completionBlock {
   NSLog(@"Action Performed");
   completionBlock();
}



@end
