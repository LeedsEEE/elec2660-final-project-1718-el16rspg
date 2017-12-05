//
//  ohmsLawDataModel.m
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 04/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//
//  Data Model Class to perform Ohm's Law Calculations

#import "ohmsLawDataModel.h"

@implementation ohmsLawDataModel

-(void) calcFinalValue; {
    
    // Adjusts R1 Input Values to account for Units (Multiplier)
    if (self.input1Multiplier == 0) {
        self.input1Value = self.input1Value*pow(10,-9);
    } else if (self.input1Multiplier == 1) {
        self.input1Value = self.input1Value*pow(10,-6);
    } else if (self.input1Multiplier == 2) {
        self.input1Value = self.input1Value*pow(10,-3);
    } else if (self.input1Multiplier == 4) {
        self.input1Value = self.input1Value*pow(10,3);
    } else if (self.input1Multiplier == 5) {
        self.input1Value = self.input1Value*pow(10,6);
    } else if (self.input1Multiplier == 6) {
        self.input1Value = self.input1Value*pow(10,9);
    } else {
        self.input1Value = self.input1Value;
    }
    
    // Adjusts R2 Input Values to account for Units (Multiplier)
    if (self.input2Multiplier == 0) {
        self.input2Value = self.input2Value*pow(10,-9);
    } else if (self.input2Multiplier == 1) {
        self.input2Value = self.input2Value*pow(10,-6);
    } else if (self.input2Multiplier == 2) {
        self.input2Value = self.input2Value*pow(10,-3);
    } else if (self.input2Multiplier == 4) {
        self.input2Value = self.input2Value*pow(10,3);
    } else if (self.input2Multiplier == 5) {
        self.input2Value = self.input2Value*pow(10,6);
    } else if (self.input2Multiplier == 6) {
        self.input2Value = self.input2Value*pow(10,9);
    } else {
        self.input2Value = self.input2Value;
    }
    
    // Calculates Final Equivalent Resistance of R1, R2, and R3
    if (self.calcType == 0) {
        self.outputValue = self.input1Value * self.input2Value;
    } else {
        self.outputValue = self.input1Value / self.input2Value;
    }
}

@end
