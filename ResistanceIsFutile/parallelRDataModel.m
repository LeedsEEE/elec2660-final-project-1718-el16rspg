//
//  parallelRDataModel.m
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 04/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//
//  Data Model Class to Calculate the Parallel Equivalent Resistance of 3 Resistors


#import "parallelRDataModel.h"

@implementation parallelRDataModel

-(void) calcRFinalValue; {
    
    // Adjusts R1 Input Values to account for Units (Multiplier) and Divides the adjusted value from 1 to prepare for final calculation
    if (self.R1Multiplier == 0) {
        self.R1Value = 1/(self.R1Value*pow(10,-9));
    } else if (self.R1Multiplier == 1) {
        self.R1Value = 1/(self.R1Value*pow(10,-6));
    } else if (self.R1Multiplier == 2) {
        self.R1Value = 1/(self.R1Value*pow(10,-3));
    } else if (self.R1Multiplier == 4) {
        self.R1Value = 1/(self.R1Value*pow(10,3));
    } else if (self.R1Multiplier == 5) {
        self.R1Value = 1/(self.R1Value*pow(10,6));
    } else if (self.R1Multiplier == 6) {
        self.R1Value = 1/(self.R1Value*pow(10,9));
    } else {
        self.R1Value = 1/(self.R1Value);
    }
    
    // Adjusts R2 Input Values to account for Units (Multiplier) and Divides the adjusted value from 1 to prepare for final calculation
    if (self.R2Multiplier == 0) {
        self.R2Value = 1/(self.R2Value*pow(10,-9));
    } else if (self.R2Multiplier == 1) {
        self.R2Value = 1/(self.R2Value*pow(10,-6));
    } else if (self.R2Multiplier == 2) {
        self.R2Value = 1/(self.R2Value*pow(10,-3));
    } else if (self.R2Multiplier == 4) {
        self.R2Value = 1/(self.R2Value*pow(10,3));
    } else if (self.R2Multiplier == 5) {
        self.R2Value = 1/(self.R2Value*pow(10,6));
    } else if (self.R2Multiplier == 6) {
        self.R2Value = 1/(self.R2Value*pow(10,9));
    } else {
        self.R2Value = 1/(self.R2Value);
    }
    
    // Adjusts R3 Input Values to account for Units (Multiplier) and Divides the adjusted value from 1 to prepare for final calculation
    
    if (self.R3Value != 0) {
        if (self.R3Multiplier == 0) {
            self.R3Value = 1/(self.R3Value*pow(10,-9));
        } else if (self.R3Multiplier == 1) {
            self.R3Value = 1/(self.R3Value*pow(10,-6));
        } else if (self.R3Multiplier == 2) {
            self.R3Value = 1/(self.R3Value*pow(10,-3));
        } else if (self.R3Multiplier == 4) {
            self.R3Value = 1/(self.R3Value*pow(10,3));
        } else if (self.R3Multiplier == 5) {
            self.R3Value = 1/(self.R3Value*pow(10,6));
        } else if (self.R3Multiplier == 6) {
            self.R3Value = 1/(self.R3Value*pow(10,9));
        } else {
            self.R3Value = 1/(self.R3Value);
        }
    }
    
    // Calculates Final Equivalent Resistance of R1, R2, and R3
    
    if (self.R3Value == 0) {
        self.RFinalValue = 1/(self.R1Value + self.R2Value);
    } else {
        self.RFinalValue = 1/(self.R1Value + self.R2Value + self.R3Value);
    }
}

@end
