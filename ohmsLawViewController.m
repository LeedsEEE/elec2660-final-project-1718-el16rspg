//
//  ohmsLawViewController.m
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 02/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "ohmsLawViewController.h"

@interface ohmsLawViewController ()
{

}
@end

@implementation ohmsLawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Defining unit arrays
    self.unitOhm = @[@"nΩ",@"µΩ",@"mΩ",@"Ω",@"kΩ",@"MΩ",@"GΩ"];
    self.unitAmp = @[@"nA",@"µA",@"mA",@"A",@"kA",@"MA",@"GA"];
    self.unitVol = @[@"nV",@"µV",@"mV",@"V",@"kV",@"MV",@"GV"];
    
    // Initialise Object of ohmsLawDataModel Class
    self.ohmsLawObject = [[ohmsLawDataModel alloc] init];
    
    // Display Decimal Pad Keyboard Type
    self.ohmsLawInput1TextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.ohmsLawInput2TextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    // Assigning Text Field Delegate as View Controller - needed to restrict character limit
    self.ohmsLawInput1TextField.delegate = self;
    self.ohmsLawInput2TextField.delegate = self;
    
    // Assigning Picker View Delegate and Data Source as View Controller
    self.ohmsLawCalcPicker.dataSource = self;
    self.ohmsLawCalcPicker.delegate = self;
    self.ohmsLawInput1Multiplier.dataSource = self;
    self.ohmsLawInput1Multiplier.delegate = self;
    self.ohmsLawInput2Multiplier.dataSource = self;
    self.ohmsLawInput2Multiplier.delegate = self;
    
    // Assigning Default Row to be displayed for PickerView;
    [self.ohmsLawInput1Multiplier selectRow:3 inComponent:0 animated:NO];
    [self.ohmsLawInput2Multiplier selectRow:3 inComponent:0 animated:NO];
    [self.ohmsLawCalcPicker selectRow:1 inComponent:0 animated:NO];
    
    // Selecting Default Row to be used for calculations when User does NOT scroll the Picker
    [self pickerView:self.ohmsLawInput1Multiplier didSelectRow:3 inComponent:0];
    [self pickerView:self.ohmsLawInput2Multiplier didSelectRow:3 inComponent:0];
    [self pickerView:self.ohmsLawCalcPicker didSelectRow:1 inComponent:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Functions


// Function to set input label value depending on ohmsLawCalcPicker value selected by user;
- (void) setOhmsLawInputLabel {
    if ([self.ohmsLawCalcPicker selectedRowInComponent:0] == 0) {
        self.ohmsLawInput1Label.text = [NSString stringWithFormat: @"Current:"];
        self.ohmsLawInput2Label.text = [NSString stringWithFormat: @"Resistance:"];
    } else if ([self.ohmsLawCalcPicker selectedRowInComponent:0] == 1) {
        self.ohmsLawInput1Label.text = [NSString stringWithFormat: @"Voltage:"];
        self.ohmsLawInput2Label.text = [NSString stringWithFormat: @"Resistance:"];
    } else {
        self.ohmsLawInput1Label.text = [NSString stringWithFormat: @"Voltage:"];
        self.ohmsLawInput2Label.text = [NSString stringWithFormat: @"Current:"];
    }
}

// Function to determine Output Label's appropriate multiplier units
- (void) setOhmsLawOutputLabel {
    if (self.ohmsLawObject.outputValue/pow(10,-9) >= 1  && self.ohmsLawObject.outputValue/pow(10,-9) < 1000) {
        self.ohmsLawOutputLabel.text = [NSString stringWithFormat: @"V = %.3f nV", self.ohmsLawObject.outputValue/pow(10,-9)];
    } else if (self.ohmsLawObject.outputValue/pow(10,-6) >= 1  && self.ohmsLawObject.outputValue/pow(10,-6) < 1000) {
        self.ohmsLawOutputLabel.text = [NSString stringWithFormat: @"V = %.3f µV", self.ohmsLawObject.outputValue/pow(10,-6)];
    } else if (self.ohmsLawObject.outputValue/pow(10,-3) >= 1 && self.ohmsLawObject.outputValue/pow(10,-3) < 1000) {
        self.ohmsLawOutputLabel.text = [NSString stringWithFormat: @"V = %.3f mV", self.ohmsLawObject.outputValue/pow(10,-3)];
    } else if (self.ohmsLawObject.outputValue/pow(10,3) >= 1 && self.ohmsLawObject.outputValue/pow(10,3) < 1000) {
        self.ohmsLawOutputLabel.text = [NSString stringWithFormat: @"V = %.3f kV", self.ohmsLawObject.outputValue/pow(10,3)];
    } else if (self.ohmsLawObject.outputValue/pow(10,6) >= 1 && self.ohmsLawObject.outputValue/pow(10,6) < 1000) {
        self.ohmsLawOutputLabel.text = [NSString stringWithFormat: @"V = %.3f MV", self.ohmsLawObject.outputValue/pow(10,6)];
    } else if (self.ohmsLawObject.outputValue/pow(10,9) >= 1) {
        self.ohmsLawOutputLabel.text = [NSString stringWithFormat: @"V = %.3f GV", self.ohmsLawObject.outputValue/pow(10,9)];
    } else {
        self.ohmsLawOutputLabel.text = [NSString stringWithFormat: @"V = %.3f V", self.ohmsLawObject.outputValue];
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

// Setting PickerView Number of Rows
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([pickerView isEqual: self.ohmsLawCalcPicker]) {
        return 3;
    } else {
        return 7;
    }
}


#pragma mark - Picker Delegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    // Assigning PickerView Labels
    UILabel* pickerLabel = (UILabel *)view;
    
    // Customising PickerView Label Appearance
    if ([ pickerView isEqual: self.ohmsLawCalcPicker]) {
        if (!pickerLabel) {
            pickerLabel = [[UILabel alloc] init];
            pickerLabel.font = [UIFont fontWithName: @"Sketch Block" size: 18];
            pickerLabel.textColor = [UIColor blackColor];
            pickerLabel.textAlignment = NSTextAlignmentCenter;
        }
    } else {
        if (!pickerLabel) {
            pickerLabel = [[UILabel alloc] init];
            pickerLabel.font = [UIFont fontWithName: @"Sketch Block" size: 16];
            pickerLabel.textColor = [UIColor blackColor];
            pickerLabel.textAlignment = NSTextAlignmentCenter;
        }
    }
    
    //Assigning PickerView Label Text
    if ([pickerView isEqual: self.ohmsLawCalcPicker]) {
        if (row == 0) {
            pickerLabel.text = @"Calculate Voltage";
        } else if (row == 1) {
            pickerLabel.text = @"Calculate Current";
        } else {
            pickerLabel.text = @"Calculate Resistance";
        }
    } else if ([pickerView isEqual: self.ohmsLawInput1Multiplier]) {
        if ([self.ohmsLawCalcPicker selectedRowInComponent:0] == 0) {
            pickerLabel.text = self.unitAmp[row];
        } else {
            pickerLabel.text = self.unitVol[row];
        }
    } else {
        if ([self.ohmsLawCalcPicker selectedRowInComponent:0] == 2) {
            pickerLabel.text = self.unitAmp[row];
        } else {
            pickerLabel.text = self.unitOhm[row];
        }
    }
    return pickerLabel;
}

// Matching Row Index with Column to access Value
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.ohmsLawObject.calcType = [self.ohmsLawCalcPicker selectedRowInComponent:0];
    self.ohmsLawObject.input1Multiplier = [self.ohmsLawInput1Multiplier selectedRowInComponent:0];
    self.ohmsLawObject.input2Multiplier = [self.ohmsLawInput2Multiplier selectedRowInComponent:0];
    
    // Calling function to change Ohms Law Input Label
    (void) [self setOhmsLawInputLabel];
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


- (IBAction)ohmsLawCalcButtonPressed:(UIButton *)sender {
    
    // Hide Keyboard if Calculate Button Pressed
    [[self ohmsLawInput1TextField] resignFirstResponder];
    [[self ohmsLawInput2TextField] resignFirstResponder];
    
    // Assign User Input Values to Object Variables
    self.ohmsLawObject.input1Value = [self.ohmsLawInput1TextField.text doubleValue];
    self.ohmsLawObject.input2Value = [self.ohmsLawInput2TextField.text doubleValue];
    
    // Get Calculated Value from Object and display on Output Label
    (void) [[self ohmsLawObject] calcFinalValue];
    (void) [self setOhmsLawOutputLabel];
}

// Hide Keyboard when User touches outside Keyboard
- (IBAction)hideKeyboardButton:(UIButton *)sender {
    if (self.ohmsLawInput1TextField.isFirstResponder) {
        [[self ohmsLawInput1TextField] resignFirstResponder];
    }
    if (self.ohmsLawInput2TextField.isFirstResponder) {
        [[self ohmsLawInput2TextField] resignFirstResponder];
    }
}

@end
