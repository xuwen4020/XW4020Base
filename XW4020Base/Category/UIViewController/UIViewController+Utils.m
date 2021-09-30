//
//  ViewController+Utils.m
//  SCGov
//
//  Created by solehe on 2019/7/29.
//  Copyright © 2019 solehe. All rights reserved.
//

#import "UIViewController+Utils.h"

@implementation UIViewController (Utils)

- (void)customBackAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}

/**push*/
- (void)navPushToVC:(NSString *)vcName
{
    UIViewController *vc = [[NSClassFromString(vcName) alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
