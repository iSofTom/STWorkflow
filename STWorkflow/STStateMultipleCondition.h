//
//  STStateMultipleCondition.h
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

#import "STState.h"

typedef NSString*(^STStateMultipleConditionBlock)(void);

@interface STStateMultipleCondition : STState

/**
 *	Set the condition block of the state.
 *  The block should return a key, an NSString, that will be used to retrieve the next state.
 *
 *	@param	condition	the block that will be executed to choose the next state.
 */
- (void)setCondition:(STStateMultipleConditionBlock)condition;

/**
 *	Associate a potential next state to a key.
 *
 *	@param	state	The state the workflow will continue on if the condition returns the key in parameters.
 *	@param	key	The key the condition should return in order to choose the state in parameters.
 */
- (void)setNextState:(STState*)state forKey:(NSString*)key;

@end
