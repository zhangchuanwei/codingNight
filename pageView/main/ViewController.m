//
//  ViewController.m
//  pageView
//
//  Created by 张传伟 on 2018/7/4.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import "ViewController.h"
#import "MenuScrollView.h"
#import "childTableView.h"
#import "titlesModel.h"
#import "PagesView.h"
@interface ViewController ()<menuScrollviewDelegate,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,PagesViewDelegate>

@property(nonatomic,strong)UIScrollView *bgScroll;
@property(nonatomic,strong)MenuScrollView * menuScroll;
@property(nonatomic,strong)PagesView *pagesView;
@property(nonatomic,strong)NSMutableArray *titles;
@property(nonatomic,strong)UITableView *tabView;
@end
@implementation ViewController

-(UIScrollView *)bgScroll
{
    if (_bgScroll == nil) {
        _bgScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWdith, MainScreenHeight)];
        _bgScroll.delegate = self;
    }
    return  _bgScroll;
}

-(PagesView *)pagesView
{
    if (_pagesView == nil) {
        _pagesView = [[PagesView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWdith, MainScreenHeight - 44)];
        _pagesView.PagesDelsgate = self;
    }
    return _pagesView;
}
- (MenuScrollView *)menuScroll
{
    if (_menuScroll == nil) {
        _menuScroll = [[MenuScrollView alloc]initWithFrame:CGRectMake(0, 50, MainScreenWdith, 44)];
        _menuScroll.Delegate = self ;//当前的类来遵循代理
    }
    return _menuScroll;
}
    

-(NSMutableArray *)titles
{
    if (_titles == nil) {
        _titles = [NSMutableArray arrayWithCapacity:0];
    }
    return _titles ;
}


-(UITableView *)tabView
{
    if (_tabView == nil) {
        _tabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWdith, MainScreenHeight) style:UITableViewStylePlain];
        _tabView.dataSource = self;
        _tabView.delegate = self;
    }
    return _tabView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabView.translatesAutoresizingMaskIntoConstraints = NO;
    NSString *url =[NSString stringWithFormat:@"%@headline/tag",HOME_URL];
    [HttpTool getWithURL:url params:nil success:^(id json) {
        for (NSDictionary  * dic in json[@"content"]) {
            titlesModel *model = [[titlesModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            [self.titles addObject:model];
        }
        self.menuScroll.titleArray = self.titles;
        
        [self.view addSubview:self.tabView];
    } failure:^(NSError *error, NSInteger code) {
        
    }] ;

}

- (void)menuDidSelectBtnIndex:(NSInteger)index
{
    NSLog(@"当前选中的事第几个按钮%ld",index);
    
//    [_pageView s]

    [self.pagesView setUpPagesWithIndex:index];
}

 //pageview 的代理方法
-(void)PagesViewScrollToIndex:(NSInteger)index
{
    [self.menuScroll selectBtnWithindex:index];
}
-(void)PagesScrollOffset:(CGFloat)offSetY
{
    CGPoint taboffSet = self.tabView.contentOffset;
    NSLog(@"taboffSet.y ==%f",taboffSet.y );
    taboffSet.y = offSetY ;

    if (offSetY<self.tabView.contentSize.height - CGRectGetHeight(self.pagesView.frame)-44) {
        [self.tabView setContentOffset:taboffSet];
    }
    
}



#pragma mark - UITabViewdeledate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) return 1;
    
    return 2;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return self.menuScroll;
    }else
    {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MainScreenWdith, 10)];
        view.backgroundColor = [UIColor redColor];
        return view;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 44;
    }else
    {
        return 10;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        return MainScreenHeight;
    }else
    {
        return 44;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 2) {
        UITableViewCell * cell2 = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        if (cell2 == nil) {
            cell2 = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            self.pagesView.tag = 10;
            [cell2.contentView addSubview:self.pagesView];
        }
        
        self.pagesView.pages = self.titles;
        
        
        return cell2;
    }else
    {
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }

        return cell;
    }
    
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"scrollView==%f",scrollView.contentSize.height);
     NSLog(@"contentoffSet==%f",scrollView.contentOffset.y);
}

@end
