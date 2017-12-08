//
//  seriesRViewController.h
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 02/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//
//  This seriesRViewController contains the Series Resistance Calculator

#import <UIKit/UIKit.h>
#import "seriesRDataModel.h"

@interface seriesRViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

// Data Model Object Created
@property (strong, nonatomic) seriesRDataModel *seriesRObject;

// User Input Text Fields
@property (strong, nonatomic) IBOutlet UITextField *seriesR1InputTextField;
@property (strong, nonatomic) IBOutlet UITextField *seriesR2InputTextField;
@property (strong, nonatomic) IBOutlet UITextField *seriesR3InputTextField;

// User Input Pickers
@property (strong, nonatomic) IBOutlet UIPickerView *seriesR1InputMultiplier;
@property (strong, nonatomic) IBOutlet UIPickerView *seriesR2InputMultiplier;
@property (strong, nonatomic) IBOutlet UIPickerView *seriesR3InputMultiplier;

// Output Label
@property (strong, nonatomic) IBOutlet UILabel *seriesROutputLabel;


// Methods
- (IBAction)seriesRCalcButtonPressed:(UIButton *)sender;    // IBAction for Calculate Button
- (IBAction)hideKeyboardButton:(UIButton *)sender;          // IBAction to hide Decimal Keyboard
- (void)setSeriesROutputLabel;                              // Function to set Output Label
- (void) setBackground;                                     // Function to set Background Image

@end
