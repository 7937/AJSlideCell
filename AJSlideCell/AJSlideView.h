//
//  JSlideView.h
//  SlideCell
//
//  Created by 7937 on 2017/3/7.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SlideViewType){
    SlideViewTypeWillDelete = 0,
    SlideViewTypeDidDelete,
    SlideViewTypeWillDone,
    SlideViewTypeDidDone
};

@interface AJSlideView : UIView

@property (nonatomic, assign) SlideViewType viewType;

@property (nonatomic) UIColor *inactiveRightColor;
@property (nonatomic) UIColor *activeRightColor;
@property (nonatomic) UIColor *inactiveLeftColor;
@property (nonatomic) UIColor *activeleftColor;



- (void)setTypeOfSlideView:(SlideViewType )type;
- (NSInteger)activeSlideView:(CGFloat )currentX;

@end
