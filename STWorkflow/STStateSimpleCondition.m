//
//  STStateSimpleCondition.m
//  STWorkflow
//
//  Created by Thomas Dupont on 02/08/13.

/***********************************************************************************
 *
 * Copyright (c) 2013 Thomas Dupont
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NON INFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 ***********************************************************************************/

#import "STStateSimpleCondition.h"
#import "STState_private.h"

@implementation STStateSimpleCondition

#pragma mark - Public methods

- (void)resumeWithSuccess:(BOOL)success
{
    if (self.isFinalState)
    {
        [self.container finalStateReached];
    }
    else
    {
        if (success)
        {
            [self.container execute:self.successState];
        }
        else
        {
            [self.container execute:self.failureState];
        }
    }
}

#pragma mark - STState methods

- (void)execute
{
    if (self.asyncCondition)
    {
        self.asyncCondition(self);
    }
    else if (self.condition)
    {
        BOOL success = self.condition();
        [self resumeWithSuccess:success];
    }
    else
    {
        [self.container finalStateReached];
    }
}

- (STState*)stateNamed:(NSString*)name
{
    if ([self.name isEqualToString:name])
    {
        return self;
    }
    else
    {
        STState* state = [self.successState stateNamed:name];
        if (!state)
        {
            state = [self.failureState stateNamed:name];
        }
        return state;
    }
}

- (NSString*)descriptionWithShift:(NSString*)shift prefix:(NSString*)prefix siblingPrefix:(NSString*)siblingPrefix
{
    NSMutableString* string = [[NSMutableString alloc] initWithFormat:@"%@%@%@ (S)", shift, prefix, self.name];
    
    if (!self.isFinalState && [self.container shouldDescribeNextStatesOfState:self])
    {
        [string appendString:@"\n"];
        [string appendString:[self.successState descriptionWithShift:[shift stringByAppendingString:siblingPrefix] prefix:@"Y- " siblingPrefix:@"|  "]?:@""];
        [string appendString:[self.failureState descriptionWithShift:[shift stringByAppendingString:siblingPrefix] prefix:@"N- " siblingPrefix:@"|  "]?:@""];
    }
    else
    {
        if (self.isFinalState)
        {
            [string appendString:@" !\n"];
        }
        else
        {
            [string appendString:@" *\n"];
        }
    }
    
    return string;
}

@end
