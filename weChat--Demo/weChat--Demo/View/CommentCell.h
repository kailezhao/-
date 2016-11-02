//
//  CommentCell.h
//  weChat--Demo
//
//  Created by WT－WD on 16/11/1.
//  Copyright © 2016年 WT－WD. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentModel;

@interface CommentCell : UITableViewCell

@property (nonatomic, strong) UILabel *contentLabel;

- (void)configCellWithModel:(CommentModel *)model;
@end
