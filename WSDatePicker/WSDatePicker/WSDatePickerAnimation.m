//
//  WSDatePickerAnimation.m
//  Pods
//
//  Created by winter on 16/8/22.
//
//

#import "WSDatePickerAnimation.h"
#import <objc/runtime.h>

@implementation WSDatePickerAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return .8;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    /// 0 for present 1 for dismiss
    int flag = objc_getAssociatedObject(fromVC, "WSDatePickerAnimation") == nil ? 0 : 1;
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    //CGRect screenBounds = [UIScreen mainScreen].bounds;
    //CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    if(flag == 0)
    {
        UIView *mirrorView = [[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view snapshotViewAfterScreenUpdates:NO];
    
        [[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view setHidden:YES];
    
        UIView *container = [transitionContext containerView];
        //[container addSubview:mirrorView];
        [container addSubview:toVC.view];
        [toVC.view insertSubview:mirrorView atIndex:0 ];
    
        
        [UIView animateWithDuration:duration animations:^{
            CGSize size = [UIScreen mainScreen].bounds.size;
            mirrorView.frame = CGRectMake(size.width*0.05, size.height*0.05, size.width*0.9, size.height*0.9);
            UIView *view = [toVC.view viewWithTag:1000];
            //[UIView animateWithDuration:.5 animations:^{
            if(view)
                [view setFrame:CGRectMake(0, size.height - 240, size.width, 240)];
            //} completion:nil];
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
            [[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view setHidden:NO];
        }];
    }
    else
    {
        UIView *mirrorView = [fromVC.view.subviews objectAtIndex:0];
        [UIView animateWithDuration:duration animations:^{
            CGSize size = [UIScreen mainScreen].bounds.size;
            UIView *pick = [fromVC.view viewWithTag:1000];
            if(pick)
            {
                CGRect frame = pick.frame;
                frame.origin.y = size.height;
                [pick setFrame:frame];
            }
            mirrorView.frame = [UIScreen mainScreen].bounds;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
}


@end
