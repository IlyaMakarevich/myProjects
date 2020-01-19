//
//  BKEnterCityViewController.h
//  WeatherTestProject
//
//  Created by Bogdan Kuprenkov on 23/09/2016.
//  Copyright © 2016 Bogdan Kuprenkov. All rights reserved.
//

#import "BKEnterCityViewController.h"
#import "BKWeatherListTableViewController.h"
#import "BKWeatherDataLoader.h"
#import "BKWeatherData.h"

@interface BKEnterCityViewController ()

@end

@implementation BKEnterCityViewController

#pragma mark - View methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.cityNameTextField becomeFirstResponder];
}

#pragma mark - MyMethods

- (void)popAlertWithMessage:(NSString *)errorMessage {
    // Create and show alert window for warning message when error appears
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController  *alert=   [UIAlertController
                                      alertControllerWithTitle:@"Warning"
                                      message:errorMessage
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction
                             actionWithTitle:@"Ok"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction  *action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    });
}

#pragma mark - ActionEvents

- (IBAction)disableSaveButtonInCaseTextFieldHasNoText:(id)sender {
    if ([self.cityNameTextField hasText]) {
        [self.saveButton setEnabled:YES];
    } else [self.saveButton setEnabled:NO];
}

- (IBAction)loadWeatherDataWithUrlCreatedFromUserInput:(id)sender {
    BKWeatherDataLoader *weatherDataLoader = [[BKWeatherDataLoader alloc] init];
    
    NSString *cityName = self.cityNameTextField.text;
    
    [weatherDataLoader loadWeatherDataWithCity:cityName completionHandler:^(BKWeatherData *weatherData, NSError *error) {
        if (error) {
            [self popAlertWithMessage:error.localizedDescription];
        } else {
            [self.delegate viewController:self didReceiveWeatherData:weatherData];
            
            [self.navigationController popViewControllerAnimated:YES];
            [self.view endEditing:YES];
        }
    }];
}

- (IBAction)goBackToWeatherTableView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.view endEditing:YES];
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
