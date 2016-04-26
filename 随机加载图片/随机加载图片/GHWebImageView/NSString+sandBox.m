//
//  NSString+sandBox.m
//  获取沙盒路径
//
//  Created by  郭航 on 16/4/7.
//  Copyright © 2016年  郭航. All rights reserved.
//

#import "NSString+sandBox.h"

@implementation NSString (sandBox)

-(NSString *)appendCachePath{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[self lastPathComponent]];
}

-(NSString *)appendDocumentPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:[self lastPathComponent]];
}

-(NSString *)appendTempPath{
    return [NSTemporaryDirectory() stringByAppendingPathComponent:[self lastPathComponent]];
}

@end
