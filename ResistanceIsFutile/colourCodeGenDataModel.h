//
//  colourCodeGenDataModel.h
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 07/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface colourCodeGenDataModel : NSObject

@property double inputRValue;
@property int inputMultiplier;
@property int inputTolerance;
@property int inputDigitsLength;
@property double sigInputRValue;
@property double outputNpvRValue;
@property double finalRValue;
@property int outputMultiplier;
@property int firstSigDig;
@property int secondSigDig;

@property (nonatomic, strong) NSArray *bandColourArray;
@property (nonatomic, strong) NSArray *bandTextArray;


-(void) calcNPVValue; // Method to calculate output value

@end
