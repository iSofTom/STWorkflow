STWorkflow
==========

STWorkflow allows to write finite-state machine in Objective-C.
It handles simple conditions (two exits) and multiple conditions (n exits).
It allows to execute actions, and dispatch states which allows to execute several states in parallel and synchronize the end of those states.
Each state (conditions or actions) can be synchronous or asynchronous.

## How to

First of all, you will have to create all your states. With STWorkflow, actions as well as conditions are states !
From your STWorkflow instance, you will have access to several constructor methods, one for each kind of state:

```
self.workflow = [[STWorkflow alloc] init];
    
STStateSimpleCondition* simpleCondition = [self.workflow createSimpleConditionNamed:@"simple condition"];
STStateMultipleCondition* multipleCondition = [self.workflow createMultipleConditionNamed:@"multiple condition"];
STStateAction* action = [self.workflow createActionNamed:@"action"];
STStateDispatch* dispatch = [self.workflow createDispatchNamed:@"dispatch"];
```

There are 4 kind of states:
* `STStateSimpleCondition` is a simple condition.
* `STStateMultipleCondition` is a multiple condition.
* `STStateAction` is an action.
* `STStateDispatch` is a dispatch state.

Once all your states created, you can configure each state. You have to set conditions or actions blocks, and next state(s). For instance:

### Synchronous States

#### configure simple condition

```
[simpleCondition setCondition:^BOOL{
    return YES;
}];
[simpleCondition setSuccessState:successState];
[simpleCondition setFailureState:failureState];
```

#### configure multiple condition

```
NSArray* keys @[@"key1", @"key2", @"key3"];
[multipleCondition setCondition:^BOOL{
    return [keys objectAtIndex:1];
}];
[multipleCondition setNextState:state1 forKey:[keys objectAtIndex:0]];
[multipleCondition setNextState:state2 forKey:[keys objectAtIndex:1]];
[multipleCondition setNextState:state3 forKey:[keys objectAtIndex:2]];
```

#### configure action

```
[syncAction setAction:^{
    NSLog(@"synchronous action");
}];
[syncAction setNextState:nextState];
```

### Asynchronous States

You can also configure each state as asynchronous state:

#### configure simple condition asynchronous

```
[simpleCondition setCondition:^(STStateSimpleCondition* s){
    [self aMethodThatAsynchronouslyRetrieveBooleanValue:^(BOOL result) {
        [s resumeWithSuccess:result];
    }];
}];
[simpleCondition setSuccessState:successState];
[simpleCondition setFailureState:failureState];
```

#### configure multiple condition asynchronous

```
NSArray* keys @[@"key1", @"key2", @"key3"];
[multipleCondition setCondition:^(STStateMultipleCondition* s){
    [self aMethodThatAsynchronouslyRetrieveIndexValue:^(NSInteger index) {
        [s resumeWithKey:[keys objectAtIndex:index]];
    }];
}];
[multipleCondition setNextState:state1 forKey:[keys objectAtIndex:0]];
[multipleCondition setNextState:state2 forKey:[keys objectAtIndex:1]];
[multipleCondition setNextState:state3 forKey:[keys objectAtIndex:2]];
```

#### configure action asynchronous

```
[syncAction setAction:^(STStateAction* s){
    [self aMethodThatAsynchronouslyExecuteAnAction:^{
        [s resume];
    }];
}];
[syncAction setNextState:nextState];
```

### Final States
Furthermore you have to flag each final state:

```
[finalState flagAsFinalState];
```

### Dispatch State

The 4th kind of state is slightly different, it allows to execute some states in parallel, and will wait until each parallel state reach a final state, then it will execute its next state.
In order to encapsulate states within the dispatch one, you have to create states from that dispatch state:

```
STStateSimpleCondition* dispatchedSimpleCondition = [dispatch createSimpleConditionNamed:@"simple condition"];
STStateMultipleCondition* dispatchedMultipleCondition = [dispatch createMultipleConditionNamed:@"multiple condition"];
STStateAction* dispatchedAction = [dispatch createActionNamed:@"action"];
STStateDispatch* dispatchedDispatch = [dispatch createDispatchNamed:@"dispatch"];

[dispatch setNextState:anOtherState];
```

### Start

Finally you have to start your workflow. (Don't forget to retain it if you have asynchronous actions).

```
[self.workflow start];
```

## Debug

You can log your workflow. It will log each state, with relations between them. For instance:

```
Check first launch (S)
Y- Fetch something (A)
|  Final state (A) !
N- An other check (S)
|  Y- Final state (S) !
|  N- Log something (S)
|  |  Final state (S) !
```

After each state, it's type is indicated with a letter (S: Simple Condition, M: Multiple Condition, A: Action, D: Dispatch).
An exclamation point indicate a final state and an asterisk indicate a state that have already been logged previously (to prevent cycles).

## Installation

To include this component in your project, I recommend you to use [Cocoapods](http://cocoapods.org):
* Add `pod "STWorkflow"` to your Podfile.
