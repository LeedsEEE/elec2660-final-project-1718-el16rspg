//
//  parallelRViewController.h
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 02/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//
//  This parallelRViewController contains the Parallel Resistance Calculator

#import <UIKit/UIKit.h>
#import "parallelRDataModel.h"

@interface parallelRViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

// Data Model Object Created
@property (strong, nonatomic) parallelRDataModel *parallelRObject;

// User Input Text Fields
@property (strong, nonatomic) IBOutlet UITextField *parallelR1InputTextField;
@property (strong, nonatomic) IBOutlet UITextField *parallelR2InputTextField;
@property (strong, nonatomic) IBOutlet UITextField *parallelR3InputTextField;

// User Input Pickers
@property (strong, nonatomic) IBOutlet UIPickerView *parallelR1InputMultiplier;
@property (strong, nonatomic) IBOutlet UIPickerView *parallelR2InputMultiplier;
@property (strong, nonatomic) IBOutlet UIPickerView *parallelR3InputMultiplier;

// Output Label
@property (strong, nonatomic) IBOutlet UILabel *parallelROutputLabel;

// Methods
- (IBAction)parallelRCalcButtonPressed:(UIButton *)sender;  // IBAction for Calculate Button
- (IBAction)hideKeyboardButton:(UIButton *)sender;          // IBAction to hide Decimal Keyboard
- (void)setParallelROutputLabel;                            // Function to set Output Label
- (void) cautionR;                                          // Function to Display Alerts
- (void) setBackground;                                     // Function to set Background Image



@end
