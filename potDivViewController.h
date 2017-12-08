//
//  potDivViewController.h
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 02/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//
//  This potDivViewController contains the Potential Divider Calculator

#import <UIKit/UIKit.h>
#import "potDivDataModel.h"

@interface potDivViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

// Data Model Object Created
@property (strong, nonatomic) potDivDataModel *potDivObject;

// Calculation Type Selector Picker
@property (strong, nonatomic) IBOutlet UIPickerView *potDivCalcPicker;

// Labels that change depending on Calculation Type Selector Picker
@property (strong, nonatomic) IBOutlet UILabel *potDivFormulaLabel;
@property (strong, nonatomic) IBOutlet UILabel *potDivInput1Label;
@property (strong, nonatomic) IBOutlet UILabel *potDivInput2Label;
@property (strong, nonatomic) IBOutlet UILabel *potDivInput3Label;
@property (strong, nonatomic) IBOutlet UILabel *potDivInput1UnitLabel;
@property (strong, nonatomic) IBOutlet UILabel *potDivInput2UnitLabel;
@property (strong, nonatomic) IBOutlet UILabel *potDivInput3UnitLabel;

// User Input Text Fields
@property (strong, nonatomic) IBOutlet UITextField *potDivInput1TextField;
@property (strong, nonatomic) IBOutlet UITextField *potDivInput2TextField;
@property (strong, nonatomic) IBOutlet UITextField *potDivInput3TextField;

// User Input Pickers
@property (strong, nonatomic) IBOutlet UIPickerView *potDivInput1Multiplier;
@property (strong, nonatomic) IBOutlet UIPickerView *potDivInput2Multiplier;
@property (strong, nonatomic) IBOutlet UIPickerView *potDivInput3Multiplier;

// Output Label
@property (strong, nonatomic) IBOutlet UILabel *potDivOutputLabel;

// Array containing Muliplier Prefix (n to G)
@property NSArray *multiplierPrefix;

// Strings to store Calc Type and Units
@property (strong, nonatomic) NSString *potDivOutputCalcType;
@property (strong, nonatomic) NSString *potDivOutputUnit;


- (IBAction)potDivCalcButtonPressed:(UIButton *)sender;     // IBAction for Calculate Button
- (IBAction)hideKeyboardButton:(UIButton *)sender;          // IBAction to hide Decimal Keyboard
- (void) setpotDivInputLabel;                               // Function to set Input Label depending on ohmsLawCalcPicker value
- (void) setpotDivOutputLabel;                              // Function to set Output Label depending on ohmsLawCalcPicker value
- (void) cautionR;                                          // Function to Display Alerts
- (void) setBackground;                                     // Function to set Background Image


@end
