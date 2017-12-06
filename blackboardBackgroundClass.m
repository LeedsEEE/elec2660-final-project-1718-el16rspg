//
//  blackboardBackgroundClass.m
//  ResistanceIsFutile
//
//  Created by Rohan Garg on 06/12/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "blackboardBackgroundClass.h"

@implementation blackboardBackgroundClass

- (void) setBackground {
    UIImage *bgImage = [UIImage imageNamed:@"blackboard 16_9.png"];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIGraphicsBeginImageContextWithOptions(screenSize, NO, 0.f);
    [bgImage drawInRect:CGRectMake(0.f, 0.f, screenSize.width, screenSize.height)];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIColor *backgroundColor = [UIColor colorWithPatternImage:resultImage];
    self.view.backgroundColor = backgroundColor;
}

@end
