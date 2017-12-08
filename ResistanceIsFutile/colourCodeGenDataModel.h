//
//  colourCodeGenDataModel.h
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 07/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//
//  Data Model Class to perform NPV & Colour Code Calculations

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface colourCodeGenDataModel : NSObject


// Used to store values entered by User in Text Field on the calculator's view controller
@property double inputRValue;

// Used to store values entered by User in Picker on the calculator's view controller
@property int inputMultiplier;
@property int inputTolerance;

// For Data Model Calculations
@property int inputDigitsLength;    // Temp. Variable for no. of Digits of the entered resistance
@property double sigInputRValue;    // Temp. Variable for two most significant digits
@property double outputNpvRValue;   // Temp. Variable for Two Sig. Digit Output NPV
@property double finalRValue;       // Contains Output Resistance Value to be displayed to User
@property int outputMultiplier;     // Contains Adjusted Output Multiplier Value
@property int firstSigDig;          // Contains First Sig. Digit (Output)
@property int secondSigDig;         // Contains Second Sig. Digit (Output)

// Arrays to save UIColor and Text for Band Colour and Text
@property (nonatomic, strong) NSArray *bandColourArray;
@property (nonatomic, strong) NSArray *bandTextArray;


// Method to calculate Final Output Value
-(void) calcNPVValue;

@end
