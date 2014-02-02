//
//  ViewController.m
//  BMICalculator
//
//  Created by Austin White on 2/1/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import "ViewController.h"
#import "BMI.h"
#import <QuartzCore/QuartzCore.h>

@implementation ViewController

@synthesize txtHeight, txtWeight, expression, bmiDescription, bmiCalculation, bmiCalc, lblHeight, lblWeight, expressionView;

- (BMI*)bmiCalc
{
    if (bmiCalc == nil)
        bmiCalc = [[BMI alloc] init];
    
    return bmiCalc;
}

- (IBAction)calculate:(id)sender {
    
    if ([self.txtHeight.text isEqualToString:@""]) self.txtHeight.text = @"0";
    if ([self.txtWeight.text isEqualToString:@""]) self.txtWeight.text = @"0";
    
    NSDecimalNumber *height = [NSDecimalNumber decimalNumberWithString:self.txtHeight.text];
    NSDecimalNumber *weight = [NSDecimalNumber decimalNumberWithString:self.txtWeight.text];
    
    if ( ! [height isEqualToNumber:@0.0] && ! [weight isEqualToNumber:@0.0]) {
        self.bmiCalc.height = height;
        self.bmiCalc.weight = weight;
        
        NSDecimalNumber *bmi = [self.bmiCalc calculate], *roundedBmi;
        
        NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSDecimalNoScale scale:2 raiseOnExactness:YES raiseOnOverflow:YES raiseOnUnderflow:YES raiseOnDivideByZero:YES];
        
        roundedBmi = [bmi decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
        
        NSString *bmiOutcome = [BMI descriptionFromBMI:bmi];
        
        bmiDescription.text = [NSString stringWithFormat:@"%@", bmiOutcome];
        bmiCalculation.text = [NSString stringWithFormat:@"%@", roundedBmi];
        expression.text = [BMI expressionFromBMI:bmiOutcome];
        
        [self animateExpression];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"BMI Calculator Error" message: @"Please enter values for both height and weight" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
        [self.txtHeight becomeFirstResponder];
    }
}

- (void)animateExpression
{
    // Animation code from: http://www.developers-life.com/spin-ui-object-animation-rotate-360-degree.html
    CABasicAnimation *fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    fullRotation.fromValue = [NSNumber numberWithFloat:0];
    fullRotation.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
    fullRotation.duration = 1;
    fullRotation.repeatCount = 1;
    
    [expressionView.layer addAnimation:fullRotation forKey:@"360"];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.txtHeight) {
        [self.txtWeight becomeFirstResponder];
    } else if (textField == self.txtWeight) {
        [textField resignFirstResponder];
        [self calculate:nil];
    }
    
    return YES;
}

- (void)viewDidLoad
{
    [txtHeight setDelegate:(id)self];
    [txtWeight setDelegate:(id)self];
}

- (IBAction)unitsChanged:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex] == 0) {
        self.bmiCalc.metric = NO;
        
        lblHeight.text = @"in";
        lblWeight.text = @"lbs";
    } else {
        self.bmiCalc.metric = YES;
        
        lblHeight.text = @"m";
        lblWeight.text = @"kg";
    }
    
    NSDecimalNumber *convertedHeight = [BMI convertHeight:[NSDecimalNumber decimalNumberWithString:txtHeight.text] toMetric:self.bmiCalc.metric];
    NSDecimalNumber *convertedWeight = [BMI convertWeight:[NSDecimalNumber decimalNumberWithString:txtWeight.text] toMetric:self.bmiCalc.metric];
    
    txtHeight.text = [NSString stringWithFormat:@"%@", convertedHeight];
    txtWeight.text = [NSString stringWithFormat:@"%@", convertedWeight];
}


@end
