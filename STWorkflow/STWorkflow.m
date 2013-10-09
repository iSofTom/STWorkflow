//
//  STWorkflow.m
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

#import "STWorkflow.h"
#import "STWorkflow_private.h"

#import "STState_private.h"

@implementation STWorkflow

- (id)init
{
    self = [super init];
    if (self)
    {
        self.states = [[NSMutableSet alloc] init];
    }
    return self;
}

#pragma mark - Public methods

- (void)start
{
    if (!self.running)
    {
        self.running = YES;
        [self execute:self.firstState];
    }
}

- (void)pause
{
    if (self.running)
    {
        self.running = NO;
    }
}

- (void)resume
{
    if (!self.running && self.currentState)
    {
        self.running = YES;
        [self execute:self.currentState];
    }
}

#pragma mark - Factory

- (STStateSimpleCondition*)createSimpleConditionNamed:(NSString*)name
{
    STStateSimpleCondition* state = [STStateSimpleCondition stateNamed:name];
    [self addState:state];
    return state;
}

- (STStateMultipleCondition*)createMultipleConditionNamed:(NSString*)name
{
    STStateMultipleCondition* state = [STStateMultipleCondition stateNamed:name];
    [self addState:state];
    return state;
}

- (STStateAction*)createActionNamed:(NSString*)name
{
    STStateAction* state = [STStateAction stateNamed:name];
    [self addState:state];
    return state;
}

- (STStateDispatch*)createDispatchNamed:(NSString*)name
{
    STStateDispatch* state = [STStateDispatch stateNamed:name];
    [self addState:state];
    return state;
}

#pragma mark - Container

- (void)execute:(STState*)state
{
    if (!state)
    {
        [NSException raise:@"STWorkflowException" format:@"Try to execute a nil state"];
    }
    
    self.currentState = state;
    if (self.running)
    {
        [state execute];
    }
}

- (void)finalStateReached
{
    self.currentState = nil;
    self.running = NO;
}

- (BOOL)shouldDescribeNextStatesOfState:(STState*)state
{
    BOOL contains = [self.describedStates containsObject:state];
    [self.describedStates addObject:state];
    return !contains;
}

#pragma mark - Private methods

- (void)addState:(STState*)state
{
    if (!self.firstState)
    {
        self.firstState = state;
    }
    
    [state setContainer:self];
    [self.states addObject:state];
}

- (NSString *)description
{
    self.describedStates = [[NSMutableSet alloc] init];
    
    NSString* string = [NSString stringWithFormat:@"\n%@",[self.firstState descriptionWithShift:@"" prefix:@"" siblingPrefix:@""]];
    
    self.describedStates = nil;
    
    return string;
}

@end
