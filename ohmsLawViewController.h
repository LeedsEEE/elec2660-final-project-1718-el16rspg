//
//  ohmsLawViewController.h
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 02/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ohmsLawDataModel.h"

@interface ohmsLawViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) ohmsLawDataModel *ohmsLawObject;

@property (strong, nonatomic) IBOutlet UILabel *ohmsLawFormulaLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *ohmsLawCalcPicker;

@property (strong, nonatomic) IBOutlet UILabel *ohmsLawInput1Label;
@property (strong, nonatomic) IBOutlet UILabel *ohmsLawInput2Label;
@property (strong, nonatomic) IBOutlet UITextField *ohmsLawInput1TextField;
@property (strong, nonatomic) IBOutlet UITextField *ohmsLawInput2TextField;
@property (strong, nonatomic) IBOutlet UIPickerView *ohmsLawInput1Multiplier;
@property (strong, nonatomic) IBOutlet UIPickerView *ohmsLawInput2Multiplier;
@property (strong, nonatomic) IBOutlet UILabel *ohmsLawInput1UnitLabel;
@property (strong, nonatomic) IBOutlet UILabel *ohmsLawInput2UnitLabel;

@property (strong, nonatomic) IBOutlet UILabel *ohmsLawOutputLabel;

@property NSArray *multiplierPrefix;
@property (strong, nonatomic) NSString *ohmsLawOutputCalcType;
@property (strong, nonatomic) NSString *ohmsLawOutputUnit;


- (IBAction)ohmsLawCalcButtonPressed:(UIButton *)sender;
- (IBAction)hideKeyboardButton:(UIButton *)sender;
- (void) setOhmsLawOutputLabel; // Function to set output label value after accounting for the unit multiplier
- (void) setOhmsLawInputLabel; // Function to set input label value depending on ohmsLawCalcPicker value selected by user;
- (void) cautionR; // Function to Display Alert if Resistance or Current is set to 0 when calculating Current or Resistance, respectively
- (void) setBackground; // Function to set Background Image


@end
