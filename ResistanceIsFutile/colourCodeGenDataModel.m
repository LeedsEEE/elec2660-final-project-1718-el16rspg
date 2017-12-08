//
//  colourCodeGenDataModel.m
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 07/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//
//  Data Model Class to perform NPV & Colour Code Calculations

#import "colourCodeGenDataModel.h"

@implementation colourCodeGenDataModel

- (void) calcNPVValue {
    
    // Array Containing All Band Colours (as Objects)
    // Source: ELEC2660 Lab 4 - File:Resistor.m (bandColourArray)
    self.bandColourArray = [NSArray arrayWithObjects: [UIColor blackColor],[UIColor brownColor],[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor],[UIColor magentaColor],[UIColor grayColor],[UIColor whiteColor],
        [UIColor colorWithRed:0.99 green:0.76 blue:0.0 alpha:0.9],  // Gold
        [UIColor colorWithRed:0.76 green:0.80 blue:0.80 alpha:0.9], // Silver
        nil];
    
    // Array Containing All Band Colour Texts
    self.bandTextArray = @[@"Black", @"Brown" , @"Red", @"Orange", @"Yellow", @"Green", @"Blue", @"Violet", @"Gray", @"White", @"Gold", @"Silver", @" "];

    // Adjusts inputRValue to account for inputMultiplier Value
    if (self.inputMultiplier == 0) {
        self.inputRValue = self.inputRValue;
    } else if (self.inputMultiplier == 1) {
        self.inputRValue = self.inputRValue*pow(10,3);
    } else {
        self.inputRValue = self.inputRValue*pow(10,6);
    }
    
    // Counting inputDigitsLength (Number of Digits) in inputRValue
    self.inputDigitsLength = floor(log10(self.inputRValue)) + 1;
    
    // Setting outputMultiplier Power value
    self.outputMultiplier = self.inputDigitsLength-2;
    
    // Truncating inputR to float value between 0 and 100
    self.sigInputRValue = self.inputRValue / pow(10,self.outputMultiplier);
    
    // Accounting for Invalid Input from User when inputRValue = 0 or blank by setting outputNpvRValue and outputMultiplier to 0;
    if (self.inputRValue == 0.0) {
        self.outputNpvRValue = 0.0;
        self.outputMultiplier = 0;
        
    // ELSE, if self.inputRValue != 0
    // Compares sigInputRValue to a list of Midpoints between 2 NPV Values to assign the nearest outputNpvRValue; Refer to SERIES & MIDPOINTS comment just before @end (scroll down);
    } else {    // E12 Series
        if (self.inputTolerance == 0) {
            if (self.sigInputRValue <= 11) {
                self.outputNpvRValue = 10;
            } else if (self.sigInputRValue <= 13.5) {
                self.outputNpvRValue = 12;
            } else if (self.sigInputRValue <= 16.5) {
                self.outputNpvRValue = 15;
            } else if (self.sigInputRValue <= 20) {
                self.outputNpvRValue = 18;
            } else if (self.sigInputRValue <= 24.5) {
                self.outputNpvRValue = 22;
            } else if (self.sigInputRValue <= 30) {
                self.outputNpvRValue = 27;
            } else if (self.sigInputRValue <= 36) {
                self.outputNpvRValue = 33;
            } else if (self.sigInputRValue <= 43) {
                self.outputNpvRValue = 39;
            } else if (self.sigInputRValue <= 51.5) {
                self.outputNpvRValue = 47;
            } else if (self.sigInputRValue <= 62) {
                self.outputNpvRValue = 56;
            } else if (self.sigInputRValue <= 75) {
                self.outputNpvRValue = 68;
            } else if (self.sigInputRValue <= 91) {
                self.outputNpvRValue = 82;
            } else {    // if outputNpvRValue = 100, then truncate it to 10 and add 1 to outputMultiplier (e.g. 100x10^2 = 10x10^3)
                self.outputNpvRValue = 10;
                self.outputMultiplier = self.outputMultiplier + 1;
            }
        } else {    // E24 Series
            if (self.sigInputRValue <= 10.5) {
                self.outputNpvRValue = 10;
            } else if (self.sigInputRValue <= 11.5) {
                self.outputNpvRValue = 11;
            } else if (self.sigInputRValue <= 12.5) {
                self.outputNpvRValue = 12;
            } else if (self.sigInputRValue <= 14) {
                self.outputNpvRValue = 13;
            } else if (self.sigInputRValue <= 15.5) {
                self.outputNpvRValue = 15;
            } else if (self.sigInputRValue <= 17) {
                self.outputNpvRValue = 16;
            } else if (self.sigInputRValue <= 19) {
                self.outputNpvRValue = 18;
            } else if (self.sigInputRValue <= 21) {
                self.outputNpvRValue = 20;
            } else if (self.sigInputRValue <= 23) {
                self.outputNpvRValue = 22;
            } else if (self.sigInputRValue <= 25.5) {
                self.outputNpvRValue = 24;
            } else if (self.sigInputRValue <= 28.5) {
                self.outputNpvRValue = 27;
            } else if (self.sigInputRValue <= 31.5) {
                self.outputNpvRValue = 30;
            } else if (self.sigInputRValue <= 34.5) {
                self.outputNpvRValue = 33;
            } else if (self.sigInputRValue <= 37.5) {
                self.outputNpvRValue = 36;
            } else if (self.sigInputRValue <= 41) {
                self.outputNpvRValue = 39;
            } else if (self.sigInputRValue <= 45) {
                self.outputNpvRValue = 43;
            } else if (self.sigInputRValue <= 49) {
                self.outputNpvRValue = 47;
            } else if (self.sigInputRValue <= 53.5) {
                self.outputNpvRValue = 51;
            } else if (self.sigInputRValue <= 59) {
                self.outputNpvRValue = 56;
            } else if (self.sigInputRValue <= 65) {
                self.outputNpvRValue = 62;
            } else if (self.sigInputRValue <= 71.5) {
                self.outputNpvRValue = 68;
            } else if (self.sigInputRValue <= 78.5) {
                self.outputNpvRValue = 75;
            } else if (self.sigInputRValue <= 86.5) {
                self.outputNpvRValue = 82;
            } else if (self.sigInputRValue <= 95.5) {
                self.outputNpvRValue = 91;
            } else {    // if outputNpvRValue = 100, then truncate it to 10 and add 1 to outputMultiplier (e.g. 100x10^2 = 10x10^3)
                self.outputNpvRValue = 10;
                self.outputMultiplier = self.outputMultiplier + 1;
            }
        }
    }
    
    // Converting float to 2 digit int = (int)(outputNpvRValue);
    self.firstSigDig = ((int)(self.outputNpvRValue)) / 10;
    self.secondSigDig = ((int)(self.outputNpvRValue)) - (self.firstSigDig*10);
    
    // Calculating final R value to be displayed on output Label
    self.finalRValue = self.outputNpvRValue*pow(10,self.outputMultiplier);
    
}

/*  SERIES & MIDPOINTS
The values used above are the same as below but times 10;
Source: https://www.electronics-notes.com/articles/electronic_components/resistors/standard-resistor-values-e-series-e3-e6-e12-e24-e48-e96.php

 E12        Midpoint		E24         Midpoint
 1                          1
 1.2        1.1             1.1         1.05
 1.5        1.35            1.2         1.15
 1.8        1.65            1.3         1.25
 2.2        2               1.5         1.4
 2.7        2.45            1.6         1.55
 3.3        3               1.8         1.7
 3.9        3.6             2           1.9
 4.7        4.3             2.2         2.1
 5.6        5.15            2.4         2.3
 6.8        6.2             2.7         2.55
 8.2        7.5             3           2.85
 10         9.1             3.3         3.15
 3.6        3.45
 3.9        3.75
 4.3        4.1
 4.7        4.5
 5.1        4.9
 6.2        5.9
 6.8        6.5
 7.5        7.15
 8.2        7.85
 9.1        8.65
 10         9.55
 */


@end
