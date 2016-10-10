//
//  ViewController.m
//  MultiThread
//
//  Created by victoria on 16/10/9.
//  Copyright © 2016年 victoria. All rights reserved.
//

#import "ViewController.h"
#import "NSThreadVC.h"
#import "GCDVC.h"
#import "NSOperationVC.h"
#import "ThreadDownImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)gotoNSThread:(id)sender {
    UIStoryboard *threadSB = [UIStoryboard storyboardWithName:@"Thread" bundle:nil];
    NSThreadVC *threadVC = [threadSB instantiateViewControllerWithIdentifier:@"Thread"];
    [self presentViewController:threadVC animated:YES completion:nil];
}

- (IBAction)gotoGCD:(id)sender {
    UIStoryboard *gcdSB = [UIStoryboard storyboardWithName:@"GCD" bundle:nil];
    NSThreadVC *gcdVC = [gcdSB instantiateViewControllerWithIdentifier:@"GCD"];
    [self presentViewController:gcdVC animated:YES completion:nil];
}

- (IBAction)gotoNSOperation:(id)sender {
    NSOperationVC *operationVC = [[NSOperationVC alloc] init];
    [self presentViewController:operationVC animated:YES completion:nil];
}

- (IBAction)gotoDownImage:(id)sender {
    UIStoryboard *downImageSB = [UIStoryboard storyboardWithName:@"ThreadDownImage" bundle:nil];
    ThreadDownImage *downImageVC = [downImageSB instantiateViewControllerWithIdentifier:@"ThreadDownImage"];
    [self presentViewController:downImageVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
