//
//  seriesRViewController.h
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 02/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "seriesRDataModel.h"

@interface seriesRViewController : UIViewController <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) seriesRDataModel *seriesRObject;

@property (strong, nonatomic) IBOutlet UITextField *seriesR1InputTextField;
@property (strong, nonatomic) IBOutlet UITextField *seriesR2InputTextField;
@property (strong, nonatomic) IBOutlet UITextField *seriesR3InputTextField;

@property (strong, nonatomic) IBOutlet UIPickerView *seriesR1InputMultiplier;
@property (strong, nonatomic) IBOutlet UIPickerView *seriesR2InputMultiplier;
@property (strong, nonatomic) IBOutlet UIPickerView *seriesR3InputMultiplier;

@property (strong, nonatomic) IBOutlet UILabel *seriesROutputLabel;


- (IBAction)seriesRCalcButtonPressed:(UIButton *)sender;
- (IBAction)hideKeyboardButton:(UIButton *)sender;
- (void)setSeriesROutputLabel; // Function to set output label value after accounting for the unit multiplier
- (void) setBackground; // Function to set Background Image

@end
