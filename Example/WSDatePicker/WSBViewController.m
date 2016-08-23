//
//  WSBViewController.m
//  WSDatePicker
//
//  Created by winter on 16/8/22.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "WSBViewController.h"
#import <WSDatePicker/WSDatePicker.h>
@implementation WSBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 150, 100, 40)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTitle:@"click" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnTaped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    NSArray<UIView *> *views = win.subviews;
    [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       if(obj==self.view)
       {
           NSLog(@"------%d",idx);
       }
    }];
}

- (void)btnTaped:(UIButton *)sender
{
    //WSBViewController *b = [WSBViewController new];
    //[self presentViewController:b animated:YES completion:nil customerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
