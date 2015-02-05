//
//  ViewController.m
//  Calculator
//
//  Created by Di Kong on 1/12/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import "ViewController.h"
#import "CoreCalc.h"

@interface ViewController ()

// class extensions
- (void)displayMsg:(NSString *)msg;
- (void)updateDisplay;
- (void)updateHistory;
- (void)clearDisplay;
- (void)clearHistory;
- (void)clearAll;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _timer = [[NSTimer alloc] init];
    _nf = [[NSNumberFormatter alloc] init];
    [_nf setMinimumFractionDigits:0];
    [_nf setMaximumFractionDigits:9];
    [_nf setMinimumIntegerDigits:1];
    [self clearAll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)delButtonPressed:(UIButton *)sender {
    // invalidate timer for holding delete button b/c released
    [_timer invalidate];
    if(_divzeroFlag) {
        return;
    }
    // remove last char
    char lastch = [_disptext characterAtIndex:[_disptext length] - 1];
    // if last char is decimal point reset floatFlag
    [_disptext deleteCharactersInRange:NSMakeRange([_disptext length] - 1, 1)];
    if(_floatFlag && lastch == '.')
        _floatFlag = NO;
    // put in 0 for empty result
    if([_disptext isEqual:@""])
        [_disptext setString:@"0"];
    [self updateDisplay];
}

- (IBAction)delButtonTouchedCancel:(UIButton *)sender {
    // invalidate timer for holding delete button b/c canceled
    [_timer invalidate];
}

- (IBAction)delButtonTouchedTimer:(UIButton *)sender {
    // start timer for holding delete button
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(clearAll) userInfo:nil repeats:NO];
}

- (IBAction)numButtonPressed:(UIButton *)sender {
    if(_divzeroFlag) {
        return;
    }
    // get button text
    NSString *in = [sender titleForState:UIControlStateNormal];
    // clear stuff right after equal button is pressed
    if(_equalFlag) {
        _equalFlag = NO;
        [self clearDisplay];
        [self clearHistory];
    }
    // display the button text
    if([_disptext isEqual:@"0"]) {
        [_disptext setString:in];
    }
    else {
        [_disptext appendString:in];
    }
    [self updateDisplay];
}

- (IBAction)opButtonPressed:(UIButton *)sender {
    if(_divzeroFlag) {
        return;
    }
    // get button text
    NSString *in = [sender titleForState:UIControlStateNormal];    // store current number to n1
    _n1 = [NSNumber numberWithDouble:[_disptext doubleValue]];
    // if immediately pressed after equal clear history
    if(_equalFlag) {
        _equalFlag = NO;
        [self clearHistory];
    }
    // add n1 and op to history
    [_histtext appendFormat:@"%@ %@ ", _disptext, in];
    [self clearDisplay];
    [self updateHistory];
    // determine the operation
    if([in isEqual:@"+"])
        _op = [CoreCalc plus];
    else if([in isEqual:@"-"])
        _op = [CoreCalc minus];
    else if([in isEqual:@"*"])
        _op = [CoreCalc multiply];
    else
        _op = [CoreCalc divide];
}

- (IBAction)dotButtonPressed:(UIButton *)sender {
    if(_divzeroFlag) {
        return;
    }
    // if immediately pressed after equal clear stuff
    if(_equalFlag) {
        _equalFlag = NO;
        [self clearDisplay];
        [self clearHistory];
    }
    // put in decimal point according to floatFlag
    if(!_floatFlag) {
        _floatFlag = YES;
        [_disptext appendString:@"."];
        [self updateDisplay];
    }
}

- (IBAction)eqButtonPressed:(UIButton *)sender {
    if(_divzeroFlag) {
        return;
    }
    // if immediately pressed after equal clear history and append
    if(_equalFlag) {
        [self clearHistory];
        [_histtext appendFormat:@"%@ =", _disptext];
    }
    // otherwise append text and set flag
    else {
        [_histtext appendFormat:@"%@ =", _disptext];
        _equalFlag = YES;
    }
    [self updateHistory];
    // store current number in n2
    _n2 = [NSNumber numberWithDouble:[_disptext doubleValue]];
    // result that should be displayed
    NSNumber *result = _n2;
    // if n1 and an operation is present then do operation
    // otherwise display value of n2
    if(_n1 != nil)
        result = [NSNumber numberWithDouble:[CoreCalc doOperation:[_n1 doubleValue] operation:_op num2:[_n2 doubleValue]]];
    // div by zero?
    if([_n2 doubleValue] == 0 && _op == [CoreCalc divide]) {
        _divzeroFlag = YES;
        [self displayMsg:@"DIVIDED BY 0"];
    }
    // setup display for non div-by-zero operations
    else {
        _disptext = [NSMutableString stringWithString:[_nf stringFromNumber:result]];
        [self updateDisplay];
    }
    _n1 = nil;
    _op = [CoreCalc null];
}

- (void)displayMsg:(NSString *)msg {
    _disptext = [NSMutableString stringWithString:msg];
    [self updateDisplay];
}

- (void)updateDisplay {
    _display.text = _disptext;
}

- (void)updateHistory {
    _history.text = _histtext;
}


- (void)clearDisplay {
    _disptext = [NSMutableString stringWithString:@"0"];
    _floatFlag = NO;
    _display.text = @"0";
}

- (void)clearHistory {
    _histtext = [NSMutableString stringWithString:@""];
    _history.text = @"";
}

- (void)clearAll {
    [self clearDisplay];
    [self clearHistory];
    _equalFlag = NO;
    _divzeroFlag = NO;
    _n1 = nil;
    _n2 = nil;
    _op = [CoreCalc null];
}

@end
