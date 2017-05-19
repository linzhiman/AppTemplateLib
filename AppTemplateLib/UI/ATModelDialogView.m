//
//  ATModelDialogView.m
//  yyfe
//
//  Created by linzhiman on 16/2/25.
//  Copyright © 2016年 yy.com. All rights reserved.
//

#import "ATModelDialogView.h"
#import "ATGlobalMacro.h"

static const int ATModelDialogView_BG_TAG = 20150618;
static const int ATModelDialogView_CustomView_TAG = 20150619;

@implementation ATModelDialogView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.7;
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

+ (void)showWithCustomView:(UIView *)aView
{
    [self hide];
    
    CGRect frame = CGRectMake(0, 0, ATScreenWidth, ATScreenHeight);
    ATModelDialogView *modelView = [[ATModelDialogView alloc] initWithFrame:frame];
    modelView.tag = ATModelDialogView_BG_TAG;
    
    CGRect viewFrame = aView.bounds;
    viewFrame.origin.x = (ATScreenWidth - viewFrame.size.width) / 2;
    viewFrame.origin.y = (ATScreenHeight - viewFrame.size.height) / 2;
    aView.frame = viewFrame;
    aView.tag = ATModelDialogView_CustomView_TAG;
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:modelView];
    [window addSubview:aView];
}

+ (void)hide
{
    [self removeSubViewWithTag:ATModelDialogView_BG_TAG];
    [self removeSubViewWithTag:ATModelDialogView_CustomView_TAG];
}

+ (void)removeSubViewWithTag:(NSInteger)tag
{
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView *aView = [window viewWithTag:tag];
    if (aView) {
        [aView removeFromSuperview];
    }
}

@end
