//
//  GCDVC.m
//  MultiThread
//
//  Created by victoria on 16/10/9.
//  Copyright © 2016年 victoria. All rights reserved.
//

#import "GCDVC.h"

@interface GCDVC ()

@property (nonatomic, strong) dispatch_queue_t serialQueue;//串行队列
@property (nonatomic, strong) dispatch_queue_t concurrentQueue;//并发队列

@end

@implementation GCDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self testQueue];
    //创建串行队列
    self.serialQueue = dispatch_queue_create("serial.queue", DISPATCH_QUEUE_SERIAL);
    //创建并发队列
    self.concurrentQueue = dispatch_queue_create("concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
}

#pragma mark -
#pragma mark -  给串行队列添加任务
- (IBAction)serial:(id)sender {
    //依次将2个代码块任务提交给串行队列
    //必须等到第一个代码块完成后，才能执行第二个代码块
    dispatch_async(self.serialQueue, ^{
        for (int i = 0 ; i < 100; i++) {
            NSLog(@"%@===......-......===%d",[NSThread currentThread],i);
        }
    });
    dispatch_async(self.serialQueue, ^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"%@------------------%d",[NSThread currentThread],i);
        }
    });
}

#pragma mark -
#pragma mark -  给并发队列添加任务
- (IBAction)concurrent:(id)sender {
    //依次将两个代码块提交给并发队列
    //两个代码块可以并发执行
    dispatch_async(self.concurrentQueue, ^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"%@===......-......===%d",[NSThread currentThread],i);
        }
    });
    dispatch_async(self.concurrentQueue, ^{
        for (int i = 0; i < 100; i++) {
            NSLog(@"%@------------------%d",[NSThread currentThread],i);
        }
    });
}

#pragma mark -
#pragma mark -  异步加载图片
- (IBAction)downImage:(id)sender {
    //把下载两张图片的任务加入到主线程的全局并发队列
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/w%3D2048/sign=91c1063e1f950a7b753549c43ee963d9/f31fbe096b63f624b6a9640b8544ebf81b4ca3c6.jpg"];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        if (image != nil) {
            //将代码块提交给主线程关联的队列，该代码将会由主线程完成
            dispatch_async(dispatch_get_main_queue(), ^{
                self.view.backgroundColor = [UIColor colorWithPatternImage:image];
                NSLog(@"image1");
            });
        }else{
            NSLog(@"图片xiaz失败");
        }
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:3];
        //下载图片2
        NSURL *url2= [NSURL URLWithString:@"http://h.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=f47fd63ca41ea8d39e2f7c56f6635b2b/1e30e924b899a9018b8d3ab11f950a7b0308f5f9.jpg"];
        NSData *data2 = [[NSData alloc] initWithContentsOfURL:url2];
        UIImage *image2 = [UIImage imageWithData:data2];
        if (image2 != nil) {
            //将代码块提交给主线程关联的队列，该代码将会由主线程完成
            dispatch_async(dispatch_get_main_queue(), ^{
                [NSThread sleepForTimeInterval:2];
                self.view.backgroundColor = [UIColor colorWithPatternImage:image2];
                NSLog(@"image2");
            });
        }else{
            NSLog(@"图片xiaz失败");
        }
    });
}

#pragma mark -
#pragma mark -  异步下载图片
- (void)asyncDownImage:(NSString *)urlString{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:3];
        //下载图片2
        NSURL *url2= [NSURL URLWithString:urlString];
        NSData *data2 = [[NSData alloc] initWithContentsOfURL:url2];
        UIImage *image2 = [UIImage imageWithData:data2];
        if (image2 != nil) {
            //将代码块提交给主线程关联的队列，该代码将会由主线程完成
            dispatch_async(dispatch_get_main_queue(), ^{
                self.view.backgroundColor = [UIColor colorWithPatternImage:image2];
            });
        }else{
            NSLog(@"图片xiaz失败");
        }
    });
}

-(void)testQueue{
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_queue_t concurrentQueue = dispatch_queue_create("my.queue", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"1");
    dispatch_sync(queue, ^(){
        NSLog(@"2");
        dispatch_async(queue, ^{
            for (int i=0; i<10; i++) {
                NSLog(@"A=%d",i);
            }
        });
        NSLog(@"3");
    });
    dispatch_sync(queue, ^(){
        NSLog(@"2");
        dispatch_async(queue, ^{
            for (int i=0; i<10; i++) {
                NSLog(@"B=%d",i);
            }
        });
        NSLog(@"3");
    });
    NSLog(@"4");
}

/*
 2016-10-09 17:51:05.384 MultiThread[2869:215877] 1
 2016-10-09 17:51:08.706 MultiThread[2869:215877] 2
 2016-10-09 17:51:08.707 MultiThread[2869:215877] 3
 2016-10-09 17:51:08.707 MultiThread[2869:215916] A=0
 2016-10-09 17:51:11.150 MultiThread[2869:215877] 2
 2016-10-09 17:51:11.150 MultiThread[2869:215916] A=1
 2016-10-09 17:51:11.151 MultiThread[2869:215877] 3
 2016-10-09 17:51:11.151 MultiThread[2869:215916] A=2
 2016-10-09 17:51:11.151 MultiThread[2869:215915] B=0
 2016-10-09 17:51:11.151 MultiThread[2869:215877] 4
 2016-10-09 17:51:11.151 MultiThread[2869:215916] A=3
 2016-10-09 17:51:11.151 MultiThread[2869:215915] B=1
 2016-10-09 17:51:11.151 MultiThread[2869:215916] A=4
 2016-10-09 17:51:11.152 MultiThread[2869:215915] B=2
 2016-10-09 17:51:11.152 MultiThread[2869:215916] A=5
 2016-10-09 17:51:11.152 MultiThread[2869:215915] B=3
 2016-10-09 17:51:11.152 MultiThread[2869:215916] A=6
 2016-10-09 17:51:11.152 MultiThread[2869:215915] B=4
 2016-10-09 17:51:11.152 MultiThread[2869:215916] A=7
 2016-10-09 17:51:11.152 MultiThread[2869:215915] B=5
 2016-10-09 17:51:11.152 MultiThread[2869:215916] A=8
 2016-10-09 17:51:11.153 MultiThread[2869:215915] B=6
 2016-10-09 17:51:11.153 MultiThread[2869:215916] A=9
 2016-10-09 17:51:11.153 MultiThread[2869:215915] B=7
 2016-10-09 17:51:11.176 MultiThread[2869:215915] B=8
 2016-10-09 17:51:11.176 MultiThread[2869:215915] B=9
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
