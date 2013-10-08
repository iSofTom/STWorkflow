//
//  ViewController.m
//  TestsSTWorkflow
//
//  Created by Thomas Dupont on 02/08/13.
//  Copyright (c) 2013 iSofTom. All rights reserved.
//

#import "ViewController.h"

#import "STWorkflow.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *choice;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmented;

@property (strong, nonatomic) IBOutlet UILabel *choiceLabel;
@property (weak, nonatomic) IBOutlet UILabel *choice2Label;
@property (weak, nonatomic) IBOutlet UILabel *asyncLabel;
@property (weak, nonatomic) IBOutlet UILabel *finalLabel;
@property (weak, nonatomic) IBOutlet UILabel *action1Label;
@property (weak, nonatomic) IBOutlet UILabel *action2Label;
@property (weak, nonatomic) IBOutlet UILabel *action3Label;

@property (nonatomic, strong) STWorkflow* workflow;

@end

@implementation ViewController

- (void)downloadWithCompletion:(void(^)())completion
{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        completion();
    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.workflow = [self createWorkflow];
    
    NSLog(@"%@", self.workflow);
}

- (STWorkflow*)createWorkflow
{
    STWorkflow* workflow = [[STWorkflow alloc] init];
    
    STStateSimpleCondition* firstLaunch = [workflow createSimpleConditionNamed:@"Check First launch"];
    STStateAction* downloadConf = [workflow createActionNamed:@"Download Config"];
    STStateMultipleCondition* condition = [workflow createMultipleConditionNamed:@"Condition"];
    STStateAction* action1 = [workflow createActionNamed:@"Action 1"];
    STStateAction* action2 = [workflow createActionNamed:@"Action 2"];
    STStateAction* action3 = [workflow createActionNamed:@"Action 3"];
    STStateAction* finalState = [workflow createActionNamed:@"Final state"];
    
    // Check First launch
    [firstLaunch setCondition:^BOOL{
        [self.choiceLabel setTextColor:[UIColor redColor]];
        return [self.choice isOn];
    }];
    [firstLaunch setSuccessState:downloadConf];
    [firstLaunch setFailureState:condition];
    
    // Download config
    [downloadConf setAsyncAction:^(STStateAction *currentAction) {
        [self.asyncLabel setTextColor:[UIColor blueColor]];
        [self downloadWithCompletion:^{
            [self.asyncLabel setTextColor:[UIColor redColor]];
            [currentAction resume];
        }];
    }];
    [downloadConf setNextState:finalState];
    
    // Condition
    NSArray* keys = @[@"Key1", @"Key2", @"Key3"];
    [condition setCondition:^NSString *{
        [self.choice2Label setTextColor:[UIColor redColor]];
        NSInteger index = [self.segmented selectedSegmentIndex];
        return [keys objectAtIndex:index];
    }];
    [condition setNextState:action1 forKey:[keys objectAtIndex:0]];
    [condition setNextState:action2 forKey:[keys objectAtIndex:1]];
    [condition setNextState:action3 forKey:[keys objectAtIndex:2]];
    
    // Action 1
    [action1 setAction:^{
        [self.action1Label setTextColor:[UIColor redColor]];
    }];
    [action1 setNextState:finalState];
    
    // Action 2
    [action2 setAction:^{
        [self.action2Label setTextColor:[UIColor redColor]];
    }];
    [action2 setNextState:finalState];
    
    // Action 3
    [action3 setAction:^{
        [self.action3Label setTextColor:[UIColor redColor]];
    }];
    [action3 setNextState:finalState];
    
    // Final state
    [finalState setAction:^{
        [self.finalLabel setTextColor:[UIColor redColor]];
    }];
    [finalState flagAsFinalState];
    
    return workflow;
}

- (IBAction)start:(id)sender
{
    [self.choiceLabel setTextColor:[UIColor blackColor]];
    [self.choice2Label setTextColor:[UIColor blackColor]];
    [self.asyncLabel setTextColor:[UIColor blackColor]];
    [self.finalLabel setTextColor:[UIColor blackColor]];
    [self.action1Label setTextColor:[UIColor blackColor]];
    [self.action2Label setTextColor:[UIColor blackColor]];
    [self.action3Label setTextColor:[UIColor blackColor]];
    
    [self.workflow start];
}

- (IBAction)pause:(id)sender
{
    [self.workflow pause];
}

- (IBAction)resume:(id)sender
{
    [self.workflow resume];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
