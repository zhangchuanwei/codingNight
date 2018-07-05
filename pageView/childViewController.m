//
//  childViewController.m
//  pageView
//
//  Created by 张传伟 on 2018/7/5.
//  Copyright © 2018年 张传伟. All rights reserved.
//

#import "childViewController.h"

@interface childViewController ()

@end

@implementation childViewController
+(childViewController *)creatWithIndex:(int)index{
    childViewController * con = [[childViewController alloc]init];
    con.indexLabel = [[UILabel alloc]initWithFrame:CGRectMake(110, 200, 100, 30)];
    con.indexLabel.text = [NSString stringWithFormat:@"第%d页",index];
    [con.view addSubview:con.indexLabel];
    return con;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
