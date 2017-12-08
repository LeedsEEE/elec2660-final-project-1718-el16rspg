//
//  potDivDataModel.h
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 06/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//
//  Data Model Class to perform Potential Divider Calculations

#import <Foundation/Foundation.h>

@interface potDivDataModel : NSObject

// Used to define the calculation type selected by user through the ohmsLawCalcPicker on the calculator's view controlled
@property double calcType;

// Used to store values entered by User in Text Fields on the calculator's view controller
@property double input1Value;
@property double input2Value;
@property double input3Value;

// Used to store values entered by User in Picker on the calculator's view controller
@property double input1Multiplier;
@property double input2Multiplier;
@property double input3Multiplier;

@property double outputValue;

// Method to calculate Final Output Value
-(void) calcFinalValue;

@end
