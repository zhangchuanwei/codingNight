//
//  NewsTableViewCell.m
//  pageView
//
//  Created by 张传伟 on 2018/7/9.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import "NewsTableViewCell.h"
//#import <SDWebImageManager.h>
@implementation NewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(NewsModel *)model
{
    _model = model;
    
    self.introlab.text = model.intro;
    self.countlab.text = model.browseCount;
    for (NSDictionary *dic in model.tags) {
        self.typeLab.text = dic[@"name"];
    }
    NSURL * url =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",IMAGEURL,model.banner]];
    [self.rightImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""] options:SDWebImageProgressiveDownload progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        NSLog(@"receivedSize==%ld,expectedSize===%ld,targetURL==%@",receivedSize,expectedSize,targetURL);
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        NSLog(@"image==%@,error==%@,cacheType==%ld,imageURL=%@",image,error,(long)cacheType,imageURL);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
