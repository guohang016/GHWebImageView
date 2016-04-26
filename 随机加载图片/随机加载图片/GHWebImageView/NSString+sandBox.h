//
//  NSString+sandBox.h
//  获取沙盒路径
//
//  Created by  郭航 on 16/4/7.
//  Copyright © 2016年  郭航. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (sandBox)

-(NSString *)appendCachePath;
-(NSString *)appendDocumentPath;
-(NSString *)appendTempPath;

@end
