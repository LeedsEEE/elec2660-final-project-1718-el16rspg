//
//  parallelRViewController.h
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 02/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "parallelRDataModel.h"

@interface parallelRViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) parallelRDataModel *parallelRObject;

@property (strong, nonatomic) IBOutlet UITextField *parallelR1InputTextField;
@property (strong, nonatomic) IBOutlet UITextField *parallelR2InputTextField;
@property (strong, nonatomic) IBOutlet UITextField *parallelR3InputTextField;

@property (strong, nonatomic) IBOutlet UIPickerView *parallelR1InputMultiplier;
@property (strong, nonatomic) IBOutlet UIPickerView *parallelR2InputMultiplier;
@property (strong, nonatomic) IBOutlet UIPickerView *parallelR3InputMultiplier;

@property (strong, nonatomic) IBOutlet UILabel *parallelROutputLabel;


- (IBAction)parallelRCalcButtonPressed:(UIButton *)sender;
- (IBAction)hideKeyboardButton:(UIButton *)sender;
- (void)setParallelROutputLabel; // Function to set output label value after accounting for the unit multiplier
- (void) cautionR; // Function to Display Alert if R1 and/or R2 are set to 0
- (void) setBackground; // Function to set Background Image



@end
