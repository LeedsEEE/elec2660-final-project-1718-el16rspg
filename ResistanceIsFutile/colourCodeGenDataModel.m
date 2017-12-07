//
//  colourCodeGenDataModel.m
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 07/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

/*
 E12 Series	Midpoint		E24 Series	Midpoint
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
 5.6        5.35
 6.2        5.9
 6.8        6.5
 7.5        7.15
 8.2        7.85
 9.1        8.65
 10         9.55
 */

#import "colourCodeGenDataModel.h"

@implementation colourCodeGenDataModel

- (void) calcNPVValue {
    
    self.bandColourArray = [NSArray arrayWithObjects: [UIColor blackColor],[UIColor brownColor],[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor greenColor],[UIColor blueColor],[UIColor magentaColor],[UIColor grayColor],[UIColor colorWithRed:0.99 green:0.76 blue:0.0 alpha:0.9],[UIColor colorWithRed:0.76 green:0.80 blue:0.80 alpha:0.9],[UIColor clearColor],nil];
    
    self.toleranceColourArray = [NSArray arrayWithObjects: [UIColor colorWithRed:0.76 green:0.80 blue:0.80 alpha:0.9], [UIColor yellowColor], [UIColor clearColor],nil];

    // Adjusts inputRValue to account for inputMultiplier Value
    if (self.inputMultiplier == 0) {
        self.inputRValue = self.inputRValue*pow(10,-9);
    } else if (self.inputMultiplier == 1) {
        self.inputRValue = self.inputRValue*pow(10,-6);
    } else if (self.inputMultiplier == 2) {
        self.inputRValue = self.inputRValue*pow(10,-3);
    } else if (self.inputMultiplier == 4) {
        self.inputRValue = self.inputRValue*pow(10,3);
    } else if (self.inputMultiplier == 5) {
        self.inputRValue = self.inputRValue*pow(10,6);
    } else if (self.inputMultiplier == 6) {
        self.inputRValue = self.inputRValue*pow(10,9);
    } else {
        self.inputRValue = self.inputRValue;
    }
    
    // Counting inputDigitsLength (Number of Digits) in inputRValue
    self.inputDigitsLength = floor( log10( self.inputRValue ) ) + 1;
    
    // Truncating inputR to float value between 0 and 10
    self.sigInputRValue = self.inputRValue / pow(10,self.inputDigitsLength-1);
    
    // Setting outputMultiplier power value
    self.outputMultiplier = self.inputDigitsLength-1;
    
    if (self.inputRValue == 0.0) {
        self.outputNpvRValue = 0.0;
        self.outputMultiplier = 0;
        
    } else {  // i.e. if self.inputRValue != 0
        
        if (self.inputTolerance == 0) {
            if (self.sigInputRValue <= 1.1) {
                self.outputNpvRValue = 1.0;
            } else if (self.sigInputRValue <= 1.35) {
                self.outputNpvRValue = 1.2;
            } else if (self.sigInputRValue <= 1.65) {
                self.outputNpvRValue = 1.5;
            } else if (self.sigInputRValue <= 2.0) {
                self.outputNpvRValue = 1.8;
            } else if (self.sigInputRValue <= 2.45) {
                self.outputNpvRValue = 2.2;
            } else if (self.sigInputRValue <= 3.0) {
                self.outputNpvRValue = 2.7;
            } else if (self.sigInputRValue <= 3.6) {
                self.outputNpvRValue = 3.3;
            } else if (self.sigInputRValue <= 4.3) {
                self.outputNpvRValue = 3.9;
            } else if (self.sigInputRValue <= 5.15) {
                self.outputNpvRValue = 4.7;
            } else if (self.sigInputRValue <= 6.2) {
                self.outputNpvRValue = 5.6;
            } else if (self.sigInputRValue <= 7.5) {
                self.outputNpvRValue = 6.8;
            } else if (self.sigInputRValue <= 9.1) {
                self.outputNpvRValue = 8.2;
            } else {
                self.outputNpvRValue = 1.0;
                self.outputMultiplier = self.outputMultiplier + 1;
            }
            
        } else {
            if (self.sigInputRValue <= 1.05) {
                self.outputNpvRValue = 1.0;
            } else if (self.sigInputRValue <= 1.15) {
                self.outputNpvRValue = 1.1;
            } else if (self.sigInputRValue <= 1.25) {
                self.outputNpvRValue = 1.2;
            } else if (self.sigInputRValue <= 1.4) {
                self.outputNpvRValue = 1.3;
            } else if (self.sigInputRValue <= 1.55) {
                self.outputNpvRValue = 1.5;
            } else if (self.sigInputRValue <= 1.7) {
                self.outputNpvRValue = 1.6;
            } else if (self.sigInputRValue <= 1.9) {
                self.outputNpvRValue = 1.8;
            } else if (self.sigInputRValue <= 2.1) {
                self.outputNpvRValue = 2.0;
            } else if (self.sigInputRValue <= 2.3) {
                self.outputNpvRValue = 2.2;
            } else if (self.sigInputRValue <= 2.55) {
                self.outputNpvRValue = 2.4;
            } else if (self.sigInputRValue <= 2.85) {
                self.outputNpvRValue = 2.7;
            } else if (self.sigInputRValue <= 3.15) {
                self.outputNpvRValue = 3.0;
            } else if (self.sigInputRValue <= 3.45) {
                self.outputNpvRValue = 3.3;
            } else if (self.sigInputRValue <= 3.75) {
                self.outputNpvRValue = 3.6;
            } else if (self.sigInputRValue <= 4.1) {
                self.outputNpvRValue = 3.9;
            } else if (self.sigInputRValue <= 4.5) {
                self.outputNpvRValue = 4.3;
            } else if (self.sigInputRValue <= 4.9) {
                self.outputNpvRValue = 4.7;
            } else if (self.sigInputRValue <= 5.35) {
                self.outputNpvRValue = 5.1;
            } else if (self.sigInputRValue <= 5.9) {
                self.outputNpvRValue = 5.6;
            } else if (self.sigInputRValue <= 6.5) {
                self.outputNpvRValue = 6.2;
            } else if (self.sigInputRValue <= 7.15) {
                self.outputNpvRValue = 6.8;
            } else if (self.sigInputRValue <= 7.85) {
                self.outputNpvRValue = 7.5;
            } else if (self.sigInputRValue <= 8.65) {
                self.outputNpvRValue = 8.2;
            } else if (self.sigInputRValue <= 9.55) {
                self.outputNpvRValue = 9.1;
            } else {
                self.outputNpvRValue = 1.0;
                self.outputMultiplier = self.outputMultiplier + 1;
            }
        }
    }
    
    
    // Converting float to 2 digit int = (int)(outputNpvRValue*10);
    self.firstSigDig = ((int)(self.outputNpvRValue*10)) / 10;
    self.secondSigDig = ((int)(self.outputNpvRValue*10)) - (self.firstSigDig*10);
    
}

@end
