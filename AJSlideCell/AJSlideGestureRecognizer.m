//
//  JSlideGestureRecognizer.m
//  SlideCell
//
//  Created by 7937 on 2017/3/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "AJSlideGestureRecognizer.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define CELL_HEIGHT self.cell.frame.size.height

@interface AJSlideGestureRecognizer()<UIGestureRecognizerDelegate>{
    CGFloat currentX;
    CGRect beginCell;
}

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UITableViewCell *cell;


@end

@implementation AJSlideGestureRecognizer

- (instancetype)initWithArray:(NSMutableArray *)textArray{
    if (self = [super init]) {
        self.delegate = self;
        [self addTarget:self action:@selector(handleGesture)];
        
        _tableView = [UITableView new];
        _cell = [UITableViewCell new];
        _slideView = [AJSlideView new];
        self.didTriggerDoneBlock = [self doneTriggerBlock:textArray];
        self.didTriggerDeleteBlock = [self deleteTriggerBlock:textArray];

    }
    return self;
    
}

- (UITableView *)tableView{
    return  (UITableView *)self.cell.superview.superview;
}

- (UITableViewCell *)cell{
    return (UITableViewCell *)self.view;
}

- (NSIndexPath *)indexPath {
    return [self.tableView indexPathForCell:self.cell];
}

- (void)handleGesture{
    if (self.state == UIGestureRecognizerStateBegan) {
        self.slideView.frame = self.cell.frame;
        beginCell = self.cell.frame;
    }else if (self.state == UIGestureRecognizerStateChanged){
        
        currentX = [self getCurrentPosition];
        CGFloat slideViewX;
        
        if (currentX > 0) {
            slideViewX = currentX -SCREEN_WIDTH;
        }else{
            slideViewX = currentX +SCREEN_WIDTH;
        }
        
        self.cell.center = CGPointMake(self.cell.frame.size.width/2.f+currentX, self.cell.center.y);
        
        self.slideView.frame = CGRectMake(slideViewX, self.cell.center.y-CELL_HEIGHT/2.f, SCREEN_WIDTH, CELL_HEIGHT);
        
        switch ([_slideView activeSlideView:currentX]) {
            case 0:
                [self.slideView setTypeOfSlideView:SlideViewTypeWillDelete];
                break;
            case 1:
                [self.slideView setTypeOfSlideView:SlideViewTypeDidDelete];
                break;
            case 2:
                [self.slideView setTypeOfSlideView:SlideViewTypeWillDone];
                break;
            case 3:
                [self.slideView setTypeOfSlideView:SlideViewTypeDidDone];
                break;
            default:
                NSLog(@"wrong code: %ld",(long)[_slideView activeSlideView:currentX]);
                break;
        }
        [self.cell.superview.superview insertSubview:self.slideView atIndex:0];
        
    }else if (self.state == UIGestureRecognizerStateEnded){
        switch ([_slideView activeSlideView:currentX]) {
            case 0:
                [self positiveOfDeleteAction];
                break;
            case 1:
                [self dismissDeleteTrigger];
                [self dismissActionView];
                break;
            case 2:
                [self positiveOfDoneAction];
                break;
            case 3:
                [self dismissDoneTrigger];
                [self dismissActionView];
                break;
            default:
                NSLog(@"wrong code: %ld",(long)[_slideView activeSlideView:currentX]);
                break;
                
        }
    }
    
}


- (CGFloat )getCurrentPosition{
    CGFloat horizontalPoint = [self translationInView:self.cell].x;
    return horizontalPoint;
}


- (void)positiveOfDoneAction{
    [UIView animateWithDuration:0.3 animations:^{
        self.cell.frame = beginCell;
        self.slideView.frame = CGRectMake(-SCREEN_WIDTH, self.cell.center.y-CELL_HEIGHT/2.f, SCREEN_WIDTH, CELL_HEIGHT);
    }];
}

- (void)positiveOfDeleteAction{
    [UIView animateWithDuration:0.3 animations:^{
        self.cell.frame = beginCell;
        self.slideView.frame = CGRectMake(SCREEN_WIDTH, self.cell.center.y-CELL_HEIGHT/2.f, SCREEN_WIDTH, CELL_HEIGHT);
    }];
}


- (void)dismissActionView {
    [UIView animateWithDuration:(0.5) animations:^{
        self.slideView.frame = CGRectMake(0, self.cell.center.y-CELL_HEIGHT/2.f, SCREEN_WIDTH, CELL_HEIGHT);
    } completion:^(BOOL finished) {
        [self.slideView removeFromSuperview];
        self.slideView.alpha = 1;
    }];
}


- (void)dismissDoneTrigger{
    [UIView animateWithDuration:(0.5) animations:^{
        self.didTriggerDoneBlock(self.tableView, [self indexPath]);
    }];
}

- (void)dismissDeleteTrigger{
    [UIView animateWithDuration:(0.5) animations:^{
        self.didTriggerDeleteBlock(self.tableView, [self indexPath]);
    } ];
}


- (SlideActionBlock)doneTriggerBlock:(NSMutableArray *)textArray {
    return ^(UITableView *tableView, NSIndexPath *indexPath) {
        [textArray removeObjectAtIndex:indexPath.row];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [tableView endUpdates];
    };
}

- (SlideActionBlock)deleteTriggerBlock:(NSMutableArray *)textArray {
    return ^(UITableView *tableView, NSIndexPath *indexPath) {
        [textArray removeObjectAtIndex:indexPath.row];
        [tableView beginUpdates];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView endUpdates];
    };
}



@end
