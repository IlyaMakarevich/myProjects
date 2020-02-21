//
//  ViewController.m
//  testDemo
//
//  Created by Ilya Makarevich on 2/11/20.
//  Copyright © 2020 apalon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    KNVersionIntegerFromVersionStr(@"9.4.2");
}

long KNVersionIntegerFromVersionStr (NSString * versionStr)
{
    if (!versionStr || [versionStr length]==0)
        return 0;
    versionStr = [[NSString alloc] initWithFormat:@"%@.0.0", versionStr];
    const char *verUTF8 = [versionStr UTF8String];
    int ver1,ver2,ver3;
    sscanf(verUTF8, "%d.%d.%d", &ver1, &ver2, &ver3);
    long versionInt = ver1*10000 + ver2*100 + ver3;
    NSLog(@"%ld", versionInt);
    return versionInt;
}


@end
