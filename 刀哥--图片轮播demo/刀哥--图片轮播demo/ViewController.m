//
//  ViewController.m
//  刀哥--图片轮播demo
//
//  Created by jss on 2018/2/15.
//  Copyright © 2018年 jss. All rights reserved.
//

#import "ViewController.h"
#import "JSSCollectionView.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSArray <NSURL *> *_urls;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    NSLog(@"%@",_urls);
    
   /*  测试copy和mutableCopy
    NSString *str = @"abc";
    NSString *copyStr = [str copy];
    NSString *mutablCopyStr = [str mutableCopy];
    NSLog(@" \n str= %p \n copyStr= %p \n utablCopyStr = %p",str,copyStr,mutablCopyStr);
    */
    
    //创建界面
    [self createCollectionView];
}
-(void)loadData{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        
        NSString *fileName = [NSString stringWithFormat:@"%zd.jpg",(i+1)];
        NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        [arrayM addObject:url];
    }
    _urls = arrayM.copy;
}
-(void)createCollectionView{
    
    JSSCollectionView *collectionView = [[JSSCollectionView alloc]initWithURLs:_urls];
    collectionView.frame = CGRectMake(20, 20, self.view.frame.size.width-40, 200);
    [self.view addSubview:collectionView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
