//
//  BlocksViewController.h
//  Blocks
//
//  Created by victoria on 16/10/9.
//  Copyright © 2016年 victoria. All rights reserved.
//

#import <UIKit/UIKit.h>

/*typedef 为一种数据类型定义一个新名字*/
typedef void(^myArray) (NSArray *array);
typedef int myInt;

@interface BlocksViewController : UIViewController

@property (nonatomic, strong) void(^colorBlock)(UIColor *color);
@property (nonatomic, assign) myInt hhh;
- (void)updateInfoWithBlock:(myArray)clockArray;

@end
