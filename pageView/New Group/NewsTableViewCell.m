//
//  NewsTableViewCell.m
//  pageView
//
//  Created by 张传伟 on 2018/7/9.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import "NewsTableViewCell.h"
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
    
      UIImage *originalImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[NSString stringWithFormat:@"%@%@",IMAGEURL,model.banner]];
    if (originalImage) {
        self.rightImageView.image = originalImage;
    }else
    {
//         [self.rightImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHoldImage"]];
        
        [self.rightImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeHoldImage"] options:SDWebImageRetryFailed];
    }
   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
