//
//  GHDownImageOperationManage.h
//  随机加载图片
//
//  Created by  郭航 on 16/4/9.
//  Copyright © 2016年  郭航. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHDownImageOperationManage : NSObject

+ (instancetype)shareDownImageOperationManage;
- (void)downImageWithURLStr:(NSString *)URLStr finishBlock:(void(^)(UIImage *)) block;
- (void)cancelOperationWithURLStr:(NSString *)string;

@end
