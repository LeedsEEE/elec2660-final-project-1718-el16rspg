//
//  potDivDataModel.m
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 06/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "potDivDataModel.h"

@implementation potDivDataModel

-(void) calcFinalValue; {

    
    // Adjusts Input1 Values to account for Units (Multiplier)
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
    
    // Adjusts Input2 Values to account for Units (Multiplier)
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
    
    // Adjusts Input3 Values to account for Units (Multiplier)
    if (self.input3Multiplier == 0) {
        self.input3Value = self.input3Value*pow(10,-9);
    } else if (self.input3Multiplier == 1) {
        self.input3Value = self.input3Value*pow(10,-6);
    } else if (self.input3Multiplier == 2) {
        self.input3Value = self.input3Value*pow(10,-3);
    } else if (self.input3Multiplier == 4) {
        self.input3Value = self.input3Value*pow(10,3);
    } else if (self.input3Multiplier == 5) {
        self.input3Value = self.input3Value*pow(10,6);
    } else if (self.input3Multiplier == 6) {
        self.input3Value = self.input3Value*pow(10,9);
    } else {
        self.input3Value = self.input3Value;
    }
    
    
    
    // Table indicating how the Input Values change with different Output Value selections;
    // Component#   Output  Input1  Input2  InputVin3
    //  0           Vout    Vin     R1      R2
    //  1           Vin     Vout    R1      R2
    //  2           R1      Vin     Vout    R2
    //  3           R2      Vin     Vout    R1
    
    
    // Calculates Final Output Value
    if (self.calcType == 0) {   // Calculating Vout
        self.outputValue = self.input1Value * (self.input3Value / (self.input2Value + self.input3Value));
        // Vout = Vin (R2 / (R1 + R2))
    
    } else if (self.calcType == 1) {    // Calculating Vin
        self.outputValue = self.input1Value * ((self.input2Value + self.input3Value) / self.input3Value);
        // Vin = Vout ((R1 + R2) / R2)
    
    } else if (self.calcType == 2) {    // Calculating R1
        self.outputValue = self.input3Value * ((self.input1Value - self.input2Value) / self.input2Value);
        // R1 = R2 ((Vin - Vout) / Vout)
    
    } else {    // Calculating R2
        self.outputValue = self.input3Value * (self.input2Value / (self.input1Value - self.input2Value));
        // R2 = R1 (Vout / (Vin - Vout))
    }
}

@end
