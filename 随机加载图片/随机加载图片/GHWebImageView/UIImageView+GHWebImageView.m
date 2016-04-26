//
//  UIImageView+GHWebImageView.m
//  随机加载图片
//
//  Created by  郭航 on 16/4/9.
//  Copyright © 2016年  郭航. All rights reserved.
//

#import "UIImageView+GHWebImageView.h"
#import <objc/runtime.h>
#import "GHDownImageOperationManage.h"

#define lastAppIconKey "lastAppIconKey"

@interface UIImageView ()

@property (copy,nonatomic) NSString *lastAppIcon;

@end

@implementation UIImageView (GHWebImageView)

-(void)gh_setImageWithURLStr:(NSString *)URLStr{
    //快速切换时使用
    //[[GHDownImageOperationManage shareDownImageOperationManage] cancelOperationWithURLStr:self.lastAppIcon];
    
    [[GHDownImageOperationManage shareDownImageOperationManage] downImageWithURLStr:URLStr finishBlock:^(UIImage *image) {
        self.image = image;
    }];
    
    //self.lastAppIcon = URLStr;
}

-(void)setLastAppIcon:(NSString *)lastAppIcon{
    objc_setAssociatedObject(self, lastAppIconKey, lastAppIcon, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)lastAppIcon{
    return objc_getAssociatedObject(self, lastAppIconKey);
}

@end
