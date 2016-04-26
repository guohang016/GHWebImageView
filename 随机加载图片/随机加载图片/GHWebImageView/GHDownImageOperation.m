//
//  GHDownImageOperation.m
//  随机加载图片
//
//  Created by  郭航 on 16/4/9.
//  Copyright © 2016年  郭航. All rights reserved.
//

#import "GHDownImageOperation.h"
#import "NSString+sandBox.h"

@interface GHDownImageOperation ()

@property(copy,nonatomic) NSString *URLStr;
@property(copy,nonatomic) void(^block)(UIImage *);

@end

@implementation GHDownImageOperation

+(instancetype)downImageOperationWithURLStr:(NSString *)URLStr finishBlock:(void (^)(UIImage *))block{
    GHDownImageOperation *operation = [[GHDownImageOperation alloc]init];
    operation.URLStr = URLStr;
    operation.block = block;
    return operation;
}

-(void)main{
    @autoreleasepool {
        NSLog(@"正在从网络下载");
        //[NSThread sleepForTimeInterval:1.0];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.URLStr]];
        
        [data writeToFile:[self.URLStr appendCachePath] atomically:YES];
        
        UIImage *image = [UIImage imageWithData:data];
        
        if (self.isCancelled) {
            return;
        }
        
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            if (self.block) {
                self.block(image);
            } else {
                NSLog(@"block 为空");
            }
        }];
    }
}

@end
