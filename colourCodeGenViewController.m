//
//  colourCodeGenViewController.m
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 03/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "colourCodeGenViewController.h"

@interface colourCodeGenViewController ()

@end

@implementation colourCodeGenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Calls Function to set Background image
    (void) [self setBackground];
    
    // Initialise Object of colourCodeGenDataModel Class
    self.colourCodeGenObject = [[colourCodeGenDataModel alloc] init];
    
    // Defining array for multiplierPicker
    self.multiplierPrefix = @[@"nΩ",@"µΩ",@"mΩ",@"Ω",@"kΩ",@"MΩ",@"GΩ"];
    
    // Display Decimal Pad Keyboard Type
    self.inputRTextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    // Assigning Text Field Delegate as View Controller - needed to restrict character limit
    self.inputRTextField.delegate = self;
    
    // Assigning Picker View Delegate and Data Source as View Controller
    self.multiplierPicker.dataSource = self;
    self.multiplierPicker.delegate = self;
    self.tolerancePicker.dataSource = self;
    self.tolerancePicker.delegate = self;
    
    // Assigning Default Row to be displayed for PickerView;
    [self.multiplierPicker selectRow:3 inComponent:0 animated:NO];
    
    // Selecting Default Row to be used for calculations when User does NOT scroll the Picker
    [self pickerView:self.multiplierPicker didSelectRow:3 inComponent:0];
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


// Function to set output label value after accounting for the unit multiplier
- (void) setColourCodeGenOutputLabel; {
    
    if (self.colourCodeGenObject.inputRValue == 0) {
        self.outputLabel.text = [NSString stringWithFormat: @"Enter Values & Calculate"];
        
    } else {
        self.outputLabel.text = [NSString stringWithFormat: @"NPV Resistor: \n %.1f x 10^%d Ω", self.colourCodeGenObject.outputNpvRValue, self.colourCodeGenObject.outputMultiplier];
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
    if ([pickerView isEqual: self.tolerancePicker]) {
        return 2;   // tolerancePicker has 2 rows
    } else {
        return 7;   // all other pickers have 7 rows
    }
}

#pragma mark - Picker Delegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    // Assigning PickerView Labels
    UILabel* pickerLabel = (UILabel *)view;
    
    // Customising PickerView Label Appearance
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.font = [UIFont fontWithName: @"Sketch Block" size: 16];
        pickerLabel.textColor = [UIColor blackColor];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    //Assigning PickerView Label Text
    if ([pickerView isEqual: self.tolerancePicker]) {
        if (row == 0) {
            pickerLabel.text = @"10% (E12)";
            self.Band4Label.backgroundColor = [UIColor colorWithRed:0.76 green:0.80 blue:0.80 alpha:0.9];
        } else {
            pickerLabel.text = @"5% (E24)";
            self.Band4Label.backgroundColor = [UIColor yellowColor];
        }
    } else {
        pickerLabel.text = self.multiplierPrefix[row];
    }
    return pickerLabel;
}

// Matching Row Index with Column to access Value
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.colourCodeGenObject.inputTolerance = (int)[self.tolerancePicker selectedRowInComponent:0];
    self.colourCodeGenObject.inputMultiplier = (int)[self.multiplierPicker selectedRowInComponent:0];
    
    
    
    
    // Calling function to change Ohms Law Input Label
    (void) [self setColourCodeGenOutputLabel];
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
            UIAlertController *textFieldLimitAlert = [UIAlertController alertControllerWithTitle:@"Character Limit Reached!" message:@"You may only enter a maximum of 10 characters. Perhaps, you may want to consider using the multiplier picker to change the units." preferredStyle:UIAlertControllerStyleAlert];
            
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


- (IBAction)CalcButtonPressed:(UIButton *)sender {
    
    // Hide Keyboard if Calculate Button Pressed
    [[self inputRTextField] resignFirstResponder];
    
    
    // Assign User Input Values to Object Variables
    self.colourCodeGenObject.inputRValue = [self.inputRTextField.text doubleValue];
    
    // Get Calculated Value from Object and display on Output Label
    (void) [[self colourCodeGenObject] calcNPVValue];
    (void) [self setColourCodeGenOutputLabel];
    
    NSLog(@"inputRValue: %f", self.colourCodeGenObject.inputRValue);
    NSLog(@"inputMultiplier: %i", self.colourCodeGenObject.inputMultiplier);
    NSLog(@"inputTolerance: %i", self.colourCodeGenObject.inputTolerance);
    NSLog(@"sigInputRValue: %f", self.colourCodeGenObject.sigInputRValue);
    NSLog(@"firstSigDig: %i", self.colourCodeGenObject.firstSigDig);
    NSLog(@"secondSigDig: %i", self.colourCodeGenObject.secondSigDig);
    NSLog(@"Band 3: %i", self.colourCodeGenObject.outputMultiplier);
    NSLog(@"Band 4: %i", self.colourCodeGenObject.inputTolerance);
    
    
    
    self.Band1Label.backgroundColor = [self.colourCodeGenObject.bandColourArray objectAtIndex:self.colourCodeGenObject.firstSigDig];
    self.Band2Label.backgroundColor = [self.colourCodeGenObject.bandColourArray objectAtIndex:self.colourCodeGenObject.secondSigDig];
    self.Band3Label.backgroundColor = [self.colourCodeGenObject.bandColourArray objectAtIndex:self.colourCodeGenObject.outputMultiplier];
    
    
   // self.Band4Label.backgroundColor = self.colourCodeGenObject.toleranceColourArray[self.colourCodeGenObject.inputTolerance];
    
    //[NSArray arrayWithObjects: [UIColor colorWithRed:0.76 green:0.80 blue:0.80 alpha:0.9], [UIColor yellowColor], [UIColor clearColor],nil];

    
   // if (self.colourCodeGenObject.inputTolerance == 0) {
  //      self.Band4Label.backgroundColor = [UIColor /colorWithRed:0.76 green:0.80 blue:0.80 alpha:0.9];
   // } else {
  //      self.Band4Label.backgroundColor = [UIColor yellowColor];
   // }
}

// Hide Keyboard when User touches outside Keyboard
- (IBAction)hideKeyboardButton:(UIButton *)sender {
    if (self.inputRTextField.isFirstResponder) {
        [[self inputRTextField] resignFirstResponder];
    }
}
@end
