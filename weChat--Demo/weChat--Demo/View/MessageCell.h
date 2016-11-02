//
//  MessageCell.h
//  weChat--Demo
//
//  Created by WT－WD on 16/11/1.
//  Copyright © 2016年 WT－WD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentCell.h" 
#import "JGGView.h"
@class MessageCell;
@class MessageModel;


@protocol MessageCellDelegate <NSObject>

-(void)reloadCellHeightForModel:(MessageModel*)model atIndexPath:(NSIndexPath*)indexPath;
-(void)passCellHeightWithMessageModel:(MessageModel*)messageModel commentModel:(CommentModel *)commentModel atCommentIndexPath:(NSIndexPath*)commentIndexPath cellHeight:(CGFloat)cellHeight commentCell:(CommentCell*)commentCell messageCell:(MessageCell*)messageCell;

@end


@interface MessageCell : UITableViewCell

@property(nonatomic,strong)JGGView *jggView;

/**
 评论按钮的block
 */
@property(nonatomic,copy)void(^CommentBtnClickBlock)(UIButton *commentBtn,NSIndexPath *indexPath);

/**
 更多按钮的block
 */
@property(nonatomic,copy)void(^MoreBtnClickBlock)(UIButton *moreBtn,NSIndexPath *indexPath);

/**
 点击图片的block
 */
@property(nonatomic,copy)TapBlock tapImageBlock;

/**
 点击文字的block
 */
@property(nonatomic,copy)void(^tapTextBlock)(UILabel *desLabel);

@property(nonatomic,weak)id<MessageCellDelegate> delegate;

-(void)configCellWithModel:(MessageModel *)model indexPath:(NSIndexPath *)indexPath;








@end
