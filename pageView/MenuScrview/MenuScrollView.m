//
//  MenuScrollView.m
//  pageView
//
//  Created by 张传伟 on 2018/7/5.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import "MenuScrollView.h"
#define MainScreenWdith  [UIScreen mainScreen].bounds.size.width
#define MainScreenHeight  [UIScreen mainScreen].bounds.size.height
@interface MenuScrollView ()

@property(nonatomic,assign)NSInteger lastBtntag;
@property(nonatomic,strong)UIButton* lastBtn;
@property(nonatomic,strong)UIView * bottomLine;
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
            self.bottomLine = [[UIView alloc]initWithFrame:CGRectMake(10, 39, Wd-20, 1)];
            self.bottomLine. backgroundColor = [UIColor redColor];
            [self addSubview:self.bottomLine];
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

    [self setupbottomLine:btn];
    
    [UIView animateWithDuration:0.5 animations:^{
         btn.transform = CGAffineTransformMakeScale(1.3, 1.3);
    }];
    //    移动下面的线
   
//    让标题居中
    [self setupTitleCenter:btn];
    
    if (_Delegate) {
        [_Delegate respondsToSelector:@selector(menuDidSelectBtnIndex:)];
//        把选中的index传出去
        [_Delegate menuDidSelectBtnIndex:btn.tag - 100 ];
    }
}
//外面穿进来的index 告诉menu要选中那个按钮
-(void)selectBtnWithindex:(NSInteger)index{
    
    UIButton *btn = [self viewWithTag:index + 100];
    
    [self selectBtnclick:btn];
}

-(void)setupbottomLine:(UIButton *)btn{
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:5.0 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bottomLine.frame = CGRectMake(btn.frame.origin.x + 10, 39, btn.frame.size.width - 20, 1);
    } completion:nil];
    
}
-(void)setupTitleCenter:(UIButton *)btn{
    CGPoint offsetPoint = self.contentOffset;
//    当按钮的位置唱过中间的时候带时还没有到达最大滑动距离的时候 scrllowview就是滑动按钮到中心的位置
    offsetPoint.x =  btn.center.x -  MainScreenWdith / 2 ;
     NSLog(@"btn.center.x==%f ,offsetPoint.x==%f ",btn.center.x,offsetPoint.x);
    //左边超出处理
    if (offsetPoint.x<0) offsetPoint.x = 0;
    //最远的滑动距离
    CGFloat maxX = self.contentSize.width - MainScreenWdith;
    NSLog(@"maxX==%f",maxX);
    //右边超出处理
    if (offsetPoint.x>maxX) offsetPoint.x = maxX;
    [self setContentOffset:offsetPoint animated:YES];
//    _radioBtn = btn;
}

- (CGFloat)calculateRowWidth:(NSString *)string {
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};  //指定字号
    CGRect rect = [string boundingRectWithSize:CGSizeMake(0, 30)/*计算宽度时要确定高度*/ options:NSStringDrawingUsesLineFragmentOrigin |
                   NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return rect.size.width;
}

@end
