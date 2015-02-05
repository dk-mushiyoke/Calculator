//
//  ViewController.h
//  Calculator
//
//  Created by Di Kong on 1/12/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *display;
@property (weak, nonatomic) IBOutlet UITextField *history;
@property (strong, nonatomic) NSMutableString *disptext;
@property (strong, nonatomic) NSMutableString *histtext;
@property (strong, nonatomic) NSNumberFormatter *nf;
@property (strong, nonatomic) NSNumber *n1, *n2;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic) BOOL floatFlag, equalFlag, divzeroFlag;
@property (nonatomic) int op;

- (IBAction)delButtonPressed:(UIButton *)sender;
- (IBAction)delButtonTouchedTimer:(UIButton *)sender;
- (IBAction)delButtonTouchedCancel:(UIButton *)sender;
- (IBAction)numButtonPressed:(UIButton *)sender;
- (IBAction)opButtonPressed:(UIButton *)sender;
- (IBAction)dotButtonPressed:(UIButton *)sender;
- (IBAction)eqButtonPressed:(UIButton *)sender;

@end

