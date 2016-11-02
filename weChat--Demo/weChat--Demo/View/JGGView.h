//
//  JGGView.h
//  weChat--Demo
//
//  Created by WT－WD on 16/11/1.
//  Copyright © 2016年 WT－WD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDPhotoBrowser.h"
///九宫格图片间隔
#define kJGG_GAP 5
/**
 点击图片的block

 @param index      点击index
 @param dataSource 数据源
 @param indexPath  <#indexPath description#>
 */
typedef void (^TapBlock)(NSInteger index,NSArray *dataSource,NSIndexPath *indexPath);


@interface JGGView : UIView<SDPhotoBrowserDelegate>
/**
 *  九宫格显示的数据源，dataSource中可以放UIImage对象和NSString(http://sjfjfd.cjf.jpg)，还有NSURL也可以
 */
@property (nonatomic, retain)NSArray * dataSource;
/**
 *  TapBlcok
 */
@property (nonatomic, copy)TapBlock  tapBlock;
/**
 *  TapBlcok
 */
@property (nonatomic, copy)NSIndexPath  *indexpath;
/**
 *  Description 九宫格
 *
 *  @param frame      frame
 *  @param dataSource 数据源
 *  @param tapBlock tapBlock点击的block
 *  @return JGGView对象
 */
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray *)dataSource completeBlock:(TapBlock )tapBlock;


/**
 *  Description 九宫格
 *
 *  @param dataSource 数据源
 *  @param tapBlock tapBlock点击的block
 *  @return JGGView对象
 */
-(void)JGGView:(JGGView *)jggView DataSource:(NSArray *)dataSource completeBlock:(TapBlock)tapBlock;

/**
 *  配置图片的宽（正方形，宽高一样）
 *
 *  @return 宽
 */
+(CGFloat)imageWidth;
/**
 *  配置图片的高（正方形，宽高一样）
 *
 *  @return 高
 */
+(CGFloat)imageHeight;
@end
