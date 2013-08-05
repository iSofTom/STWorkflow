//
//  STStateSimpleCondition.h
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

typedef BOOL(^STStateSimpleConditionBlock)(void);

@interface STStateSimpleCondition : STState

/**
 *	Set the condition block of the state.
 *  If the block's result is YES, the workflow will continue on the success state, otherwise on the failure state.
 *
 *	@param	condition	the block that will be executed to choose the next state.
 */
- (void)setCondition:(STStateSimpleConditionBlock)condition;

/**
 *	The state the workflow will continue on if the condition's result is YES.
 */
@property (nonatomic, weak) STState* successState;

/**
 *	The state the workflow will continue on if the condition's result is NO.
 */
@property (nonatomic, weak) STState* failureState;

@end
