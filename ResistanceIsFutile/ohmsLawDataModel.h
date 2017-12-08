//
//  ohmsLawDataModel.h
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 04/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//
//  Data Model Class to perform Ohm's Law Calculations

#import <Foundation/Foundation.h>

@interface ohmsLawDataModel : NSObject

// Used to define the calculation type selected by user through the ohmsLawCalcPicker on the calculator's view controlled
@property double calcType;

// Used to store values entered by User in Text Fields on the calculator's view controller
@property double input1Value;
@property double input2Value;

// Used to store values entered by User in Picker on the calculator's view controller
@property double input1Multiplier;
@property double input2Multiplier;

@property double outputValue;

// Method to calculate Final Output Value
-(void) calcFinalValue;

@end
