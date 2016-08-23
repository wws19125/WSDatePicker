//
//  UIViewController+WSDatePicker.m
//  Pods
//
//  Created by winter on 16/8/22.
//
//

#import "UIViewController+WSDatePicker.h"
#import "WSDatePickerAnimation.h"
#import <objc/runtime.h>


@implementation UIViewController (WSDatePicker)


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    id obj = objc_getAssociatedObject(self, "WSDatePickerAnimation");
    return obj;
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion customerAnimated:(BOOL)customerFlag
{
    if(customerFlag)
    {
        WSDatePickerAnimation *ani = [WSDatePickerAnimation new];
        objc_setAssociatedObject(self, "WSDatePickerAnimation", ani, OBJC_ASSOCIATION_RETAIN);
        viewControllerToPresent.transitioningDelegate = self;
//        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
//            
//            viewControllerToPresent.modalPresentationStyle=UIModalPresentationOverCurrentContext;
//            
//        }else{
//            
//            self.modalPresentationStyle=UIModalPresentationCurrentContext;
//            
//        }
    }
    [self presentViewController:viewControllerToPresent animated:flag completion:^(){
        if(customerFlag)
        {
            objc_setAssociatedObject(self, "WSDatePickerAnimation", nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            self.transitioningDelegate = nil;
        }
        if(completion)
            completion();
    }];
}

@end
