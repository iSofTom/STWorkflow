STWorkflow
==========

STWorkflow allows to write finite-state machine in Objective-C.
It handles simple conditions (two exits) and multiple conditions (n exits).
It allows to execute synchronous or asynchronous actions.

## How to

First of all, you will have to create all your states. With STWorkflow, actions as well as conditions are states !
From your STWorkflow instance, you will have access to several constructor methods, one for each kind of state:

```
self.workflow = [[STWorkflow alloc] init];
    
STStateSimpleCondition* simpleCondition = [self.workflow createSimpleConditionNamed:@"simple condition"];
STStateMultipleCondition* multipleCondition = [self.workflow createMultipleConditionNamed:@"multiple condition"];
STStateSyncAction* syncAction = [self.workflow createSyncActionNamed:@"sync action"];
STStateAsyncAction* asyncAction = [self.workflow createAsyncActionNamed:@"async action"];
```

There are 4 kind of states:
* `STStateSimpleCondition` is a simple condition.
* `STStateMultipleCondition` is a multiple condition.
* `STStateSyncAction` is a synchronous action.
* `STStateAsyncAction` is an asynchronous action.

Once all your states created, you can configure each state. You have to set conditions or actions blocks, and next state(s). For instance:

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

#### configure synchronous action

```
[syncAction setAction:^{
    NSLog(@"synchronous action");
}];
[syncAction setNextState:nextState];
```

#### configure asynchronous action

```
[asyncAction setAction:^(STStateAsyncAction* currentAction){
    [self doSomethingAsyncWithCompletion:^{
        [currentAction resume];
    }];
}];
[syncAction setNextState:nextState];
```

Furthermore you have to flag each final state:

```
[finalState flagAsFinalState];
```

Finally you have to start your workflow. (Don't forget to retain it if you have asynchronous actions).

```
[self.workflow start];
```

## Debug

You can log your workflow. It will log each state, with relations between them. For instance:

```
Check first launch (SC)
Y- Fetch something (AA)
|  Final state (SA) !
N- An other check (SC)
|  Y- Final state (SA) !
|  N- Log something (SA)
|  |  Final state (SA) !
```

After each state, it's type is indicated with two letters (SC: Simple Condition, MC: Multiple Condition, SA: Synchronous Action, AA: Asynchronous Action).
A exclamation point indicate a final state and an asterisk indicate a state that have already been logged previously (to prevent cycles).