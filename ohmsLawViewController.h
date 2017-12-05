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

@property (strong, nonatomic) IBOutlet UIPickerView *ohmsLawCalcPicker;

@property (strong, nonatomic) IBOutlet UITextField *ohmsLawInput1TextField;
@property (strong, nonatomic) IBOutlet UITextField *ohmsLawInput2TextField;

@property (strong, nonatomic) IBOutlet UIPickerView *ohmsLawInput1Multiplier;
@property (strong, nonatomic) IBOutlet UIPickerView *ohmsLawInput2Multiplier;

@property (strong, nonatomic) IBOutlet UILabel *ohmsLawOutputLabel;

@property (strong, nonatomic) IBOutlet UILabel *ohmsLawInput1Label;
@property (strong, nonatomic) IBOutlet UILabel *ohmsLawInput2Label;

@property NSArray *unitOhm;
@property NSArray *unitAmp;
@property NSArray *unitVol;


- (IBAction)ohmsLawCalcButtonPressed:(UIButton *)sender;
- (IBAction)hideKeyboardButton:(UIButton *)sender;
- (void) setOhmsLawOutputLabel; // Function to set output label value after accounting for the unit multiplier
- (void) setOhmsLawInputLabel; // Function to set input label value depending on ohmsLawCalcPicker value selected by user;


@end
