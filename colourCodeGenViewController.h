//
//  colourCodeGenViewController.h
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 03/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "colourCodeGenDataModel.h"

@interface colourCodeGenViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) colourCodeGenDataModel *colourCodeGenObject;
@property (strong, nonatomic) IBOutlet UITextField *inputRTextField;
@property (strong, nonatomic) IBOutlet UIPickerView *multiplierPicker;
@property (strong, nonatomic) IBOutlet UIPickerView *tolerancePicker;
@property (strong, nonatomic) IBOutlet UILabel *outputLabel;
@property NSArray *multiplierPrefix;

@property (strong, nonatomic) IBOutlet UILabel *Band1Label;
@property (strong, nonatomic) IBOutlet UILabel *Band2Label;
@property (strong, nonatomic) IBOutlet UILabel *Band3Label;
@property (strong, nonatomic) IBOutlet UILabel *Band4Label;


- (IBAction)CalcButtonPressed:(UIButton *)sender;
- (IBAction)hideKeyboardButton:(UIButton *)sender;
- (void) setColourCodeGenOutputLabel; // Function to set output label value after accounting for the unit multiplier
- (void) setBackground; // Function to set Background Image


@end
