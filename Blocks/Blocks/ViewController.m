//
//  ViewController.m
//  Blocks
//
//  Created by victoria on 16/10/9.
//  Copyright © 2016年 victoria. All rights reserved.
//

#import "ViewController.h"
#import "BlocksViewController.h"

@interface ViewController ()

typedef int (^myblock)(int a);

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    int number = [self funtion:^(int a) {
        return a*a;
    }];
    NSLog(@"%d",number);
    
    void (^block0)(int a,int b) = ^(int a, int b){
        NSLog(@"block变量");
    };
    block0(3,5);
}

- (int)funtion:(myblock)block{
    int bb = block(3);
    return bb * bb;
}

- (IBAction)btnClick:(id)sender {
    UIStoryboard *blockStoryBoard = [UIStoryboard storyboardWithName:@"Blocks" bundle:nil];
    BlocksViewController *blockVC = [blockStoryBoard instantiateViewControllerWithIdentifier:@"Blocks"];
    
    /*Block变量作为属性变量时，一般用于两个类之间进行数据传递*/
    blockVC.colorBlock = ^(UIColor *color){
        self.view.backgroundColor = color;
        NSLog(@"背景色改变");
    };
    __block NSMutableArray *muArray = [NSMutableArray arrayWithObjects:@"Bob",@"Jack",@"Marry", nil];
    
    /*Block变量作为函数参数，理解为函数调用函数，一般情况时两个函数不在一个类中（把Block匿名函数的结果作为另一个函数的参数）*/
    [blockVC updateInfoWithBlock:^(NSArray *array) {
        [muArray addObject:array];
        NSLog(@"%@",muArray);
    }];
    NSLog(@"%@",muArray);
    
    [self presentViewController:blockVC animated:YES completion:^{
        NSLog(@"进入第二个界面%@",self.view.backgroundColor);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
