//
//  seriesRDataModel.h
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 03/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//
//  Data Model Class to Calculate the Series Equivalent Resistance of 3 Resistors

#import <Foundation/Foundation.h>

@interface seriesRDataModel : NSObject

@property double R1Value;
@property double R2Value;
@property double R3Value;
@property double R1Multiplier;
@property double R2Multiplier;
@property double R3Multiplier;
@property double RFinalValue;

-(void) calcRFinalValue; // Method to calculate equivalent resistance


@end
