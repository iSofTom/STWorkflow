//
//  STWorkflow+Debug.m
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

#import "STWorkflow+Debug.h"

#import "STWorkflow_private.h"
#import "STState_private.h"

@implementation STWorkflow (Debug)

- (NSString*)currentStateName
{
    return [self.currentState name];
}

- (STState*)startState
{
    return self.firstState;
}

- (STState*)stateNamed:(NSString*)name
{
    return [self.firstState stateNamed:name];
}

@end

@implementation STState (Debug)

- (BOOL)isNamed:(NSString*)name
{
    return [self.name isEqualToString:name];
}

- (BOOL)isSimpleCondition
{
    return [self isKindOfClass:[STStateSimpleCondition class]];
}

- (BOOL)isMultipleCondition
{
    return [self isKindOfClass:[STStateMultipleCondition class]];
}

- (BOOL)isAction
{
    return [self isKindOfClass:[STStateAction class]];
}

- (BOOL)isDispatch
{
    return [self isKindOfClass:[STStateDispatch class]];
}

@end
