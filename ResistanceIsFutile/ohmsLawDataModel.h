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

@property double calcType;
@property double input1Value;
@property double input2Value;
@property double input1Multiplier;
@property double input2Multiplier;
@property double outputValue;

-(void) calcFinalValue; // Method to calculate output value

@end
