//
//  AppDelegate.h
//  MyWeatherApp
//
//  Created by MacBook Pro  on 18.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

