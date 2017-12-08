//
//  colourCodeGenViewController.h
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 03/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//
//  This colourCodeGenViewController contains the NPV & Colour Code Calculator

#import <UIKit/UIKit.h>
#import "colourCodeGenDataModel.h"

@interface colourCodeGenViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

// Data Model Object Created
@property (strong, nonatomic) colourCodeGenDataModel *colourCodeGenObject;

// User Input Text Field
@property (strong, nonatomic) IBOutlet UITextField *inputRTextField;

// User Input Pickers
@property (strong, nonatomic) IBOutlet UIPickerView *multiplierPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *tolerancePicker;

// Output Label
@property (strong, nonatomic) IBOutlet UILabel *outputLabel;

// Array containing Muliplier Prefix (n to G)
@property NSArray *multiplierArray;

// Labels to display Band Colours & Colours in text
@property (strong, nonatomic) IBOutlet UILabel *Band1Label;
@property (strong, nonatomic) IBOutlet UILabel *Band2Label;
@property (strong, nonatomic) IBOutlet UILabel *Band3Label;
@property (strong, nonatomic) IBOutlet UILabel *Band4Label;
@property (strong, nonatomic) IBOutlet UILabel *bandTextLabel1;
@property (strong, nonatomic) IBOutlet UILabel *bandTextLabel2;
@property (strong, nonatomic) IBOutlet UILabel *bandTextLabel3;
@property (strong, nonatomic) IBOutlet UILabel *bandTextLabel4;
@property (strong, nonatomic) IBOutlet UILabel *firstSigFigLabel;
@property (strong, nonatomic) IBOutlet UILabel *secondSigFigLabel;
@property (strong, nonatomic) IBOutlet UILabel *multiplierLabel;
@property (strong, nonatomic) IBOutlet UILabel *toleranceLabel;


// Methods
- (IBAction)CalcButtonPressed:(UIButton *)sender;   // IBAction for Calculate Button
- (IBAction)hideKeyboardButton:(UIButton *)sender;  // IBAction to hide Decimal Keyboard
- (void) setColourCodeGenOutputLabel;               // Function to set Output Label
- (void) clearBands;                                // Funtion to Clear Band Colours and Text in case of Invalid User Input
- (void) setBackground;                             // Function to set Background Image


@end
