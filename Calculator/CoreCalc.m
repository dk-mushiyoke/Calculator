//
//  CoreCalc.m
//  Calculator
//
//  Created by Di Kong on 1/12/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreCalc.h"

static const int NUL=0,PLU=1,MIN=2,MUL=3,DIV=4;

@interface CoreCalc ()

@end

@implementation CoreCalc

- (CoreCalc *) init {
    self = [super init];
    if(self) {}
    return self;
}

+ (double) doOperation:(double)num1
             operation:(int)op
                  num2:(double)num2
{
    double retVal = 0;
    switch (op) {
        case PLU:
            retVal = num1 + num2;
            break;
        case MIN:
            retVal = num1 - num2;
            break;
        case MUL:
            retVal = num1 * num2;
            break;
        case DIV:
            retVal = num1 / num2;
            break;
        default:
            break;
    }
    return retVal;
}

+ (int) plus { return PLU; }

+ (int) minus { return MIN; }

+ (int) multiply { return MUL; }

+ (int) divide { return DIV; }

+ (int) null { return NUL; }

@end
