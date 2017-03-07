//
//  JSlideGestureRecognizer.h
//  SlideCell
//
//  Created by 7937 on 2017/3/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSlideView.h"

@interface JSlideGestureRecognizer: UIPanGestureRecognizer

typedef void(^SlideActionBlock)(UITableView *tableView, NSIndexPath *indexPath);

@property (nonatomic, copy) SlideActionBlock didTriggerDoneBlock;
@property (nonatomic, copy) SlideActionBlock didTriggerDeleteBlock;
@property (nonatomic, strong)JSlideView *slideView;

- (instancetype)initWithArray:(NSMutableArray *)textArray;

@end
