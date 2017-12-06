//
//  ViewController.m
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 02/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // Calls Function to set Background image
    (void) [self setBackground];
    
    // Checks Device Compatibility based on screen size and creates alert ensuring only users with compatible devices can proceed to use the app by forcing others to exit application;
    if([[UIScreen mainScreen] bounds].size.height == 667 || [[UIScreen mainScreen] bounds].size.height == 736) { nil; } else {
        UIAlertController* incompatibleDeviceAlert = [UIAlertController alertControllerWithTitle:@"Incompatible Device" message:@"This application is currently only compatible with iPhone 6, iPhone 6+, iPhone 6s, iPhone 6s+, iPhone 7, iPhone 7+, iPhone 8, and iPhone 8+. We apologise for any inconvenience caused." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* exitApp = [UIAlertAction actionWithTitle:@"Exit Application" style:UIAlertActionStyleCancel handler: ^(UIAlertAction * action) { exit(0); }];
        [incompatibleDeviceAlert addAction:exitApp];
        
        // Source: https://stackoverflow.com/questions/16283652/understanding-dispatch-async
        dispatch_async(dispatch_get_main_queue(), ^ { [self presentViewController: incompatibleDeviceAlert animated:YES completion:nil]; });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Functions

// Function to set Background image
// Source: https://stackoverflow.com/questions/38250333/ios-preparing-background-images-for-applications
- (void) setBackground {
    UIImage *bgImage = [UIImage imageNamed:@"blackboard 16_9_v2.png"];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIGraphicsBeginImageContextWithOptions(screenSize, NO, 0.f);
    [bgImage drawInRect:CGRectMake(0.f, 0.f, screenSize.width, screenSize.height)];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIColor *backgroundColor = [UIColor colorWithPatternImage:resultImage];
    self.view.backgroundColor = backgroundColor;
}


@end
