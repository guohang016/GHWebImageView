//
//  ViewController.m
//  随机加载图片
//
//  Created by  郭航 on 16/4/9.
//  Copyright © 2016年  郭航. All rights reserved.
//

#import "ViewController.h"
#import "GHAppModel.h"
#import "UIImageView+GHWebImageView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (strong,nonatomic) NSArray *appArray;

@end

@implementation ViewController

-(NSArray *)appArray{
    if (!_appArray) {
        _appArray = [GHAppModel appModelWithFilePath:[[NSBundle mainBundle] pathForResource:@"apps" ofType:@"plist"]];
    }
    return _appArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSInteger index = arc4random()%self.appArray.count;
    
    GHAppModel *model = self.appArray[index];
    
    [self.imageView gh_setImageWithURLStr:model.icon];
}

@end
