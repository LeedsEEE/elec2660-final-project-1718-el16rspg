//
//  parallelRDataModel.h
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 04/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//
//  Data Model Class of Parallel Resistance Calculator

#import <Foundation/Foundation.h>

@interface parallelRDataModel : NSObject

// Used to store values entered by User in Text Fields on the calculator's view controller
@property double R1Value;
@property double R2Value;
@property double R3Value;

// Used to store values entered by User in Picker on the calculator's view controller
@property double R1Multiplier;
@property double R2Multiplier;
@property double R3Multiplier;

@property double RFinalValue;


// Method to calculate Final Parallel Series Resistance of R1, R2, and R3
-(void) calcRFinalValue;


@end
