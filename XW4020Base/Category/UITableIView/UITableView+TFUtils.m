//
//  UITableView+TFUtils.m
//  SCGov
//
//  Created by XuWen on 2019/11/29.
//  Copyright © 2019 solehe. All rights reserved.
//

#import "UITableView+TFUtils.h"


@implementation UITableView (TFUtils)
- (void)commonTableViewConfig {
    [self commonScrollViewConfig];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor whiteColor];
}
@end


@implementation UIScrollView (XWUtils)
- (void)commonScrollViewConfig {
    [self setShowsHorizontalScrollIndicator:NO];
    [self setShowsVerticalScrollIndicator:NO];
    self.backgroundColor = [UIColor clearColor];
    self.pagingEnabled = NO;
    self.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

@end

@implementation UITableViewCell (Custom)
- (void)commonTableViewCellConfig {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
}


@end

