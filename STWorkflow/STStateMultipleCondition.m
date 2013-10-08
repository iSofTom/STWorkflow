//
//  STStateMultipleCondition.m
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

#import "STStateMultipleCondition.h"
#import "STState_private.h"

@interface STStateMultipleCondition ()

@property (nonatomic, strong) NSMutableDictionary* nextStates;

@end

@implementation STStateMultipleCondition

#pragma mark - Public methods

- (void)resumeWithKey:(NSString*)key
{
    if (self.isFinalState)
    {
        [self.container finalStateReached];
    }
    else
    {
        STState* state = [self.nextStates objectForKey:key];
        [self.container execute:state];
    }
}

- (void)setNextState:(STState*)state forKey:(NSString*)key
{
    if (!self.nextStates)
    {
        self.nextStates = [[NSMutableDictionary alloc] init];
    }
    
    [self.nextStates setObject:state forKey:key];
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
        NSString* key = self.condition();
        [self resumeWithKey:key];
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
        STState* state = nil;
        for (STState* s in [self.nextStates allValues])
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
    NSMutableString* string = [[NSMutableString alloc] initWithFormat:@"%@%@%@ (M)", shift, prefix, self.name];
    
    if (!self.isFinalState && [self.container shouldDescribeNextStatesOfState:self])
    {
        [string appendString:@"\n"];
        for (STState* state in [self.nextStates allValues])
        {
            [string appendString:[state descriptionWithShift:[shift stringByAppendingString:siblingPrefix] prefix:@"+- " siblingPrefix:@"|  "]?:@""];
        }
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
