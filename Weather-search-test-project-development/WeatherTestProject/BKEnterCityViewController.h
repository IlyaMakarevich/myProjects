//
//  BKEnterCityViewController.h
//  WeatherTestProject
//
//  Created by Bogdan Kuprenkov on 23/09/2016.
//  Copyright © 2016 Bogdan Kuprenkov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BKWeatherData;

@protocol BKWeatherDataDelegate <NSObject>

- (void)viewController:(UIViewController *)controller didReceiveWeatherData:(BKWeatherData *)data;

@end

@interface BKEnterCityViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *cityNameTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (weak, nonatomic) id <BKWeatherDataDelegate> delegate;

- (IBAction)disableSaveButtonInCaseTextFieldHasNoText:(id)sender;
- (IBAction)loadWeatherDataWithUrlCreatedFromUserInput:(id)sender;
- (IBAction)goBackToWeatherTableView:(id)sender;

@end

