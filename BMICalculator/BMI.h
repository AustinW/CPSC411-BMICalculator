//
//  BMI.h
//  BMICalculator
//
//  Created by Austin White on 2/1/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMI : NSObject

@property (strong, nonatomic)NSDecimalNumber *height, *weight;

@property BOOL metric;

- (NSDecimalNumber*)calculate;

- (void)convertToMetric;

+ (NSString*)descriptionFromBMI:(NSDecimalNumber*)bmi;

+ (NSString*)expressionFromBMI:(NSString*)description;

+ (NSDecimalNumber*)convertHeight:(NSDecimalNumber*)height toMetric:(BOOL)metric;

+ (NSDecimalNumber*)convertWeight:(NSDecimalNumber*)weight toMetric:(BOOL)metric;

@end
