//
//  CoreCalc.h
//  Calculator
//
//  Created by Di Kong on 1/12/15.
//  Copyright (c) 2015 Software Merchant. All rights reserved.
//

#ifndef Calculator_CoreCalc_h
#define Calculator_CoreCalc_h

@interface CoreCalc : NSObject


- (CoreCalc *) init;
+ (double) doOperation:(double)num1
             operation:(int)op
                  num2:(double)num2;
+ (int) plus;
+ (int) minus;
+ (int) multiply;
+ (int) divide;
+ (int) null;

@end

#endif
