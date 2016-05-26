//
//  LeoSegmentControl.h
//  LeoSegmentContol
//
//  Created by leo on 16/5/26.
//  Copyright © 2016年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>

enum HMSelectionIndicatorMode{
    HMSelectionIndicatorResizesToStringWidth = 0, // Indicator width will only be as big as the text width
    HMSelectionIndicatorFillsSegment = 1 // Indicator width will fill the whole segment
};

@interface LeoSegmentControl : UIControl
/*! @brief 存储标题名称的数组*/
@property (nonatomic, strong) NSMutableArray * sectionTitles;
/*! @brief 点击展开的block*/
@property (nonatomic, copy) void (^indexChangeBlock)(NSInteger index, NSInteger indexOld);
/*! @brief 点击回收的block*/
@property (nonatomic, copy) void (^indexCanceledBlock)(NSInteger indexOld);
/*! @brief segment字体风格*/
@property (nonatomic, strong) UIFont *font;
/*! @brief segment每段的字体颜色*/
@property (nonatomic, strong) UIColor * textColor;
/*! @brief segment每段选中的字体颜色*/
@property (nonatomic, strong) UIColor * textSelectedColor;
/*! @brief 背景颜色*/
@property (nonatomic, strong) UIColor *backgroundColor;
/*! @brief 点击后颜色*/
@property (nonatomic, strong) UIColor *selectionIndicatorColor;
/*! @brief segment类型*/
@property (nonatomic, assign) enum HMSelectionIndicatorMode selectionIndicatorMode;
/*! @brief 未选中的image*/
@property (nonatomic, strong) UIImage * imgNormal;
/*! @brief 选中状态image*/
@property (nonatomic, strong) UIImage * imgSelected;
/*! @brief 当前选中下标*/
@property (nonatomic, assign) NSInteger selectedIndex;
/*! @brief 高度*/
@property (nonatomic, readwrite) CGFloat height;
/*! @brief indicator的高度*/
@property (nonatomic, readwrite) CGFloat selectionIndicatorHeight;
/*! @brief 内边距*/
@property (nonatomic, readwrite) UIEdgeInsets segmentEdgeInset;


/**
 @brief 初始化标题
 @param 标题数组
 */
- (id)initWithSectionTitles:(NSArray *)sectiontitles;
/**
 @bried 选中某个index
 @param indexCur 当前下标
 **/
- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated;
/**
 @brief 选择某个segment 将上一个状态职位cancel
 @param indexCur oldItem
  **/
- (void)changeSelectItem:(NSInteger)indexCur oldItem:(NSInteger)indexSelected animated:(BOOL)animated;
/**
 @brief 更改section的title 
 @param nsstitle 标题文字 isection 第几个section
 **/
- (void)changeSectionTitle:(NSString *)nssTitle ofSection:(NSInteger)iSection;
- (void)setDefaults;

@end
