//
//  childTableView.m
//  pageView
//
//  Created by 张传伟 on 2018/7/6.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import "childTableView.h"
#import "HttpTool.h"
#import "NewsModel.h"
#import "NewsTableViewCell.h"
@interface childTableView ()
{
    NSInteger _page;
}
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation childTableView


-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * name = NSStringFromClass([NewsTableViewCell class]);
    
    [self.tableView registerNib:[UINib nibWithNibName:name bundle:nil] forCellReuseIdentifier:name];
    self.tableView.tableFooterView =[UIView new];
    typeof(self) weakself = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        self->_page = 0;
        
        [weakself.dataArray removeAllObjects];
        
        [weakself getdata];
    }];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *foot =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakself getdata];
    }];
    
    
    self.tableView.mj_footer = foot;
    [self getdata];
    
    
}
-(void)getdata;
{
   NSString * urlStr  =[NSString stringWithFormat:@"%@headline?size=20&sort=%@&page=%ld&tagIds=%ld",HOME_URL,@"id,desc",_page,self.index+1];
    NSLog(@"urlStr == %@",urlStr);
    
    [HttpTool getWithURL:urlStr params:nil success:^(id json) {
        self->_page ++ ;
        
        NSLog(@"json ==%@",json);
        for (NSDictionary * dic in json[@"content"]) {
            NewsModel *model = [[NewsModel alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            
            [self.dataArray addObject:model];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSError *error, NSInteger code) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 85;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NewsTableViewCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NewsModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//监听滑动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    
    NSLog(@"offset === %f",offset);
    
    if (self.scrollViewOffSet) {
        self.scrollViewOffSet(offset);
    }
}

@end
