//
//  potDivViewController.h
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 02/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "potDivDataModel.h"

@interface potDivViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) potDivDataModel *potDivObject;

@property (strong, nonatomic) IBOutlet UILabel *potDivFormulaLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *potDivCalcPicker;

@property (strong, nonatomic) IBOutlet UILabel *potDivInput1Label;
@property (strong, nonatomic) IBOutlet UILabel *potDivInput2Label;
@property (strong, nonatomic) IBOutlet UILabel *potDivInput3Label;
@property (strong, nonatomic) IBOutlet UITextField *potDivInput1TextField;
@property (strong, nonatomic) IBOutlet UITextField *potDivInput2TextField;
@property (strong, nonatomic) IBOutlet UITextField *potDivInput3TextField;
@property (strong, nonatomic) IBOutlet UIPickerView *potDivInput1Multiplier;
@property (strong, nonatomic) IBOutlet UIPickerView *potDivInput2Multiplier;
@property (strong, nonatomic) IBOutlet UIPickerView *potDivInput3Multiplier;
@property (strong, nonatomic) IBOutlet UILabel *potDivInput1UnitLabel;
@property (strong, nonatomic) IBOutlet UILabel *potDivInput2UnitLabel;
@property (strong, nonatomic) IBOutlet UILabel *potDivInput3UnitLabel;

@property (strong, nonatomic) IBOutlet UILabel *potDivOutputLabel;

@property NSArray *multiplierPrefix;
@property (strong, nonatomic) NSString *potDivOutputCalcType;
@property (strong, nonatomic) NSString *potDivOutputUnit;

- (IBAction)potDivCalcButtonPressed:(UIButton *)sender;
- (IBAction)hideKeyboardButton:(UIButton *)sender;


- (void) setpotDivOutputLabel; // Function to set output label value after accounting for the unit multiplier
- (void) setpotDivInputLabel; // Function to set input label value depending on potDivCalcPicker value selected by user;
- (void) cautionR; // Function to Display Alert if Resistance or Current is set to 0 when calculating Current or Resistance, respectively
- (void) setBackground; // Function to set Background Image


@end
