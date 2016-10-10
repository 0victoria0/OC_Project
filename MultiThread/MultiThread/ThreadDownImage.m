//
//  ThreadDownImage.m
//  MultiThread
//
//  Created by victoria on 16/10/10.
//  Copyright © 2016年 victoria. All rights reserved.
//

#import "ThreadDownImage.h"

@interface ThreadDownImage (){
    UIImage *image1;
    UIImage *image2;
    UIImage *image3;
}

@property (nonatomic, assign) int count;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIImageView *imageView1;
@property (strong, nonatomic) IBOutlet UIImageView *imageView2;
@property (strong, nonatomic) IBOutlet UIImageView *imageView3;

@end

/*有三个网络请求需要发送，等三个网络请求发送完之后，要更新UI，怎么操作可以节省时间？*/

@implementation ThreadDownImage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self threadDownImage];
}

- (void)startLoading{
    //创建UIActivityIndicatorView背底半透明View
    UIView *view = [[UIView alloc] initWithFrame:self.view.frame];
    [view setTag:103];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.8];
    [self.view addSubview:view];
    
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
    [self.activityIndicator setCenter:view.center];
    [self.activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
    [view addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
}

- (void)stopLoading{
    [self.activityIndicator stopAnimating];
    UIView *view = (UIView *)[self.view viewWithTag:103];
    [view removeFromSuperview];
}

- (void)threadDownImage{
    [self startLoading];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/w%3D2048/sign=91c1063e1f950a7b753549c43ee963d9/f31fbe096b63f624b6a9640b8544ebf81b4ca3c6.jpg"];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        image1 = [UIImage imageWithData:data];
        
        //将代码块提交给主线程关联的队列，该代码将会由主线程完成
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image1 != nil) {
                [self updateUI];
            }else{
                self.count = -1;
            }
        });
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:20];
        //下载图片2
        NSURL *url2= [NSURL URLWithString:@"http://h.hiphotos.baidu.com/baike/c0%3Dbaike80%2C5%2C5%2C80%2C26/sign=f47fd63ca41ea8d39e2f7c56f6635b2b/1e30e924b899a9018b8d3ab11f950a7b0308f5f9.jpg"];
        NSData *data2 = [[NSData alloc] initWithContentsOfURL:url2];
        image2 = [UIImage imageWithData:data2];
        //将代码块提交给主线程关联的队列，该代码将会由主线程完成
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image2 != nil) {
                [self updateUI];
            }else{
                self.count = -1;
            }
        });
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *url = [NSURL URLWithString:@"http://f.hiphotos.baidu.com/image/w%3D2048/sign=91c1063e1f950a7b753549c43ee963d9/f31fbe096b63f624b6a9640b8544ebf81b4ca3c6.jpg"];
        NSData *data = [[NSData alloc] initWithContentsOfURL:url];
        image3 = [UIImage imageWithData:data];
        //将代码块提交给主线程关联的队列，该代码将会由主线程完成
        dispatch_async(dispatch_get_main_queue(), ^{
            if (image3 != nil) {
                [self updateUI];
            }else{
                self.count = -1;
            }
        });
    });
}

- (void)updateUI{
    self.count++;
    if (self.count == 3) {
        [self stopLoading];
        self.imageView1.image = image1;
        self.imageView2.image = image2;
        self.imageView3.image = image3;
    }else if (self.count == -1){
        NSLog(@"下载请求失败");
    }
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
