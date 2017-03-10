//
//  TableViewController.m
//  testCell
//
//  Created by 7937 on 2017/3/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "TableViewController.h"
#import "AJSlideGestureRecognizer.h"

NSString *const cellReuseID = @"cell reuse ID";

@interface TableViewController ()<UITableViewDelegate, UITableViewDataSource>

{
    NSMutableArray *textArr;
}
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    textArr = [NSMutableArray new];
    textArr = [NSMutableArray arrayWithObjects:@"很长很长很长很长很长很长的中文",@"123",@"xixixixi",@"",@"上面为空", nil];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 50;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return textArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseID forIndexPath:indexPath];
    cell.textLabel.text = textArr[indexPath.row];
    AJSlideGestureRecognizer *recognizer = [[AJSlideGestureRecognizer alloc]initWithArray:textArr];
    
    [cell addGestureRecognizer:recognizer];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
