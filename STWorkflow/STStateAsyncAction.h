//
//  STStateAsyncAction.h
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

@class STStateAsyncAction;

typedef void(^STStateAsyncActionBlock)(STStateAsyncAction* currentAction);

@interface STStateAsyncAction : STState

/**
 *	Set the action block of the state.
 *  You'll have to call the resume method on the state in parameters once your async action is done
 *  in order to let the workflow know it can continue on the next state.
 *
 *	@param	action	The block that will be executed.
 */
- (void)setAction:(STStateAsyncActionBlock)action;

/**
 *  The state the workflow will continue on once the resume method is called.
 */
@property (nonatomic, weak) STState* nextState;

/**
 *  You should call this method to let the workflow know it can continue on the next state.
 */
- (void)resume;

@end
