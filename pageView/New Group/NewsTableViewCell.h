//
//  NewsTableViewCell.h
//  pageView
//
//  Created by 张传伟 on 2018/7/9.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface NewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;
@property (weak, nonatomic) IBOutlet UILabel *introlab;
@property (weak, nonatomic) IBOutlet UILabel *countlab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property(nonatomic,strong)NewsModel * model;
@end
