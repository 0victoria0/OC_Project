//
//  ViewController.m
//  OC_CALayer
//
//  Created by victoria on 16/10/9.
//  Copyright © 2016年 victoria. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIView *layerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *image = [UIImage imageNamed:@"l_registSuc"];
    
    //add it directly to our view's layer
    //ARC下OC对象和CF对象之间的桥接（bridge）
    /*在开发iOS应用程序时我们有时会用到Core Foundation对象简称CF,例如Core Graphics、Core Text，并且我们可能需要将CF对象和OC对象进行互相转化，我们知道，ARC环境下编译器不会自动管理CF对象的内存，所以当我们创建了一个CF对象以后就需要我们使用CFRelease将其手动释放，那么CF和OC相互转化的时候该如何管理内存呢？答案就是我们在需要时可以使用__bridge,__bridge_transfer,__bridge_retained*/
    self.layerView.layer.contents = (__bridge id)image.CGImage;
    self.layerView.layer.contentsGravity = kCAGravityResizeAspect;//图片适应，而不是拉伸
}

- (void)addSublayer{
    //create sublayer
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50, 50, 100, 100);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    //add it to our view
    [self.layerView.layer addSublayer:blueLayer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
