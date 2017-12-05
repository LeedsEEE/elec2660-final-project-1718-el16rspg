//
//  parallelRViewController.m
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 02/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "parallelRViewController.h"

@interface parallelRViewController ()

@end

@implementation parallelRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Initialise Object of parallelRDataModel Class
    self.parallelRObject = [[parallelRDataModel alloc] init];
    
    // Display Decimal Pad Keyboard Type
    self.parallelR1InputTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.parallelR2InputTextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.parallelR3InputTextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    // Assigning Text Field Delegate as View Controller - needed to restrict character limit
    self.parallelR1InputTextField.delegate = self;
    self.parallelR2InputTextField.delegate = self;
    self.parallelR3InputTextField.delegate = self;
    
    // Assigning Picker View Delegate and Data Source as View Controller
    self.parallelR1InputMultiplier.dataSource = self;
    self.parallelR1InputMultiplier.delegate = self;
    self.parallelR2InputMultiplier.dataSource = self;
    self.parallelR2InputMultiplier.delegate = self;
    self.parallelR3InputMultiplier.dataSource = self;
    self.parallelR3InputMultiplier.delegate = self;
    
    // Assigning Default Row to be displayed for PickerView;
    [self.parallelR1InputMultiplier selectRow:3 inComponent:0 animated:NO];
    [self.parallelR2InputMultiplier selectRow:3 inComponent:0 animated:NO];
    [self.parallelR3InputMultiplier selectRow:3 inComponent:0 animated:NO];
    
    // Selecting Default Row to be used for calculations when User does NOT scroll the Picker
    [self pickerView:self.parallelR1InputMultiplier didSelectRow:3 inComponent:0];
    [self pickerView:self.parallelR2InputMultiplier didSelectRow:3 inComponent:0];
    [self pickerView:self.parallelR3InputMultiplier didSelectRow:3 inComponent:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Functions

// Function to determine Output Label's appropriate multiplier units
- (void) setParallelROutputLabel {
    if (self.parallelRObject.RFinalValue/pow(10,-9) >= 1  && self.parallelRObject.RFinalValue/pow(10,-9) < 1000) {
        self.parallelROutputLabel.text = [NSString stringWithFormat: @"R = %.3f nΩ", self.parallelRObject.RFinalValue/pow(10,-9)];
    } else if (self.parallelRObject.RFinalValue/pow(10,-6) >= 1  && self.parallelRObject.RFinalValue/pow(10,-6) < 1000) {
        self.parallelROutputLabel.text = [NSString stringWithFormat: @"R = %.3f µΩ", self.parallelRObject.RFinalValue/pow(10,-6)];
    } else if (self.parallelRObject.RFinalValue/pow(10,-3) >= 1 && self.parallelRObject.RFinalValue/pow(10,-3) < 1000) {
        self.parallelROutputLabel.text = [NSString stringWithFormat: @"R = %.3f mΩ", self.parallelRObject.RFinalValue/pow(10,-3)];
    } else if (self.parallelRObject.RFinalValue/pow(10,3) >= 1 && self.parallelRObject.RFinalValue/pow(10,3) < 1000) {
        self.parallelROutputLabel.text = [NSString stringWithFormat: @"R = %.3f kΩ", self.parallelRObject.RFinalValue/pow(10,3)];
    } else if (self.parallelRObject.RFinalValue/pow(10,6) >= 1 && self.parallelRObject.RFinalValue/pow(10,6) < 1000) {
        self.parallelROutputLabel.text = [NSString stringWithFormat: @"R = %.3f MΩ", self.parallelRObject.RFinalValue/pow(10,6)];
    } else if (self.parallelRObject.RFinalValue/pow(10,9) >= 1) {
        self.parallelROutputLabel.text = [NSString stringWithFormat: @"R = %.3f GΩ", self.parallelRObject.RFinalValue/pow(10,9)];
    } else {
        self.parallelROutputLabel.text = [NSString stringWithFormat: @"R = %.3f Ω", self.parallelRObject.RFinalValue];
    }
}


// Function to Display Alert if R1 and/or R2 are set to 0
- (void) cautionR {
    
    if (self.parallelRObject.R1Value == 0 && self.parallelRObject.R2Value == 0) {
        
        UIAlertController *textFieldLimitAlert = [UIAlertController alertControllerWithTitle:@"Caution" message:@"You have chosen your R1 and R2 values as 0 Ω. This will always produce a total equivalent resistance, R, of 0 Ω." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [textFieldLimitAlert addAction:ok];
        [self presentViewController:textFieldLimitAlert animated:YES completion:nil];
        
    } else if (self.parallelRObject.R1Value == 0) {
        
        UIAlertController *textFieldLimitAlert = [UIAlertController alertControllerWithTitle:@"Caution" message:@"You have chosen your R1 value as 0 Ω. This will always produce a total equivalent resistance, R, of 0 Ω." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [textFieldLimitAlert addAction:ok];
        [self presentViewController:textFieldLimitAlert animated:YES completion:nil];
        
    } else if (self.parallelRObject.R2Value == 0) {
        
        UIAlertController *textFieldLimitAlert = [UIAlertController alertControllerWithTitle:@"Caution" message:@"You have chosen your R2 value as 0 Ω. This will always produce a total equivalent resistance, R, of 0 Ω." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [textFieldLimitAlert addAction:ok];
        [self presentViewController:textFieldLimitAlert animated:YES completion:nil];
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
    self.parallelRObject.R1Multiplier = [self.parallelR1InputMultiplier selectedRowInComponent:0];
    self.parallelRObject.R2Multiplier = [self.parallelR2InputMultiplier selectedRowInComponent:0];
    self.parallelRObject.R3Multiplier = [self.parallelR3InputMultiplier selectedRowInComponent:0];
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
            UIAlertController *textFieldLimitAlert = [UIAlertController alertControllerWithTitle:@"Character Limit Reached" message:@"You may only enter a maximum of 10 characters per text field. Perhaps, you may want to consider using the multiplier picker to change the units." preferredStyle:UIAlertControllerStyleAlert];
            
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

- (IBAction)parallelRCalcButtonPressed:(UIButton *)sender {
    
    // Hide Keyboard if Calculate Button Pressed
    [[self parallelR1InputTextField] resignFirstResponder];
    [[self parallelR2InputTextField] resignFirstResponder];
    [[self parallelR3InputTextField] resignFirstResponder];
    
    // Assign User Input Values to Object Variables
    self.parallelRObject.R1Value = [self.parallelR1InputTextField.text doubleValue];
    self.parallelRObject.R2Value = [self.parallelR2InputTextField.text doubleValue];
    self.parallelRObject.R3Value = [self.parallelR3InputTextField.text doubleValue];
    
    // Calls Function to Display Alert if R1 and/or R2 are set to 0
    (void) [self cautionR];
    
    // Get Calculated Value from Object and display on Output Label
    (void) [[self parallelRObject] calcRFinalValue];
    
    // Calls Function to determine Output Label's appropriate multiplier units
    (void) [self setParallelROutputLabel];
}

// Hide Keyboard when User touches outside Keyboard
- (IBAction)hideKeyboardButton:(UIButton *)sender {
    if (self.parallelR1InputTextField.isFirstResponder) {
        [[self parallelR1InputTextField] resignFirstResponder];
    }
    if (self.parallelR2InputTextField.isFirstResponder) {
        [[self parallelR2InputTextField] resignFirstResponder];
    }
    if (self.parallelR3InputTextField.isFirstResponder) {
        [[self parallelR3InputTextField] resignFirstResponder];
    }
}

@end
