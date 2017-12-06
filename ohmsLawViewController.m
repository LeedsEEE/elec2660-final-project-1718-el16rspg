//
//  ohmsLawViewController.m
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 02/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "ohmsLawViewController.h"

@interface ohmsLawViewController ()
@end

@implementation ohmsLawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Calls Function to set Background image
    (void) [self setBackground];
    
    // Initialise Object of ohmsLawDataModel Class
    self.ohmsLawObject = [[ohmsLawDataModel alloc] init];
    
    // Defining unit array - used in ohmsLawInput1Multiplier & ohmsLawInput2Multiplier pickers
    self.multiplierPrefix = @[@" n",@" µ",@" m",@"  ",@" k",@" M",@" G"];
    
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
    
    // Assigning Default Row (V, A, or Ω) to be displayed for PickerView;
    [self.ohmsLawInput1Multiplier selectRow:3 inComponent:0 animated:NO];
    [self.ohmsLawInput2Multiplier selectRow:3 inComponent:0 animated:NO];
    [self.ohmsLawCalcPicker selectRow:1 inComponent:0 animated:NO];
    
    // Selecting Default Row (V, A, or Ω) to be used for calculations when User does NOT scroll the Picker
    [self pickerView:self.ohmsLawInput1Multiplier didSelectRow:3 inComponent:0];
    [self pickerView:self.ohmsLawInput2Multiplier didSelectRow:3 inComponent:0];
    [self pickerView:self.ohmsLawCalcPicker didSelectRow:1 inComponent:0];
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

// Function to set Formula, Output Calculation Type and Units, Input Label, Input Unit Label depending on ohmsLawCalcPicker value selected by user;
- (void) setOhmsLawInputLabel {
    if ([self.ohmsLawCalcPicker selectedRowInComponent:0] == 0) {
        self.ohmsLawFormulaLabel.text = @"Formula: V = I x R";
        self.ohmsLawOutputCalcType = @"Voltage";
        self.ohmsLawOutputUnit = @"V";
        self.ohmsLawInput1Label.text = @"Current:";
        self.ohmsLawInput1UnitLabel.text = @"A";
        self.ohmsLawInput2Label.text = @"Resistance:";
        self.ohmsLawInput2UnitLabel.text = @"Ω";

    } else if ([self.ohmsLawCalcPicker selectedRowInComponent:0] == 1) {
        self.ohmsLawFormulaLabel.text = @"Formula: I = V ÷ R";
        self.ohmsLawOutputCalcType = @"Current";
        self.ohmsLawOutputUnit = @"A";
        self.ohmsLawInput1Label.text = @"Voltage:";
        self.ohmsLawInput1UnitLabel.text = @"V";
        self.ohmsLawInput2Label.text = @"Resistance:";
        self.ohmsLawInput2UnitLabel.text = @"Ω";
        
    } else {
        self.ohmsLawFormulaLabel.text = @"Formula: R = V ÷ I";
        self.ohmsLawOutputCalcType = @"Resistance";
        self.ohmsLawOutputUnit = @"Ω";
        self.ohmsLawInput1Label.text = @"Voltage:";
        self.ohmsLawInput1UnitLabel.text = @"V";
        self.ohmsLawInput2Label.text = @"Current:";
        self.ohmsLawInput2UnitLabel.text = @"A";

    }
}

// Function to determine Output Label's appropriate Multiplier units. The function divides the output value by 10^-9 to 10^9 to determine if the result is between 1 and 1000. If so, the divisor is the multiplier unit and the result is the output label value.
- (void) setOhmsLawOutputLabel {
    if (self.ohmsLawObject.outputValue/pow(10,-9) >= 1  && self.ohmsLawObject.outputValue/pow(10,-9) < 1000) {
        self.ohmsLawOutputLabel.text = [NSString stringWithFormat: @"%@ = %.3f n%@", self.ohmsLawOutputCalcType, self.ohmsLawObject.outputValue/pow(10,-9), self.ohmsLawOutputUnit];
    } else if (self.ohmsLawObject.outputValue/pow(10,-6) >= 1  && self.ohmsLawObject.outputValue/pow(10,-6) < 1000) {
        self.ohmsLawOutputLabel.text = [NSString stringWithFormat: @"%@ = %.3f µ%@", self.ohmsLawOutputCalcType, self.ohmsLawObject.outputValue/pow(10,-6), self.ohmsLawOutputUnit];
    } else if (self.ohmsLawObject.outputValue/pow(10,-3) >= 1 && self.ohmsLawObject.outputValue/pow(10,-3) < 1000) {
        self.ohmsLawOutputLabel.text = [NSString stringWithFormat: @"%@ = %.3f m%@", self.ohmsLawOutputCalcType, self.ohmsLawObject.outputValue/pow(10,-3), self.ohmsLawOutputUnit];
    } else if (self.ohmsLawObject.outputValue/pow(10,3) >= 1 && self.ohmsLawObject.outputValue/pow(10,3) < 1000) {
        self.ohmsLawOutputLabel.text = [NSString stringWithFormat: @"%@ = %.3f k%@", self.ohmsLawOutputCalcType, self.ohmsLawObject.outputValue/pow(10,3), self.ohmsLawOutputUnit];
    } else if (self.ohmsLawObject.outputValue/pow(10,6) >= 1 && self.ohmsLawObject.outputValue/pow(10,6) < 1000) {
        self.ohmsLawOutputLabel.text = [NSString stringWithFormat: @"%@ = %.3f M%@", self.ohmsLawOutputCalcType, self.ohmsLawObject.outputValue/pow(10,6), self.ohmsLawOutputUnit];
    } else if (self.ohmsLawObject.outputValue/pow(10,9) >= 1) {
        self.ohmsLawOutputLabel.text = [NSString stringWithFormat: @"%@ = %.3f G%@", self.ohmsLawOutputCalcType, self.ohmsLawObject.outputValue/pow(10,9), self.ohmsLawOutputUnit];
    } else {
        self.ohmsLawOutputLabel.text = [NSString stringWithFormat: @"%@ = %.3f %@", self.ohmsLawOutputCalcType, self.ohmsLawObject.outputValue, self.ohmsLawOutputUnit];
    }
}

/* Function to:
 1) Display Alert if both, Voltage and Resistance or Voltage and Current, is set to 0 when calculating Current or Resistance, respectively
 2) Display Alert if Resistance or Current is set to 0 when calculating Current or Resistance, respectively */
- (void) cautionR {
    
    if (([self.ohmsLawCalcPicker selectedRowInComponent:0] == 1 || [self.ohmsLawCalcPicker selectedRowInComponent:0] == 2) && (self.ohmsLawObject.input1Value == 0 && self.ohmsLawObject.input2Value == 0)) {
        UIAlertController *textFieldLimitAlert = [UIAlertController alertControllerWithTitle: @"Caution" message: [NSString stringWithFormat:@"You have chosen your Voltage as 0 V and %@ as 0 %@. This will always produce an undefined result that is not a number.", [self.ohmsLawInput2Label.text substringToIndex:self.ohmsLawInput2Label.text.length-1], self.ohmsLawInput2UnitLabel.text] preferredStyle:UIAlertControllerStyleAlert];
        
        // Note (see above) : [self.ohmsLawInput2Label.text substringToIndex:self.ohmsLawInput2Label.text.length-1]
        // Used to remove ":" at the end of the input2Label
        // Source: https://stackoverflow.com/questions/1082178/objective-c-remove-last-character-from-string
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [textFieldLimitAlert addAction:ok];
        [self presentViewController:textFieldLimitAlert animated:YES completion:nil];
    }
    
    if (([self.ohmsLawCalcPicker selectedRowInComponent:0] == 1 || [self.ohmsLawCalcPicker selectedRowInComponent:0] == 2) && self.ohmsLawObject.input2Value == 0) {
        UIAlertController *textFieldLimitAlert = [UIAlertController alertControllerWithTitle:@"Caution" message:[NSString stringWithFormat:@"You have chosen your %@ as 0 %@. This will always produce an infinite %@.", [self.ohmsLawInput2Label.text substringToIndex:self.ohmsLawInput2Label.text.length-1], self.ohmsLawInput2UnitLabel.text, self.ohmsLawOutputCalcType] preferredStyle:UIAlertControllerStyleAlert];
        
        // Note (see above) : [self.ohmsLawInput2Label.text substringToIndex:self.ohmsLawInput2Label.text.length-1]
        // Used to remove ":" at the end of the input2Label
        // Source: https://stackoverflow.com/questions/1082178/objective-c-remove-last-character-from-string

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

// Setting PickerView Number of Rows
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([pickerView isEqual: self.ohmsLawCalcPicker]) {
        return 3;   // ohmsLawCalcPicker has 3 rows
    } else {
        return 7;   // all other pickers have 7 rows
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
            pickerLabel.font = [UIFont fontWithName: @"Chalkboard SE" size: 16];
            pickerLabel.textColor = [UIColor blackColor];
            pickerLabel.textAlignment = NSTextAlignmentLeft;
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
    } else {
            pickerLabel.text = self.multiplierPrefix[row];
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
    
    // Calls Function to Display Alert if Resistance or Current is set to 0 when calculating Current or Resistance, respectively
    (void) [self cautionR];
    
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
