//
//  STWorkflow+Debug.h
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
#import "STState.h"

@interface STWorkflow (Debug)

/**
 *	Return the name of the current state.
 *
 *	@return	The name of the current state.
 */
- (NSString*)currentStateName;

/**
 *	Return the first state of the workflow.
 *
 *	@return	The first state of the workflow.
 */
- (STState*)startState;

/**
 *	Return the first state named as the string in parameters.
 *
 *	@param	name	the name you're looking for.
 *
 *	@return	The state named as the string in parameters.
 */
- (STState*)stateNamed:(NSString*)name;

@end

@interface STState (Debug)

/**
 *	Return a boolean that indicate if the current state is named as the string in parameters.
 *
 *	@param	name	The name you're checking.
 *
 *	@return	A boolean that indicate if the current's name is the same as the one in parameters.
 */
- (BOOL)isNamed:(NSString*)name;

/**
 *	Return a boolean that indicate if the current state is a STStateSimpleCondition.
 *
 *	@return	A boolean that indicate if the current state is a STStateSimpleCondition.
 */
- (BOOL)isSimpleCondition;

/**
 *	Return a boolean that indicate if the current state is a STStateMultipleCondition.
 *
 *	@return	A boolean that indicate if the current state is a STStateMultipleCondition.
 */
- (BOOL)isMultipleCondition;

/**
 *	Return a boolean that indicate if the current state is a STStateSyncAction.
 *
 *	@return	A boolean that indicate if the current state is a STStateSyncAction.
 */
- (BOOL)isSyncAction;

/**
 *	Return a boolean that indicate if the current state is a STStateAsyncAction.
 *
 *	@return	A boolean that indicate if the current state is a STStateAsyncAction.
 */
- (BOOL)isAsyncAction;

@end
