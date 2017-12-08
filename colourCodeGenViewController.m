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
    
    // Calls Function to set Background image
    (void) [self setBackground];
    
    // Initialises Object of colourCodeGenDataModel Class
    self.colourCodeGenObject = [[colourCodeGenDataModel alloc] init];
    
    // Defining array for multiplierPicker
    self.multiplierArray = @[@"Ω",@"kΩ",@"MΩ"];
    
    // Display Decimal Pad Keyboard Type
    self.inputRTextField.keyboardType = UIKeyboardTypeDecimalPad;
    
    // Assigning Text Field Delegate as View Controller - needed to restrict character limit
    self.inputRTextField.delegate = self;
    
    // Assigning Picker View Delegate and Data Source as View Controller
    self.multiplierPicker.dataSource = self;
    self.multiplierPicker.delegate = self;
    self.tolerancePicker.dataSource = self;
    self.tolerancePicker.delegate = self;
    
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


// Function to set Output Label & display Colour Bands
- (void) setColourCodeGenOutputLabel; {
    
    // Defining output label when inputRValue = 0
    if (self.colourCodeGenObject.inputRValue == 0) {
        self.outputLabel.text = @"Enter Values & Calculate";
        
        // Display Alert if inputRValue = 0
        // Source: http://nshipster.com/uialertcontroller/
        // ---------------------------------------------------------------------------------------
        UIAlertController *textFieldLimitAlert = [UIAlertController alertControllerWithTitle:@"Caution" message:@"Please enter a non-zero resistor value." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
        
        [textFieldLimitAlert addAction:ok];
        
        [self presentViewController:textFieldLimitAlert animated:YES completion:nil];
        // ---------------------------------------------------------------------------------------
        
    } else {    // Defining output label when inputRValue ranges from 0.1 Ω to 1 GΩ
        
        
        // Setting acceptable input range - from 0.1 Ω to 1 GΩ
        if (self.colourCodeGenObject.inputRValue >= 0.1 && self.colourCodeGenObject.inputRValue <= 1*pow(10,9)) {
            
            // Displaying Output Label after accounting for Multiplier and Tolerance (E12 vs E24)
            if (self.colourCodeGenObject.inputTolerance == 0) {
                if (self.colourCodeGenObject.finalRValue/pow(10,-3) >= 1 && self.colourCodeGenObject.finalRValue/pow(10,-3) < 1000) {
                    self.outputLabel.text = [NSString stringWithFormat: @"E12 Series Resistor: \n %.1f mΩ", self.colourCodeGenObject.finalRValue/pow(10,-3)];
                } else if (self.colourCodeGenObject.finalRValue/pow(10,3) >= 1 && self.colourCodeGenObject.finalRValue/pow(10,3) < 1000) {
                    self.outputLabel.text = [NSString stringWithFormat: @"E12 Series Resistor: \n %.1f kΩ", self.colourCodeGenObject.finalRValue/pow(10,3)];
                } else if (self.colourCodeGenObject.finalRValue/pow(10,6) >= 1 && self.colourCodeGenObject.finalRValue/pow(10,6) < 1000) {
                    self.outputLabel.text = [NSString stringWithFormat: @"E12 Series Resistor: \n %.1f MΩ", self.colourCodeGenObject.finalRValue/pow(10,6)];
                } else if (self.colourCodeGenObject.finalRValue/pow(10,9) >= 1 && self.colourCodeGenObject.finalRValue/pow(10,9) < 1000) {
                    self.outputLabel.text = [NSString stringWithFormat: @"E12 Series Resistor: \n %.1f GΩ", self.colourCodeGenObject.finalRValue/pow(10,9)];
                } else {
                    self.outputLabel.text = [NSString stringWithFormat: @"E12 Series Resistor: \n %.1f Ω", self.colourCodeGenObject.finalRValue];
                }
            } else {
                if (self.colourCodeGenObject.finalRValue/pow(10,-3) >= 1 && self.colourCodeGenObject.finalRValue/pow(10,-3) < 1000) {
                    self.outputLabel.text = [NSString stringWithFormat: @"E24 Series Resistor: \n %.1f mΩ", self.colourCodeGenObject.finalRValue/pow(10,-3)];
                } else if (self.colourCodeGenObject.finalRValue/pow(10,3) >= 1 && self.colourCodeGenObject.finalRValue/pow(10,3) < 1000) {
                    self.outputLabel.text = [NSString stringWithFormat: @"E24 Series Resistor: \n %.1f kΩ", self.colourCodeGenObject.finalRValue/pow(10,3)];
                } else if (self.colourCodeGenObject.finalRValue/pow(10,6) >= 1 && self.colourCodeGenObject.finalRValue/pow(10,6) < 1000) {
                    self.outputLabel.text = [NSString stringWithFormat: @"E24 Series Resistor: \n %.1f MΩ", self.colourCodeGenObject.finalRValue/pow(10,6)];
                } else if (self.colourCodeGenObject.finalRValue/pow(10,9) >= 1 && self.colourCodeGenObject.finalRValue/pow(10,9) < 1000) {
                    self.outputLabel.text = [NSString stringWithFormat: @"E24 Series Resistor: \n %.1f GΩ", self.colourCodeGenObject.finalRValue/pow(10,9)];
                } else {
                    self.outputLabel.text = [NSString stringWithFormat: @"E24 Series Resistor: \n %.1f Ω", self.colourCodeGenObject.finalRValue];
                }
            }
            
            
            // Setting Band 1 and Band 2 Colour & Text
            self.Band1Label.backgroundColor = [self.colourCodeGenObject.bandColourArray objectAtIndex:self.colourCodeGenObject.firstSigDig];
            self.bandTextLabel1.text = [self.colourCodeGenObject.bandTextArray objectAtIndex:self.colourCodeGenObject.firstSigDig];
            self.Band2Label.backgroundColor = [self.colourCodeGenObject.bandColourArray objectAtIndex:self.colourCodeGenObject.secondSigDig];
            self.bandTextLabel2.text = [self.colourCodeGenObject.bandTextArray objectAtIndex:self.colourCodeGenObject.secondSigDig];
            
            
            // Adjusting outputMultiplier when it is negative to reflect appropriate Band Colour index in array
            if (self.colourCodeGenObject.outputMultiplier == -1) {
                self.Band3Label.backgroundColor = [self.colourCodeGenObject.bandColourArray objectAtIndex:10];  // Gold Colour
                self.bandTextLabel3.text = [self.colourCodeGenObject.bandTextArray objectAtIndex:10];   // Gold Text
                
            } else if (self.colourCodeGenObject.outputMultiplier == -2) {
                self.Band3Label.backgroundColor = [self.colourCodeGenObject.bandColourArray objectAtIndex:11];  // Silver Colour
                self.bandTextLabel3.text = [self.colourCodeGenObject.bandTextArray objectAtIndex:11];   // Silver Text
                
            } else {
                self.Band3Label.backgroundColor = [self.colourCodeGenObject.bandColourArray objectAtIndex:self.colourCodeGenObject.outputMultiplier]; // All other Cases
                self.bandTextLabel3.text = [self.colourCodeGenObject.bandTextArray objectAtIndex:self.colourCodeGenObject.outputMultiplier]; // All other Cases
            }
            
            
            // Setting Band 4 Colour & Text
            if (self.colourCodeGenObject.inputTolerance == 0) {
                self.Band4Label.backgroundColor = [UIColor colorWithRed:0.76 green:0.80 blue:0.80 alpha:0.9];   // Silver Colour
                self.bandTextLabel4.text = @"Silver";// Silver Text
            } else {
                self.Band4Label.backgroundColor = [UIColor colorWithRed:0.99 green:0.76 blue:0.0 alpha:0.9];    // Gold Colour
                self.bandTextLabel4.text = @"Gold"; // Gold Text
            }
            
            
        } else { // Defining output label as Invalid Input when inputRValue is NOT ranging from 0.1 Ω to 1 GΩ
            self.outputLabel.text = @"Invalid Input";
            
            // Clearing all band colours when inputRValue is NOT ranging from 0.1 Ω to 1 GΩ
            self.Band1Label.backgroundColor = [UIColor clearColor];
            self.Band2Label.backgroundColor = [UIColor clearColor];
            self.Band3Label.backgroundColor = [UIColor clearColor];
            self.Band4Label.backgroundColor = [UIColor clearColor];
            self.bandTextLabel1.text = @" ";
            self.bandTextLabel2.text = @" ";
            self.bandTextLabel3.text = @" ";
            self.bandTextLabel4.text = @" ";
            
            
            // Display Alert if inputRValue when inputRValue is NOT ranging from 0.1 Ω to 1 GΩ
            // Source: http://nshipster.com/uialertcontroller/
            // ---------------------------------------------------------------------------------------
            UIAlertController *textFieldLimitAlert = [UIAlertController alertControllerWithTitle:@"Invalid Input" message:@"Please enter resistor values ranging from 0.1 Ω to 1 GΩ." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
            
            [textFieldLimitAlert addAction:ok];
            
            [self presentViewController:textFieldLimitAlert animated:YES completion:nil];
            // ---------------------------------------------------------------------------------------
        }
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
        return 3;   // multiplierPicker has 3 rows
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
        } else {
            pickerLabel.text = @"5% (E24)";
        }
    } else {
        pickerLabel.text = self.multiplierArray[row];
    }
    return pickerLabel;
}

// Matching Row Index with Column to access Value
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.colourCodeGenObject.inputTolerance = (int)[self.tolerancePicker selectedRowInComponent:0];
    self.colourCodeGenObject.inputMultiplier = (int)[self.multiplierPicker selectedRowInComponent:0];
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
    
    // Run calcNPVValue function in colourCodeGenObject and run setColourCodeGenOutputLabel method;
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
    
}

// Hide Keyboard when User touches outside Keyboard
- (IBAction)hideKeyboardButton:(UIButton *)sender {
    if (self.inputRTextField.isFirstResponder) {
        [[self inputRTextField] resignFirstResponder];
    }
}
@end
