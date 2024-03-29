//
//  potDivViewController.m
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 02/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//
//  This potDivViewController contains the Potential Divider Calculator

#import "potDivViewController.h"

@interface potDivViewController ()

@end

@implementation potDivViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Calls Function to set Background image
    (void) [self setBackground];
    
    // Initialise Object of potDivDataModel Class
    self.potDivObject = [[potDivDataModel alloc] init];
    
    // Defining unit array - used in potDivInput1Multiplier & potDivInput2Multiplier pickers
    self.multiplierPrefix = @[@" n",@" µ",@" m",@"  ",@" k",@" M",@" G"];
    
    // Display Decimal Pad Keyboard Type when User accesses Input Text Fields
    self.potDivInput1TextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.potDivInput2TextField.keyboardType = UIKeyboardTypeDecimalPad;
    self.potDivInput3TextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    // Assigning Text Field Delegate as View Controller - needed to restrict character limit
    self.potDivInput1TextField.delegate = self;
    self.potDivInput2TextField.delegate = self;
    self.potDivInput3TextField.delegate = self;
    
    // Assigning Picker View Delegate and Data Source as View Controller
    self.potDivCalcPicker.dataSource = self;
    self.potDivCalcPicker.delegate = self;
    self.potDivInput1Multiplier.dataSource = self;
    self.potDivInput1Multiplier.delegate = self;
    self.potDivInput2Multiplier.dataSource = self;
    self.potDivInput2Multiplier.delegate = self;
    self.potDivInput3Multiplier.dataSource = self;
    self.potDivInput3Multiplier.delegate = self;
    
    // Assigning Default Row (V, A, or Ω) to be displayed for PickerView;
    [self.potDivInput1Multiplier selectRow:3 inComponent:0 animated:NO];
    [self.potDivInput2Multiplier selectRow:3 inComponent:0 animated:NO];
    [self.potDivInput3Multiplier selectRow:3 inComponent:0 animated:NO];
    
    // Selecting Default Row (V, A, or Ω) to be used for calculations when User does NOT scroll the Picker
    [self pickerView:self.potDivInput1Multiplier didSelectRow:3 inComponent:0];
    [self pickerView:self.potDivInput2Multiplier didSelectRow:3 inComponent:0];
    [self pickerView:self.potDivInput3Multiplier didSelectRow:3 inComponent:0];
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

/* Function to set Formula, Output Calculation Type and Units, Input Label, Input Unit Label depending on potDivCalcPicker value selected by user;

Table indicating how the Input Values change with different Output Value selections;
 Component#  Output  Input1  Input2  Input3
 0           Vout    Vin     R1      R2
 1           Vin     Vout    R1      R2
 2           R1      Vin     Vout    R2
 3           R2      Vin     Vout    R1  */
- (void) setpotDivInputLabel {
    if ([self.potDivCalcPicker selectedRowInComponent:0] == 0) {
        self.potDivFormulaLabel.text = @"Formula: Vout = Vin (R2 / (R1 + R2)";
        self.potDivOutputCalcType = @"Vout";
        self.potDivOutputUnit = @"V";
        self.potDivInput1Label.text = @"Vin:";
        self.potDivInput1UnitLabel.text = @"V";
        self.potDivInput2Label.text = @"R1:";
        self.potDivInput2UnitLabel.text = @"Ω";
        self.potDivInput3Label.text = @"R2:";
        self.potDivInput3UnitLabel.text = @"Ω";
        
    } else if ([self.potDivCalcPicker selectedRowInComponent:0] == 1) {
        self.potDivFormulaLabel.text = @"Formula: Vin = Vout ((R1 + R2) / R2)";
        self.potDivOutputCalcType = @"Vin";
        self.potDivOutputUnit = @"V";
        self.potDivInput1Label.text = @"Vout:";
        self.potDivInput1UnitLabel.text = @"V";
        self.potDivInput2Label.text = @"R1:";
        self.potDivInput2UnitLabel.text = @"Ω";
        self.potDivInput3Label.text = @"R2:";
        self.potDivInput3UnitLabel.text = @"Ω";
        
    } else if ([self.potDivCalcPicker selectedRowInComponent:0] == 2) {
        self.potDivFormulaLabel.text = @"Formula: R1 = R2 ((Vin - Vout) / Vout)";
        self.potDivOutputCalcType = @"R1";
        self.potDivOutputUnit = @"Ω";
        self.potDivInput1Label.text = @"Vin:";
        self.potDivInput1UnitLabel.text = @"V";
        self.potDivInput2Label.text = @"Vout:";
        self.potDivInput2UnitLabel.text = @"V";
        self.potDivInput3Label.text = @"R2:";
        self.potDivInput3UnitLabel.text = @"Ω";
        
    } else {
        self.potDivFormulaLabel.text = @"Formula: R2 = R1 (Vout / (Vin - Vout))";
        self.potDivOutputCalcType = @"R2";
        self.potDivOutputUnit = @"Ω";
        self.potDivInput1Label.text = @"Vin:";
        self.potDivInput1UnitLabel.text = @"V";
        self.potDivInput2Label.text = @"Vout:";
        self.potDivInput2UnitLabel.text = @"V";
        self.potDivInput3Label.text = @"R1:";
        self.potDivInput3UnitLabel.text = @"Ω";
        
    }
}

// Function to determine Output Label's appropriate Multiplier units.
- (void) setpotDivOutputLabel {

    // IF any text field = 0 or blank; potDivOutputLabel displays "Invalid Input"
    if (self.potDivObject.input1Value == 0 || self.potDivObject.input2Value == 0 || self.potDivObject.input3Value == 0) {
        self.potDivOutputLabel.text = @"Invalid Input";
        
    // ELSE, IF Vout >= Vin display "Invalid Input"
    } else if ([self.potDivCalcPicker selectedRowInComponent:0] >= 2 && (self.potDivObject.input2Value >= self.potDivObject.input1Value)) {
        self.potDivOutputLabel.text = @"Invalid Input";
        
    // ELSE, divide the output value by 10^-9 to 10^9 to determine if the result is between 1 and 1000. If so, the divisor is the multiplier unit and the result is the output label value.
    } else {
        if (self.potDivObject.outputValue/pow(10,-9) >= 1  && self.potDivObject.outputValue/pow(10,-9) < 1000) {
            self.potDivOutputLabel.text = [NSString stringWithFormat: @"%@ = %.3f n%@", self.potDivOutputCalcType, self.potDivObject.outputValue/pow(10,-9), self.potDivOutputUnit];
        } else if (self.potDivObject.outputValue/pow(10,-6) >= 1  && self.potDivObject.outputValue/pow(10,-6) < 1000) {
            self.potDivOutputLabel.text = [NSString stringWithFormat: @"%@ = %.3f µ%@", self.potDivOutputCalcType, self.potDivObject.outputValue/pow(10,-6), self.potDivOutputUnit];
        } else if (self.potDivObject.outputValue/pow(10,-3) >= 1 && self.potDivObject.outputValue/pow(10,-3) < 1000) {
            self.potDivOutputLabel.text = [NSString stringWithFormat: @"%@ = %.3f m%@", self.potDivOutputCalcType, self.potDivObject.outputValue/pow(10,-3), self.potDivOutputUnit];
        } else if (self.potDivObject.outputValue/pow(10,3) >= 1 && self.potDivObject.outputValue/pow(10,3) < 1000) {
            self.potDivOutputLabel.text = [NSString stringWithFormat: @"%@ = %.3f k%@", self.potDivOutputCalcType, self.potDivObject.outputValue/pow(10,3), self.potDivOutputUnit];
        } else if (self.potDivObject.outputValue/pow(10,6) >= 1 && self.potDivObject.outputValue/pow(10,6) < 1000) {
            self.potDivOutputLabel.text = [NSString stringWithFormat: @"%@ = %.3f M%@", self.potDivOutputCalcType, self.potDivObject.outputValue/pow(10,6), self.potDivOutputUnit];
        } else if (self.potDivObject.outputValue/pow(10,9) >= 1) {
            self.potDivOutputLabel.text = [NSString stringWithFormat: @"%@ = %.3f G%@", self.potDivOutputCalcType, self.potDivObject.outputValue/pow(10,9), self.potDivOutputUnit];
        } else {
            self.potDivOutputLabel.text = [NSString stringWithFormat: @"%@ = %.3f %@", self.potDivOutputCalcType, self.potDivObject.outputValue, self.potDivOutputUnit];
        }
    }
}


 
// Function to Display Alert
- (void) cautionR {
    
    // 1) Display Alert IF any text field = 0 or blank;
    if (self.potDivObject.input1Value == 0 || self.potDivObject.input2Value == 0 || self.potDivObject.input3Value == 0) {
        
        // Source: http://nshipster.com/uialertcontroller/
        UIAlertController *textFieldLimitAlert = [UIAlertController alertControllerWithTitle: @"Invalid Input" message: @"Please do not enter 0 or leave any text field blank. Please try again." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        [textFieldLimitAlert addAction:ok];
        [self presentViewController:textFieldLimitAlert animated:YES completion:nil];
        
    // 2) Display Alert IF Vout >= Vin;
    } else if ([self.potDivCalcPicker selectedRowInComponent:0] >= 2 && (self.potDivObject.input2Value >= self.potDivObject.input1Value)) {
        
        // Source: http://nshipster.com/uialertcontroller/
        UIAlertController *textFieldLimitAlert = [UIAlertController alertControllerWithTitle: @"Invalid Input" message: @"Vin cannot be lesser than or equal to Vout. Please try again. " preferredStyle:UIAlertControllerStyleAlert];
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
    if ([pickerView isEqual: self.potDivCalcPicker]) {
        return 4;   // potDivCalcPicker has 4 rows
    } else {
        return 7;   // all other pickers have 7 rows
    }
}


#pragma mark - Picker Delegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    // Assigning PickerView Labels
    UILabel* pickerLabel = (UILabel *)view;
    
    // Customising PickerView Label Appearance
    // 1) Calculation Type Picker
    if ([ pickerView isEqual: self.potDivCalcPicker]) {
        if (!pickerLabel) {
            pickerLabel = [[UILabel alloc] init];
            pickerLabel.font = [UIFont fontWithName: @"Sketch Block" size: 18];
            pickerLabel.textColor = [UIColor blackColor];
            pickerLabel.textAlignment = NSTextAlignmentCenter;
        }
    // 2) Multiplier Units Picker
    } else {
        if (!pickerLabel) {
            pickerLabel = [[UILabel alloc] init];
            pickerLabel.font = [UIFont fontWithName: @"Chalkboard SE" size: 16];
            pickerLabel.textColor = [UIColor blackColor];
            pickerLabel.textAlignment = NSTextAlignmentLeft;
        }
    }
    
    //Assigning PickerView Label Text for potDivCalcPicker
    if ([pickerView isEqual: self.potDivCalcPicker]) {
        if (row == 0) {
            pickerLabel.text = @"Calculate Vout";
        } else if (row == 1) {
            pickerLabel.text = @"Calculate Vin";
        } else if (row == 2) {
            pickerLabel.text = @"Calculate R1";
        } else {
            pickerLabel.text = @"Calculate R2";
        }
    // Assigning PickerView Label Text for the multiplier pickers
    } else {
        pickerLabel.text = self.multiplierPrefix[row];
    }
    return pickerLabel;
}

// Assigning Picker Row Index to appropriate variables for use by Data Model Object
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.potDivObject.calcType = [self.potDivCalcPicker selectedRowInComponent:0];
    self.potDivObject.input1Multiplier = [self.potDivInput1Multiplier selectedRowInComponent:0];
    self.potDivObject.input2Multiplier = [self.potDivInput2Multiplier selectedRowInComponent:0];
    self.potDivObject.input3Multiplier = [self.potDivInput3Multiplier selectedRowInComponent:0];
    
    // Calling function to change Ohms Law Input Label
    (void) [self setpotDivInputLabel];
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

- (IBAction)potDivCalcButtonPressed:(UIButton *)sender {
    
    // Hides Keyboard if Calculate Button Pressed
    [[self potDivInput1TextField] resignFirstResponder];
    [[self potDivInput2TextField] resignFirstResponder];
    [[self potDivInput3TextField] resignFirstResponder];
    
    // Assign User Input Values to Object Variables
    self.potDivObject.input1Value = [self.potDivInput1TextField.text doubleValue];
    self.potDivObject.input2Value = [self.potDivInput2TextField.text doubleValue];
    self.potDivObject.input3Value = [self.potDivInput3TextField.text doubleValue];
    
    // Calls Function to Display Alert
    (void) [self cautionR];
    
    // Get Calculated Value from Object
    (void) [[self potDivObject] calcFinalValue];
    
    // Calls Function to determine Output Label's appropriate multiplier units and display output on Output Label
    (void) [self setpotDivOutputLabel];
}

// Hide Keyboard when User touches outside Keyboard
- (IBAction)hideKeyboardButton:(UIButton *)sender {
    if (self.potDivInput1TextField.isFirstResponder) {
        [[self potDivInput1TextField] resignFirstResponder];
    }
    if (self.potDivInput2TextField.isFirstResponder) {
        [[self potDivInput2TextField] resignFirstResponder];
    }
    if (self.potDivInput3TextField.isFirstResponder) {
        [[self potDivInput3TextField] resignFirstResponder];
    }
}

@end
