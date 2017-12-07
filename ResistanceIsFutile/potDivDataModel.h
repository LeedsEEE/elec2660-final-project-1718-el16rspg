//
//  potDivDataModel.h
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 06/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface potDivDataModel : NSObject

@property double calcType;
@property double input1Value;
@property double input2Value;
@property double input3Value;
@property double input1Multiplier;
@property double input2Multiplier;
@property double input3Multiplier;
@property double outputValue;

-(void) calcFinalValue; // Method to calculate output value

@end
