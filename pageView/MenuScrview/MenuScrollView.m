//
//  MenuScrollView.m
//  pageView
//
//  Created by 张传伟 on 2018/7/5.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import "MenuScrollView.h"

@interface MenuScrollView ()

@property(nonatomic,assign)NSInteger lastBtntag;
@property(nonatomic,strong)UIButton* lastBtn;
@end
@implementation MenuScrollView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

-(void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    CGFloat totolWd = 0.0 ;
    _lastBtntag  =  100 ;
    for (NSString *title in titleArray) {
        CGFloat Wd = [self calculateRowWidth:title] + 20;
        
        UIButton *btn = [[UIButton alloc]init];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.frame = CGRectMake(totolWd, 0, Wd, self.frame.size.height);
        totolWd += Wd;
        btn.tag = [titleArray indexOfObject:title] + 100 ;
        if (btn.tag == 100) {
            btn.selected = YES;
            btn.transform = CGAffineTransformMakeScale(1.3, 1.3);
            _lastBtn = btn;
        }
        [btn addTarget:self action:@selector(selectBtnclick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self setContentSize:CGSizeMake(totolWd, self.frame.size.height)];
        [btn setTitle:title forState:0];
        
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [self addSubview:btn];
    }
    
}
-(void)selectBtnclick:(UIButton *)btn
{
    
    _lastBtn.selected = NO;
    _lastBtn.transform = CGAffineTransformMakeScale(1, 1);
    btn.selected = YES;
    _lastBtn = btn;
    [UIView animateWithDuration:0.5 animations:^{
         btn.transform = CGAffineTransformMakeScale(1.3, 1.3);
    }];
    
    if (_Delegate) {
        [_Delegate respondsToSelector:@selector(menuDidSelectBtnIndex:)];
//        把选中的index传出去
        [_Delegate menuDidSelectBtnIndex:btn.tag - 100 ];
    }
}

- (CGFloat)calculateRowWidth:(NSString *)string {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 30)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}

@end
