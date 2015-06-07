//
//  CMViewController.m
//  CMEnvironmentExample
//
//  Created by Lucas Medeiros on 14/01/13.
//  Copyright (c) 2013 Codeminer 42. All rights reserved.
//

#import "CMViewController.h"
#import "CMAppEnvironment.h"

@interface CMViewController ()

@end

@implementation CMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	CMAppEnvironment *environment = [[CMAppEnvironment alloc] initWithBundle:[NSBundle mainBundle]];
    environment = [CMAppEnvironment sharedInstance];
    NSLog(@"Environment name: %@", environment.name);
    NSLog(@"URL: %@", environment.codeURL);
    NSLog(@"NUMBER: %ld", (long)[environment.codeNumber integerValue]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
