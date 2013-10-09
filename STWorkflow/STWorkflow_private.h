//
//  STWorkflow_private.h
//  TestsSTWorkflow
//
//  Created by Thomas Dupont on 09/10/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import "STWorkflow.h"
#import "STStateContainer.h"

@interface STWorkflow () <STStateContainer>

@property (nonatomic, strong) NSMutableSet* states;
@property (nonatomic, strong) STState* firstState;
@property (nonatomic, strong) STState* currentState;
@property (nonatomic, assign) BOOL running;
@property (nonatomic, strong) NSMutableSet* describedStates;

@end
