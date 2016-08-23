//
//  WSViewController.m
//  WSDatePicker
//
//  Created by wang on 08/22/2016.
//  Copyright (c) 2016 wang. All rights reserved.
//

#import "WSViewController.h"
#import <WSDatePicker/WSDatePicker.h>
#import "WSBViewController.h"

@interface WSViewController ()

@end

@implementation WSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setTitle:@"click" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnTaped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.tag = 1000;

    // Do any additional setup after loading the view, typically from a nib.
    btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 40)];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn setTitle:@"click2" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnTaped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    btn.tag = 1001;

}

- (void)btnTaped:(UIButton *)sender
{
    WSDatePickerController *b = [WSDatePickerController new];
    b.pickerType = WSDatePickerTypeYEARANDMONTHANDDAY;
    NSDateFormatter *format = [NSDateFormatter new];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dt = [format dateFromString:@"2016-12-12 12:12:12"];
    b.defaultDate = dt;
    [b setCallback:^(NSInteger year, NSInteger month, NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        NSLog(@"%d  %d  %d  %d  %d  %d",year,month,day,hour,minute,second);
    }];
    if(sender.tag == 1000)
    {
        [self presentViewController:b animated:YES completion:nil customerAnimated:YES];
    }
    else
        [self presentViewController:b animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
