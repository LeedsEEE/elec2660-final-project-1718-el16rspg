//
//  ohmsLawViewController.h
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 02/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//
//  This ohmsLawViewController contains the Ohm's Law Calculator

#import <UIKit/UIKit.h>
#import "ohmsLawDataModel.h"

@interface ohmsLawViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

// Data Model Object Created
@property (strong, nonatomic) ohmsLawDataModel *ohmsLawObject;

// Calculation Type Selector Picker
@property (strong, nonatomic) IBOutlet UIPickerView *ohmsLawCalcPicker;

// Labels that change depending on Calculation Type Selector Picker
@property (strong, nonatomic) IBOutlet UILabel *ohmsLawFormulaLabel;
@property (strong, nonatomic) IBOutlet UILabel *ohmsLawInput1Label;
@property (strong, nonatomic) IBOutlet UILabel *ohmsLawInput2Label;
@property (strong, nonatomic) IBOutlet UILabel *ohmsLawInput1UnitLabel;
@property (strong, nonatomic) IBOutlet UILabel *ohmsLawInput2UnitLabel;

// User Input Text Fields
@property (strong, nonatomic) IBOutlet UITextField *ohmsLawInput1TextField;
@property (strong, nonatomic) IBOutlet UITextField *ohmsLawInput2TextField;

// User Input Pickers
@property (strong, nonatomic) IBOutlet UIPickerView *ohmsLawInput1Multiplier;
@property (strong, nonatomic) IBOutlet UIPickerView *ohmsLawInput2Multiplier;

// Output Label
@property (strong, nonatomic) IBOutlet UILabel *ohmsLawOutputLabel;

// Array containing Muliplier Prefix (n to G)
@property NSArray *multiplierPrefix;

// Strings to store Calc Type and Units
@property (strong, nonatomic) NSString *ohmsLawOutputCalcType;
@property (strong, nonatomic) NSString *ohmsLawOutputUnit;

// Methods
- (IBAction)ohmsLawCalcButtonPressed:(UIButton *)sender;    // IBAction for Calculate Button
- (IBAction)hideKeyboardButton:(UIButton *)sender;          // IBAction to hide Decimal Keyboard
- (void) setOhmsLawOutputLabel;                             // Function to set Output Label
- (void) setOhmsLawInputLabel;                              // Function to set Input Label depending on ohmsLawCalcPicker value selected by user;
- (void) cautionR;                                          // Function to Display Alerts
- (void) setBackground;                                     // Function to set Background Image


@end
