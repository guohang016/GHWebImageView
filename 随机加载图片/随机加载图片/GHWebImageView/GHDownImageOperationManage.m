//
//  GHDownImageOperationManage.m
//  随机加载图片
//
//  Created by  郭航 on 16/4/9.
//  Copyright © 2016年  郭航. All rights reserved.
//

#import "GHDownImageOperationManage.h"
#import "GHDownImageOperation.h"
#import "NSString+sandBox.h"

@interface GHDownImageOperationManage ()

@property(strong,nonatomic) NSOperationQueue *queue;
@property(strong,nonatomic) NSMutableDictionary *operationCache;
@property(strong,nonatomic) NSMutableDictionary *imageCache;

@end

@implementation GHDownImageOperationManage

-(NSDictionary *)operationCache{
    if (!_operationCache) {
        _operationCache = [NSMutableDictionary dictionary];
    }
    return _operationCache;
}

-(NSDictionary *)imageCache{
    if (!_imageCache) {
        _imageCache = [NSMutableDictionary dictionary];
    }
    return _imageCache;
}

-(NSOperationQueue *)queue{
    if (!_queue) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}

+(instancetype)shareDownImageOperationManage{
    static GHDownImageOperationManage *operationManage;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!operationManage) {
            operationManage = [GHDownImageOperationManage new];
        }
    });
    
    return operationManage;
}

- (void)downImageWithURLStr:(NSString *)URLStr finishBlock:(void (^)(UIImage *))block{
    if ([self checkImageCacheWithURLStr:URLStr]) {
        block(self.imageCache[URLStr]);
    } else {
        GHDownImageOperation *operation = [GHDownImageOperation downImageOperationWithURLStr:URLStr finishBlock:^(UIImage *image) {
            //NSAssert(block,@"block 没赋值");
            if (block) {
                block(image);
            } else {
                NSLog(@"block 为空");
            }
            
            self.imageCache[URLStr] = image;
        }];
        
        [self.queue addOperation:operation];
        
        self.operationCache[URLStr] = operation;
    }
}

-(BOOL)checkImageCacheWithURLStr:(NSString *)URLStr{
    if (self.imageCache[URLStr]) {
        NSLog(@"从缓存加载...");
        return YES;
    }
    NSData *data = [NSData dataWithContentsOfFile:[URLStr appendCachePath]];
    UIImage *image = [UIImage imageWithData:data];
    if (image) {
        NSLog(@"从沙盒中加载");
        self.imageCache[URLStr] = image;
        return YES;
    }
    return NO;
}

- (void)cancelOperationWithURLStr:(NSString *)string{
    if (string) {
        [self.operationCache[string] cancel];
        
        [self.operationCache removeObjectForKey:string];
    }
}

@end
