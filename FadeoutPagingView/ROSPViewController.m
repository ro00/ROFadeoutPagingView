//
//  ROSPViewController.m
//  FadeoutPagingView
//
//  Created by Jack on 13-7-18.
//  Copyright (c) 2013年 iamro00. All rights reserved.
//

#import "ROSPViewController.h"
#import "ROFadeoutPagingView.h"

@interface ROSPViewController ()

@end

@implementation ROSPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:[[ROFadeoutPagingView alloc] initWithImages:@[[UIImage imageNamed:@"fin.jpg"],[UIImage imageNamed:@"fin.jpg"],[UIImage imageNamed:@"fin.jpg"],[UIImage imageNamed:@"fin.jpg"],[UIImage imageNamed:@"fin.jpg"],[UIImage imageNamed:@"fin.jpg"]] frame:self.view.bounds]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
