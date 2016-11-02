//
//  CommentCell.m
//  weChat--Demo
//
//  Created by WT－WD on 16/11/1.
//  Copyright © 2016年 WT－WD. All rights reserved.
//

#import "CommentCell.h"
#import "Masonry.h"
#import "CommentModel.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"

@interface CommentCell ()

@end


@implementation CommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:  reuseIdentifier];
    if (self) {
        [self customView];
    }
    return self;
}
-(void)customView{
    self.contentLabel  =[[UILabel alloc]init];
    [self.contentView addSubview:self.contentLabel];
    self.contentLabel.backgroundColor = [UIColor lightGrayColor];
    self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 10 -40 -2*10;
    
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = [UIFont systemFontOfSize:14.0];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).offset(3.0);//cell上部距离为3.0个间隙
    }];
    self.hyb_lastViewInCell = self.contentLabel;
    self.hyb_bottomOffsetToCell = 3.0;//cell底部距离为3.0个间隙
}

-(void)configCellWithModel:(CommentModel *)model{

    NSString *str = nil;
    if (![model.commentByUserName isEqualToString:@""]) {
        str = [NSString stringWithFormat:@"%@回复%@: %@",model.commentUserName,model.commentByUserName,model.commentText];
    }else{
        str = [NSString stringWithFormat:@"%@,%@",model.commentUserName,model.commentText];
    }
    
    NSMutableAttributedString  *text = [[NSMutableAttributedString alloc]initWithString:str];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor orangeColor]
                 range:NSMakeRange(0, model.commentUserName.length)];
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor orangeColor]
                 range:NSMakeRange(model.commentUserName.length+2, model.commentByUserName.length)];
    self.contentLabel.attributedText = text;
}


@end
