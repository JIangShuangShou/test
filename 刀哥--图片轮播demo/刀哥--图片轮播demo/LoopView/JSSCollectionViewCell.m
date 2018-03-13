//
//  JSSCollectionViewCell.m
//  刀哥--图片轮播demo
//
//  Created by jss on 2018/3/4.
//  Copyright © 2018年 jss. All rights reserved.
//

#import "JSSCollectionViewCell.h"

@implementation JSSCollectionViewCell{
    UIImageView *_imageView;
}

//collectionViewCell的frame是根据之前的layout已经确定好的!!
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //NSLog(@"%@",NSStringFromCGRect(frame));
        //添加图像视图
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

-(void)setUrl:(NSURL *)url{
    
    _url = url;
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:data];
    _imageView.image = img;
}
@end
