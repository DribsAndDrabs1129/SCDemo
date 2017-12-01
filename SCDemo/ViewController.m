//
//  ViewController.m
//  SCDemo
//
//  Created by Channe Sun on 2017/12/1.
//  Copyright © 2017年 HUST. All rights reserved.
//

#import "ViewController.h"
#import "SCLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self addNotify];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 20, 300, 44)];
    label1.font = [UIFont systemFontOfSize:20];
    label1.backgroundColor = [UIColor greenColor];
    label1.numberOfLines = 0;
    label1.textColor = [UIColor whiteColor];
    label1.layer.cornerRadius = 5.0;
    label1.layer.borderWidth = 1.0;
    label1.layer.borderColor = [UIColor orangeColor].CGColor;
    label1.text = @"this is a label with property set";
    [self.view addSubview:label1];
    
    SCLabel *label = [[SCLabel alloc] initWithFrame:CGRectMake(100, 100, 300, 44)];
    [label customCopyFrom:label1 custom:SC_CommonPorperty|SC_FormatPorperty|SC_LayerPorperty];
    label.adjustsFitWidthToFontSize = YES;
    label.corner = UIRectCornerAllCorners;
    label.layer.cornerRadius = 5;
    label.tag = 10087;
    label.textChangeCB = ^(CGFloat newWidth, CGFloat newHeight, NSString *newText) {
        UILabel *label2 = [self.view viewWithTag:10086];
        label2.frame = CGRectMake(100, label.bottom + 10, 300, 44);
    };
    label.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    label.text = @"桃花树下种桃花，桃花眼里桃花仙。桃花仙人种桃树，卖得桃花赚酒钱";
    [self.view addSubview:label];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        label.text = @"看书就像吃饭，虽然你不记得吃了米饭还是面条，最终都长成了你的血肉，虽然你不记得看过了什么书，但书里的营养，最终都成为了你思想深处的一撇";
    });
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(100, label.bottom + 10, 300, 44)];
    label2.backgroundColor = [UIColor yellowColor];
    label2.tag = 10086;
    label2.text = @"this is a label respect to middle one";
    [self.view addSubview:label2];
}

- (void)addNotify{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(labelSizeChanged:) name:SCLabelSizeChanged object:nil];
}

- (void)labelSizeChanged:(NSNotification*)notify{
    NSLog(@"%@",notify.userInfo);
    SCLabel *label = [self.view viewWithTag:10087];
    UILabel *label2 = [self.view viewWithTag:10086];
    label2.frame = CGRectMake(100, label.bottom + 10, 300, 44);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
