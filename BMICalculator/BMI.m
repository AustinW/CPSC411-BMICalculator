//
//  BMI.m
//  BMICalculator
//
//  Created by Austin White on 2/1/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "BMI.h"
#import <FontAwesomeKit/FontAwesomeKit.h>

@implementation BMI

@synthesize height, weight, metric;

- (NSDecimalNumber*)calculate
{
    [self convertToMetric];
    
    return [self.weight decimalNumberByDividingBy:[self.height decimalNumberByMultiplyingBy:self.height]];
}

- (void)convertToMetric
{
    if ( ! self.metric) {
        
        self.height = [BMI convertHeight:self.height toMetric:YES];
        
        self.weight = [BMI convertWeight:self.weight toMetric:YES];
        
        self.metric = YES;
    }
}

+ (NSAttributedString*)expressionFromBMI:(NSString*)description
{
    FAKFontAwesome *smileIcon = [FAKFontAwesome smileOIconWithSize:100];
    FAKFontAwesome *frownIcon = [FAKFontAwesome frownOIconWithSize:100];
    
    NSAttributedString *smileIconText = [smileIcon attributedString];
    NSAttributedString *frownIconText = [frownIcon attributedString];
    
    NSDictionary *expressions = @{
                                  @"Severe thinness": frownIconText,
                                  @"Moderate thinness": frownIconText,
                                  @"Mild thinness": smileIconText,
                                  @"Normal range": smileIconText,
                                  @"Overweight": frownIconText,
                                  @"Obese class I (Moderate)": frownIconText,
                                  @"Obese class II (Severe)": frownIconText,
                                  @"Obese class III (Very Severe)": frownIconText
                                  };
    
    
//    NSDictionary *expressions = @{
//        @"Severe thinness": @"😳",
//        @"Moderate thinness": @"😔",
//        @"Mild thinness": @"😄",
//        @"Normal range": @"😄",
//        @"Overweight": @"😔",
//        @"Obese class I (Moderate)": @"😔",
//        @"Obese class II (Severe)": @"😣",
//        @"Obese class III (Very Severe)": @"😳"
//    };
    
    return [expressions objectForKey:description];
}

+ (NSString*)descriptionFromBMI:(NSDecimalNumber*)bmi
{
    double bmiVal = [bmi doubleValue];
    
    if (bmiVal < 16.0) {
        return @"Severe thinness";
    } else if (bmiVal < 16.99) {
        return @"Moderate thinness";
    } else if (bmiVal < 18.49) {
        return @"Mild thinness";
    } else if (bmiVal < 24.99) {
        return @"Normal range";
    } else if (bmiVal < 29.99) {
        return @"Overweight";
    } else if (bmiVal < 34.99) {
        return @"Obese class I (Moderate)";
    } else if (bmiVal < 39.99) {
        return @"Obese class II (Severe)";
    } else {
        return @"Obese class III (Very Severe)";
    }
}

- (NSDecimalNumber*)description
{
    return [self calculate];
}

+ (NSDecimalNumber*)convertHeight:(NSDecimalNumber*)height toMetric:(BOOL)metric
{
    NSDecimalNumber *inchesToMeters = [NSDecimalNumber decimalNumberWithString:@"0.0254"];
    
    if (metric) {
        return [height decimalNumberByMultiplyingBy:inchesToMeters];
    } else {
        return [height decimalNumberByDividingBy:inchesToMeters];
    }
}

+ (NSDecimalNumber*)convertWeight:(NSDecimalNumber*)weight toMetric:(BOOL)metric
{
    NSDecimalNumber *poundsToKilograms = [NSDecimalNumber decimalNumberWithString:@"0.453592"];
    
    if (metric) {
        return [weight decimalNumberByMultiplyingBy:poundsToKilograms];
    } else {
        return [weight decimalNumberByDividingBy:poundsToKilograms];
    }
}

@end
