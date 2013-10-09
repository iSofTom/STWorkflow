//
//  STStateDispatch.m
//  STWorkflow
//
//  Created by Thomas Dupont on 08/10/13.

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

#import "STStateDispatch.h"
#import "STState_private.h"
#import "STStateContainer.h"

#import "STStateSimpleCondition.h"
#import "STStateMultipleCondition.h"
#import "STStateAction.h"

@interface STStateDispatch () <STStateContainer>

@property (nonatomic, strong) NSMutableArray* states;
@property (nonatomic, assign) NSInteger numberOfFinalStateReached;

@end

@implementation STStateDispatch

- (id)init
{
    self = [super init];
    if (self)
    {
        self.states = [[NSMutableArray alloc] init];
    }
    return self;
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
    
    [state setContainer:self];
    [state execute];
}

- (void)finalStateReached
{
    self.numberOfFinalStateReached++;
    
    if ([self.states count] == self.numberOfFinalStateReached)
    {
        [self executeNextState];
    }
}

- (BOOL)shouldDescribeNextStatesOfState:(STState*)state
{
    return [self.container shouldDescribeNextStatesOfState:state];
}

#pragma mark - STState

- (void)execute
{
    self.numberOfFinalStateReached = 0;
    
    if ([self.states count] == 0)
    {
        [self executeNextState];
    }
    
    for (STState* state in self.states)
    {
        [state execute];
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
        STState* state = nil;
        for (STState* s in self.states)
        {
            state = [s stateNamed:name];
            if (state)
            {
                break;
            }
        }
        return state;
    }
}

- (NSString*)descriptionWithShift:(NSString*)shift prefix:(NSString*)prefix siblingPrefix:(NSString*)siblingPrefix
{
    NSMutableString* string = [[NSMutableString alloc] initWithFormat:@"%@%@%@ (D)", shift, prefix, self.name];
    
    if (!self.isFinalState && [self.container shouldDescribeNextStatesOfState:self])
    {
        [string appendString:@"\n"];
        
        for (STState* state in self.states)
        {
            [string appendString:[state descriptionWithShift:[shift stringByAppendingString:siblingPrefix] prefix:@"|- " siblingPrefix:@"|  "]?:@""];
        }
        
        [string appendString:[self.nextState descriptionWithShift:[shift stringByAppendingString:siblingPrefix] prefix:@"" siblingPrefix:@""]?:@""];
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

#pragma mark - Private

- (void)addState:(STState*)state
{
    [state setContainer:self];
    [self.states addObject:state];
}

- (void)executeNextState
{
    if (self.isFinalState)
    {
        [self.container finalStateReached];
    }
    else
    {
        [self.container execute:self.nextState];
    }
}

@end
