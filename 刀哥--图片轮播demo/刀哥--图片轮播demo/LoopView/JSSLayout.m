//
//  JSSLayout.m
//  刀哥--图片轮播demo
//
//  Created by jss on 2018/3/4.
//  Copyright © 2018年 jss. All rights reserved.
//

#import "JSSLayout.h"

@implementation JSSLayout
-(void)prepareLayout{
    [super prepareLayout];
    //在CollectionView的第一次布局的时候,被调用,此时CollectionView的frame 已经设置完毕直接利用
    NSLog(@"%@",self.collectionView);
    //直接用collctionView的属性设置布局
    self.itemSize = self.collectionView.bounds.size;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
}
@end
