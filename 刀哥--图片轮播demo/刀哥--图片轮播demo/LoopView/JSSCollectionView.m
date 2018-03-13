//
//  JSSCollectionView.m
//  刀哥--图片轮播demo
//
//  Created by jss on 2018/3/3.
//  Copyright © 2018年 jss. All rights reserved.
//

#import "JSSCollectionView.h"
#import "JSSLayout.h"
#import "JSSCollectionViewCell.h"

NSString *const cellId = @"cellID";

@interface JSSCollectionView() <UICollectionViewDataSource,UICollectionViewDelegate>

@end
//独立的处理轮播器相关的所有代码逻辑
@implementation JSSCollectionView{
    NSArray <NSURL *> *_urls;
}

- (instancetype)initWithURLs:(NSArray <NSURL *> *)urls
{
    //自定义的CollectionViewFlowLayout
    JSSLayout *layout = [JSSLayout new];
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        _urls = urls;
        self.dataSource = self;
        self.delegate = self;
        //注册cell
        [self registerClass:[JSSCollectionViewCell class] forCellWithReuseIdentifier:cellId];
        
        //初始显示第二组[0,1,2] [3(_urls.count),4,5]
        //在开发中,什么时候使用多线程,不要和我说AFN!
        //主队列 : 1.安排任务到主线程执行
                //2.如果主线程当前有任务,主队列暂时不调度任务!
        dispatch_async(dispatch_get_main_queue(), ^{
    
            NSIndexPath *indepath = [NSIndexPath indexPathForItem:_urls.count inSection:0];
            
            //滚动位置
            [self scrollToItemAtIndexPath:indepath atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
        });
    }
    return self;
}
#pragma mark -UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return _urls.count *2;
    //这样子的好处 就是当用户在拖拽到最后一个item的时候,再往后面拖动,就会调用下边的if语句里面的 offset = _urls.count - 1;方法,这个方法里面更改了offset,如果组数太少,每次很容易就拖到了最后一页,到最后一页就要更改offset,更改了offset就要重新设置collectionview的offset,在重新设置offset的时候可能会造成滑动的时候会卡顿,所以这里写到了组数*100个item,让用户很难拖到最后一个item,所以就巧妙的解决了用的拖拽卡顿的问题
    return _urls.count *100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    JSSCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];

    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];

    cell.url = _urls[indexPath.item % _urls.count];
    return cell;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    //获取当前停止的页面
    NSInteger offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
//    NSLog(@"%zd",offset );
    
    //滑动到(最前面一个item)第0页跳转到 第1组的第0页
    //滑动到(最最后一个item)最后一页跳转到第0组的最后一页
    
    //拿到collectonView的item的总个数
    NSLog(@"%zd",[self numberOfItemsInSection:0]);
    //[self numberOfItemsInSection:0] - 1 表示CollectionView的最后一个item的下标
    if (offset == 0 || offset == [self numberOfItemsInSection:0] - 1) {
        //只有在第1个item 下标为0,最后一个item ,下标为5的时候才打印
        NSLog(@"%zd",offset);
        if (offset == 0) { //第一个item
            offset = _urls.count;//count是3 下标确是4,刚好是第二组的第一个
        }else{//最后一个item
            offset = _urls.count - 1;//刚好是第一组的最后一个,下标是2
        }
    }
    //重新调整contentoffset
    scrollView.contentOffset = CGPointMake(offset * scrollView.bounds.size.width, 0);
    
    
}

@end
