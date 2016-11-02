//
//  MessageModel.m
//  weChat--Demo
//
//  Created by WT－WD on 16/11/1.
//  Copyright © 2016年 WT－WD. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel

-(NSMutableArray *)commentModelArray{
    if (!_commentModelArray) {
        _commentModelArray = [NSMutableArray array];
    }
    return _commentModelArray;
}
-(NSMutableArray *)messageSmallPics{
    if (!_messageSmallPics) {
        _messageSmallPics = [NSMutableArray array];
    }
    return _messageSmallPics;
}
-(NSMutableArray *)messageBigPics{
    if (!_messageBigPics) {
        _messageBigPics = [NSMutableArray array];
    }
    return _messageBigPics;
}
-(instancetype)initWithDict:(NSDictionary*)dict{
   self= [super init];
    if (self) {
        
        self.cid                = dict[@"cid"];
        self.shouldUpdateCache  = NO;
        self.message_id         = dict[@"message_id"];
        self.message            = dict[@"message"];
        self.timeTag            = dict[@"timeTag"];
        self.message_type       = dict[@"message_type"];
        self.userId             = dict[@"userId"];
        self.userName           = dict[@"userName"];
        self.photo              = dict[@"photo"];
        self.messageSmallPics   = dict[@"messageSmallPics"];
        self.messageBigPics     = dict[@"messageBigPics"];
        
        for (NSDictionary *eachDic in dict[@"commentMessages"]) {
            CommentModel *commentModel = [[CommentModel alloc]initWithDict:eachDic];
            [self.commentModelArray addObject:commentModel];
        }

    }
    
    return self;
}
@end
