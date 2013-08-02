STWorkflow
==========

(Work In Progress)
STWorkflow allows to write finite-state machine in Objective-C.

## How to

First of all, you will have to create all your states. With STWorkflow, actions as well as conditions are states !
From your STWorkflow instance, you will have access to several constructor methods, one for each kind of state:

```
self.workflow = [[STWorkflow alloc] init];
    
STStateSimpleCondition* simpleCondition = [workflow createSimpleConditionNamed:@"simple condition"];
STStateMultipleCondition* multipleCondition = [workflow createMultipleConditionNamed:@"multiple condition"];
STStateAsyncAction* asyncAction = [workflow createAsyncActionNamed:@"async action"];
STStateSyncAction* syncAction = [workflow createSyncActionNamed:@"sync action"];
```

Once all your states created, you can configure each state. You have to set conditions or actions blocks, and next state(s). furthermore you have to flag each final state. For instance:

```
[simpleCondition setCondition:^BOOL{
    return YES;
}];
[simpleCondition setSuccessState:multipleCondition];
[simpleCondition setFailureState:asyncAction];

[syncAction setAction:^{
    NSLog(@"");
}];
[syncAction flagAsFinalState];
```

Finally you have to start your workflow. (Don't forget to retain it if you have asynchronous actions).

```
[self.workflow start];
```

## Debug

You can log your workflow.

(Work In Progress)