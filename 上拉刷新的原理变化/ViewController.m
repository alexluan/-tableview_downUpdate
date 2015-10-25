//
//  ViewController.m
//  上拉刷新的原理变化
//
//  Created by 栾有数 on 15/10/25.
//  Copyright © 2015年 栾有数. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+footerFresh.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation ViewController
{
    int mum;
}
- (IBAction)update:(id)sender {
    mum+=5;
    [self.mainTableView footerBeginRefreshing];
    [self.mainTableView reloadData];
}
- (IBAction)stopupdate:(id)sender {
    [self.mainTableView footerEndRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    mum = 5;
    // Do any additional setup after loading the view, typically from a nib.
    self.mainTableView.tableFooterView = [[UIView alloc]init];
    self.mainTableView.delegate=self;
    self.mainTableView.dataSource=self;
    [self.mainTableView setFooter:self action:@selector(ttt)];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    return  cell;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return mum;
}

-(void)ttt{
    mum+=5;
    [self.mainTableView reloadData];
    [self stopupdate:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
