//
//  ViewController.h
//  BMICalculator
//
//  Created by Austin White on 2/1/14.
//  Copyright (c) 2014 Austin White. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMI.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *txtHeight;
@property (strong, nonatomic) IBOutlet UITextField *txtWeight;
@property (strong, nonatomic) IBOutlet UILabel *expression;
@property (strong, nonatomic) IBOutlet UILabel *bmiDescription, *bmiCalculation;
@property (strong, nonatomic) IBOutlet UIView *expressionView;
@property (strong, nonatomic) IBOutlet UILabel *lblHeight;
@property (strong, nonatomic) IBOutlet UILabel *lblWeight;
@property (strong, nonatomic) BMI *bmiCalc;

- (IBAction)calculate:(id)sender;

- (void)animateExpression;

- (BOOL)textFieldShouldReturn:(UITextField *)textField;

- (void)viewDidLoad;

- (IBAction)unitsChanged:(UISegmentedControl *)sender;



@end
