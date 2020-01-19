//
//  Patient.h
//  practicing3
//
//  Created by MacBook Pro  on 19.01.2020.
//  Copyright © 2020 MacBook Pro . All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol Patient <NSObject>

@required
@property (strong, nonatomic) NSString* name;
-(BOOL) areYouOk;
-(void) takePill;
-(void) makeShot;

@optional
-(NSString*) howIsYourFamily;
-(NSString*) howIsYourJob;

@end

NS_ASSUME_NONNULL_END
