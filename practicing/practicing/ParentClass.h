//
//  NSObject+ParentClass.h
//  practicing
//
//  Created by MacBook Pro  on 15.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface ParentClass: NSObject

+(void) whoAreYou;

-(void) sayHello;
-(void) say:(NSString*) speech;
-(void) say:(NSString*) speech and:(NSString*) speech2;
-(void) say:(NSString*) speech and:(NSString*) speech2 andAfterThat:(NSString*) speech3;
-(NSString*) saySomething;
-(NSString*) saySomeNumberString;


@end

NS_ASSUME_NONNULL_END
