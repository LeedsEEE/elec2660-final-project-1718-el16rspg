//
//  seriesRViewController.m
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 02/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "seriesRViewController.h"

@interface seriesRViewController ()

@end

@implementation seriesRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Calls Function to set Background image
    (void) [self setBackground];
    
    // Initialise Object of seriesRDataModel Class
    self.seriesRObject = [[seriesRDataModel alloc] init];
    
    // Display Decimal Pad Keyboard Type
    self.seriesR1InputTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.seriesR2InputTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.seriesR3InputTextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    // Assigning Text Field Delegate as View Controller - needed to restrict character limit
    self.seriesR1InputTextField.delegate = self;
    self.seriesR2InputTextField.delegate = self;
    self.seriesR3InputTextField.delegate = self;
    
    // Assigning Picker View Delegate and Data Source as View Controller
    self.seriesR1InputMultiplier.dataSource = self;
    self.seriesR1InputMultiplier.delegate = self;
    self.seriesR2InputMultiplier.dataSource = self;
    self.seriesR2InputMultiplier.delegate = self;
    self.seriesR3InputMultiplier.dataSource = self;
    self.seriesR3InputMultiplier.delegate = self;
    
    // Assigning Default Row to be displayed for PickerView;
    [self.seriesR1InputMultiplier selectRow:3 inComponent:0 animated:NO];
    [self.seriesR2InputMultiplier selectRow:3 inComponent:0 animated:NO];
    [self.seriesR3InputMultiplier selectRow:3 inComponent:0 animated:NO];

    // Selecting Default Row to be used for calculations when User does NOT scroll the Picker
    [self pickerView:self.seriesR1InputMultiplier didSelectRow:3 inComponent:0];
    [self pickerView:self.seriesR2InputMultiplier didSelectRow:3 inComponent:0];
    [self pickerView:self.seriesR3InputMultiplier didSelectRow:3 inComponent:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Functions

// Function to set Background image
// Source: https://stackoverflow.com/questions/38250333/ios-preparing-background-images-for-applications
- (void) setBackground {
    UIImage *bgImage = [UIImage imageNamed:@"blackboard 16_9_v2.png"];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIGraphicsBeginImageContextWithOptions(screenSize, NO, 0.f);
    [bgImage drawInRect:CGRectMake(0.f, 0.f, screenSize.width, screenSize.height)];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIColor *backgroundColor = [UIColor colorWithPatternImage:resultImage];
    self.view.backgroundColor = backgroundColor;
}

// Function to determine Output Label's appropriate multiplier units
- (void) setSeriesROutputLabel {
    if (self.seriesRObject.RFinalValue/pow(10,-9) >= 1  && self.seriesRObject.RFinalValue/pow(10,-9) < 1000) {
        self.seriesROutputLabel.text = [NSString stringWithFormat: @"Total Resistance = %.3f nΩ", self.seriesRObject.RFinalValue/pow(10,-9)];
    } else if (self.seriesRObject.RFinalValue/pow(10,-6) >= 1  && self.seriesRObject.RFinalValue/pow(10,-6) < 1000) {
        self.seriesROutputLabel.text = [NSString stringWithFormat: @"Total Resistance = %.3f µΩ", self.seriesRObject.RFinalValue/pow(10,-6)];
    } else if (self.seriesRObject.RFinalValue/pow(10,-3) >= 1 && self.seriesRObject.RFinalValue/pow(10,-3) < 1000) {
        self.seriesROutputLabel.text = [NSString stringWithFormat: @"Total Resistance = %.3f mΩ", self.seriesRObject.RFinalValue/pow(10,-3)];
    } else if (self.seriesRObject.RFinalValue/pow(10,3) >= 1 && self.seriesRObject.RFinalValue/pow(10,3) < 1000) {
        self.seriesROutputLabel.text = [NSString stringWithFormat: @"Total Resistance = %.3f kΩ", self.seriesRObject.RFinalValue/pow(10,3)];
    } else if (self.seriesRObject.RFinalValue/pow(10,6) >= 1 && self.seriesRObject.RFinalValue/pow(10,6) < 1000) {
        self.seriesROutputLabel.text = [NSString stringWithFormat: @"Total Resistance = %.3f MΩ", self.seriesRObject.RFinalValue/pow(10,6)];
    } else if (self.seriesRObject.RFinalValue/pow(10,9) >= 1) {
        self.seriesROutputLabel.text = [NSString stringWithFormat: @"Total Resistance = %.3f GΩ", self.seriesRObject.RFinalValue/pow(10,9)];
    } else {
        self.seriesROutputLabel.text = [NSString stringWithFormat: @"Total Resistance = %.3f Ω", self.seriesRObject.RFinalValue];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - Picker Data Source

// Setting PickerView Number of Columns to 1
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

// Setting PickerView Number of Rows to 7 (nΩ, µΩ, mΩ, Ω, kΩ, MΩ, GΩ);
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 7;
}


#pragma mark - Picker Delegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    // Assigning PickerView Label
    UILabel* multiplierPickerLabel = (UILabel *)view;
    
    // Customising PickerView Label Appearance
    if (!multiplierPickerLabel) {
        multiplierPickerLabel = [[UILabel alloc] init];
        multiplierPickerLabel.font = [UIFont fontWithName: @"Sketch Block" size: 16];
        multiplierPickerLabel.textColor = [UIColor blackColor];
        multiplierPickerLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    // Assigning PickerView Label Text
    if (row == 0) {
        multiplierPickerLabel.text = @"nΩ";
    } else if (row == 1) {
        multiplierPickerLabel.text = @"µΩ";
    } else if (row == 2) {
        multiplierPickerLabel.text = @"mΩ";
    } else if (row == 3) {
        multiplierPickerLabel.text = @"Ω";
    } else if (row == 4) {
        multiplierPickerLabel.text = @"kΩ";
    } else if (row == 5) {
        multiplierPickerLabel.text = @"MΩ";
    } else {
        multiplierPickerLabel.text = @"GΩ";
    }
    
    return multiplierPickerLabel;
}

// Matching Row Index with Column to access Value
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.seriesRObject.R1Multiplier = [self.seriesR1InputMultiplier selectedRowInComponent:0];
    self.seriesRObject.R2Multiplier = [self.seriesR2InputMultiplier selectedRowInComponent:0];
    self.seriesRObject.R3Multiplier = [self.seriesR3InputMultiplier selectedRowInComponent:0];
}


#pragma mark - Text Field Delegate

// Assigning Text Field Character Limit to 10
// Source: https://stackoverflow.com/questions/433337/set-the-maximum-character-length-of-a-uitextfield
// ----------------------------------------------------------------------------------------------------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    int textFieldLimit = 10;
    
    if (textField.text.length > textFieldLimit-1) {
        if([string isEqualToString:@""] && range.length == 1) {
            return TRUE;
        } else {
            
            // Display Alert if Maximum Character Limit Exceeded
            // Source: http://nshipster.com/uialertcontroller/
            // ---------------------------------------------------------------------------------------
            UIAlertController *textFieldLimitAlert = [UIAlertController alertControllerWithTitle:@"Character Limit Reached!" message:@"You may only enter a maximum of 10 characters per text field. Perhaps, you may want to consider using the multiplier picker to change the units." preferredStyle:UIAlertControllerStyleAlert];

            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];

            [textFieldLimitAlert addAction:ok];

            [self presentViewController:textFieldLimitAlert animated:YES completion:nil];
            // ---------------------------------------------------------------------------------------
            
            return FALSE;
        }
    } else {
        return TRUE;
    }
}
// ---------------------------------------------------------------------------------------------------

#pragma mark - IBAction

- (IBAction)seriesRCalcButtonPressed:(UIButton *)sender {
    
    // Hide Keyboard if Calculate Button Pressed
    [[self seriesR1InputTextField] resignFirstResponder];
    [[self seriesR2InputTextField] resignFirstResponder];
    [[self seriesR3InputTextField] resignFirstResponder];
    
    // Assign User Input Values to Object Variables
    self.seriesRObject.R1Value = [self.seriesR1InputTextField.text doubleValue];
    self.seriesRObject.R2Value = [self.seriesR2InputTextField.text doubleValue];
    self.seriesRObject.R3Value = [self.seriesR3InputTextField.text doubleValue];
    
    // Get Calculated Value from Object and display on Output Label
    (void) [[self seriesRObject] calcRFinalValue];
    (void) [self setSeriesROutputLabel];
}

// Hide Keyboard when User touches outside Keyboard
- (IBAction)hideKeyboardButton:(UIButton *)sender {
    if (self.seriesR1InputTextField.isFirstResponder) {
        [[self seriesR1InputTextField] resignFirstResponder];
    }
    if (self.seriesR2InputTextField.isFirstResponder) {
        [[self seriesR2InputTextField] resignFirstResponder];
    }
    if (self.seriesR3InputTextField.isFirstResponder) {
        [[self seriesR3InputTextField] resignFirstResponder];
    }
}

@end
