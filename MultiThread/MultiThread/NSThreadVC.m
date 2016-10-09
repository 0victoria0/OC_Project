//
//  NSThreadVC.m
//  MultiThread
//
//  Created by victoria on 16/10/9.
//  Copyright © 2016年 victoria. All rights reserved.
//

#import "NSThreadVC.h"

@interface NSThreadVC ()

@end

@implementation NSThreadVC
/*
 iOS使用NSThread 类代表线程，创建新线程也就是创建NSThread 对象。 创建NSThread 有俩种方式。
 
 //创建一个新线程对象
 - (instancetype)initWithTarget:(id)target selector:(SEL)selector object:(nullable id)argument NS_AVAILABLE(10_5, 2_0);
 
 //创建并启动新线程
 + (void)detachNewThreadSelector:(SEL)selector toTarget:(id)target withObject:(nullable id)argument;
 
 上面俩种方式的本质都是将target对象的selector方法转换为线程执行体，其中selector方法最多可以接收一个参数，而argument就代表传给selector方法的参数。 这俩种创建新线程的方式并没有明显的区别，只是第一种方式是一个实例化方法，该方法返回一个NSThread 对象，必须调用 start方法启动线程：另一种不会返回NSThread 对象，因此这种方法会直接创建并启动新线程。 下面我们随便举个栗子，代码如下
 
 */
NSThread *thread;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //耗时操作请开辟新线程  比如下面这个循环。
    
    for (int i = 0; i < 100; i++) {
        NSLog(@"===%@===%d",[NSThread currentThread].name,i);
        [NSThread sleepForTimeInterval:0.5];
        if (i==7) {
            //创建线程对象
            thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
            //启用新线程
            [thread start];
            //创建并启用新线程
            //[NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
        }
    }
}

- (void)run{
    for (int i = 0; i < 100; i++) {
        if ([NSThread currentThread].isCancelled) {
            //终止当前正在执行的线程
            [NSThread exit];
        }
        NSLog(@"------%@------%d",[NSThread currentThread].name,i);
        //每执行一次，线程暂停0.5秒
        [NSThread sleepForTimeInterval:0.5];
    }
}
- (IBAction)cancelThread:(id)sender {
    [thread cancel];
}

/*
 2016-10-09 11:49:20.878 MultiThread[1490:75909] ======0
 2016-10-09 11:49:20.879 MultiThread[1490:75909] ======1
 2016-10-09 11:49:20.879 MultiThread[1490:75909] ======2
 2016-10-09 11:49:20.879 MultiThread[1490:75909] ======3
 2016-10-09 11:49:20.879 MultiThread[1490:75909] ======4
 2016-10-09 11:49:20.880 MultiThread[1490:75909] ======5
 2016-10-09 11:49:20.880 MultiThread[1490:75909] ======6
 2016-10-09 11:49:20.880 MultiThread[1490:75909] ======7
 2016-10-09 11:49:20.880 MultiThread[1490:75909] ======8
 2016-10-09 11:49:20.880 MultiThread[1490:75909] ======9
 2016-10-09 11:49:20.880 MultiThread[1490:75986] ------------0
 2016-10-09 11:49:20.880 MultiThread[1490:75909] ======10
 2016-10-09 11:49:20.881 MultiThread[1490:75986] ------------1
 2016-10-09 11:49:20.881 MultiThread[1490:75909] ======11
 2016-10-09 11:49:20.881 MultiThread[1490:75986] ------------2
 2016-10-09 11:49:20.881 MultiThread[1490:75909] ======12
 2016-10-09 11:49:20.881 MultiThread[1490:75909] ======13
 2016-10-09 11:49:20.881 MultiThread[1490:75986] ------------3
 2016-10-09 11:49:20.882 MultiThread[1490:75909] ======14
 2016-10-09 11:49:20.882 MultiThread[1490:75986] ------------4
 2016-10-09 11:49:20.882 MultiThread[1490:75909] ======15
 2016-10-09 11:49:20.882 MultiThread[1490:75986] ------------5
 */

/*
 由上不难看出，这是俩个线程并发执行的效果。除此之外上面的🌰还用到了 + (NSThread *)currentThread;方法，该方法总是返回当前正在执行的线程对象。
 
 当线程被创建并启动以后，它既不是一启动就进入了执行状态，也不是一直处于执行状态。即使线程开始运行以后，它也不可能一直“霸占”着CPU独自运行，所以CPU需要再多个线程之间切换，于是线程状态也会多次在运行、就绪状态之间的切换。 当程序创建了一个线程之后，该线程就处于新建状态，此时它和其他Objective-C对象一样，仅仅由系统为其分配了内存，并初始化了其他成员变量的值。此时的线程对象没有表现出任何线程的动态特征，程序也不会执行线程的线程执行体。 当线程对象调用了start方法之后，该线程处于就绪状态，系统会为其创建方法调用栈和程序计数器，处于这种状态中的线程并没有开始运行，它只是表示该线程可以运行了。至于该线程何时运行，取决于系统的调度。
 */

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
