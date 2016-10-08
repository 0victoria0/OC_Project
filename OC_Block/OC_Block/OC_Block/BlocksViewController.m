//
//  BlocksViewController.m
//  OC_AdvancedProgramming
//
//  Created by victoria on 16/9/30.
//  Copyright © 2016年 victoria. All rights reserved.
//

/*
 Blocks是C语言的扩充功能，带有自动变量（局部变量）的匿名函数。 所谓匿名函数就是不带有名称的函数。
 C语言的函数中可能使用的变量
    自动变量（局部变量）：
    函数的参数：
    静态变量（静态局部变量）：
    静态全局变量：
    全局变量：
 其中，在函数的多次调用之间能够传递值的变量有：
    静态变量（静态局部变量）：
    静态全局变量：
    全局变量：
 */

/*
 Block语法：^ 返回值类型 参数列表 表达式  eg:^int (int count) { return count+1; }
    省略语法：^ 参数列表 表达式  eg:^ (int count) { return count+1; }
 
 Block变量声明：int (^myblock) (int)  第一个int是block匿名函数的返回值，myblock是block变量的名称，第二个int是block匿名函数的参数
    eg:myblock = ^int(int a){
        int result = a + a;
        return result;
    }
    调用block：int number  = myblock(4);
 */

#import "BlocksViewController.h"

@interface BlocksViewController ()


@end

@implementation BlocksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hhh = 90;
}

- (void)updateInfoWithBlock:(myArray)clockArray{
    NSArray *array = @[@"Tom",@"Tim",@"Tob"];
    clockArray(array);
}

- (IBAction)btnClick:(id)sender {
    UIColor *color = [UIColor redColor];
    
    if (self.colorBlock) {
        self.colorBlock(color);
    }

    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"返回第一个界面");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
