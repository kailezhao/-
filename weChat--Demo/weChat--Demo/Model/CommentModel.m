//
//  CommentModel.m
//  weChat--Demo
//
//  Created by WT－WD on 16/11/1.
//  Copyright © 2016年 WT－WD. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

-(instancetype)initWithDict:(NSDictionary*)dict{
   self = [super init];
    if (self) {
        self.commentId          = dict[@"commentId"];
        self.commentUserId      = dict[@"commentUserId"];
        self.commentUserName    = dict[@"commentUserName"];
        self.commentPhoto       = dict[@"commentPhoto"];
        self.commentText        = dict[@"commentText"];
        self.commentByUserId    = dict[@"commentByUserId"];
        self.commentByUserName  = dict[@"commentByUserName"];
        self.commentByPhoto     = dict[@"commentByPhoto"];
        self.createDateStr      = dict[@"createDateStr"];
        self.checkStatus        = dict[@"checkStatus"];

    }
    return self;
}

-(NSMutableArray *)commentModelArray{
    if (!_commentModelArray) {
        _commentModelArray = [[NSMutableArray alloc]init];
    }
    return _commentModelArray;
}

-(NSMutableArray *)messageBigPicArray{
    if (!_messageBigPicArray) {
       _messageBigPicArray = [NSMutableArray array];
    }
    return _messageBigPicArray;
}


@end
