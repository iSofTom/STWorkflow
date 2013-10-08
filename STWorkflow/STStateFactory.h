//
//  STStateFactory.h
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

#import <Foundation/Foundation.h>

@class STStateSimpleCondition, STStateMultipleCondition, STStateAction, STStateDispatch;

@protocol STStateFactory <NSObject>

/**
 *	Create a simple condition state and add it to the current container.
 *  @see STStateSimpleCondition
 *
 *	@param	name	the name of the state. Useful for logging and testing, but also for readability.
 *
 *	@return	return the simple condition state.
 */
- (STStateSimpleCondition*)createSimpleConditionNamed:(NSString*)name;

/**
 *	Create a multiple condition state and add it to the current container.
 *  @see STStateMultipleCondition
 *
 *	@param	name	the name of the state. Useful for logging and testing, but also for readability.
 *
 *	@return	return the multiple condition state.
 */
- (STStateMultipleCondition*)createMultipleConditionNamed:(NSString*)name;

/**
 *	Create an action state and add it to the current container.
 *  @see STStateAction
 *
 *	@param	name	the name of the state. Useful for logging and testing, but also for readability.
 *
 *	@return	return the action state.
 */
- (STStateAction*)createActionNamed:(NSString*)name;

/**
 *	Create a Dispatch state and add it to the current container.
 *  A Dispatch state is also a state container, and will execute all its states in parallel.
 *  @see STStateDispatch
 *
 *	@param	name	the name of the state. Useful for logging and testing, but also for readability.
 *
 *	@return	return the dispatch state.
 */
- (STStateDispatch*)createDispatchNamed:(NSString*)name;

@end
