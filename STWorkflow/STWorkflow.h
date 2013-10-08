//
//  STWorkflow.h
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

#import <Foundation/Foundation.h>

#import "STStateFactory.h"
#import "STStateSimpleCondition.h"
#import "STStateMultipleCondition.h"
#import "STStateAction.h"
#import "STStateDispatch.h"

/**
 *	STWorkflow represents a worflow, with multiple states and relations between them.
 */
@interface STWorkflow : NSObject <STStateFactory>

/**
 *	Starts a workflow.
 *  The first state that will be executed is the first that has been added to the current workflow.
 *  If the current workflow is already running, does nothing.
 */
- (void)start;

/**
 *	Pause a workflow.
 *  If it is not running, does nothing.
 */
- (void)pause;

/**
 *	Resume a workflow.
 *  If it hasn't previously been paused on a state, does nothing.
 */
- (void)resume;

@end
