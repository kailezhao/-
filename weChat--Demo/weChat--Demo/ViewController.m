//
//  ViewController.m
//  weChat--Demo
//
//  Created by WT－WD on 16/11/1.
//  Copyright © 2016年 WT－WD. All rights reserved.
//

#import "ViewController.h"
#import "MessageModel.h"
#import "Masonry.h"
#import "MessageCell.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"

//键盘
//#import "ChatKeyBoard.h"
//#import "FaceSourceManager.h"
//#import "MoreItem.h"
//#import "ChatToolBarItem.h"
//#import "FaceThemeModel.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,MessageCellDelegate/*,ChatKeyBoardDelegate,ChatKeyBoardDataSource,UIScrollViewDelegate*/>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
//@property (nonatomic,strong)ChatKeyBoard *chatKeyBoard;//自定义键盘
@property (nonatomic, assign) CGFloat history_Y_offset;//记录table的offset.y
@property (nonatomic, assign) CGFloat seletedCellHeight;//记录点击cell的高度，高度由代理传过来
//专门用来回复选中的cell的model
@property(nonatomic,strong)CommentModel *replayTheSeletedCellModel;

@property (nonatomic, assign) BOOL needUpdateOffset;//控制是否刷新table的offset

@property (nonatomic,copy)NSIndexPath *currentIndexPath;
@end

@implementation ViewController
/*
-(instancetype)init{
    if (self = [super init]) {
        //注册键盘出现NSNotification
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        //注册键盘隐藏NSNotification
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
  
    }
    return self;
}
-(NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems{
    ChatToolBarItem *item1 = [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"face" high:@"face_HL" select:@"keyboatd"];
//    ChatToolBarItem *item2 = [ChatToolBarItem barItemWithKind:kBarItemVoice normal:@"voice" high:@"voice_HL" select:@"keyboard"];
//
//    ChatToolBarItem *item3 = [ChatToolBarItem barItemWithKind:kBarItemMore normal:@"more_ios" high:@"more_ios_HL" select:nil];
//
//    ChatToolBarItem *item4 = [ChatToolBarItem barItemWithKind:kBarItemSwitchBar normal:@"switchDown" high:nil select:nil];
    
    return @[item1];
}

-(NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems{
    return [FaceSourceManager loadFaceSource];
}
-(ChatKeyBoard *)chatKeyBoard{
    if (!_chatKeyBoard) {
        _chatKeyBoard = [ChatKeyBoard keyBoardWithNavgationBarTranslucent:YES];
        _chatKeyBoard.delegate = self;
        _chatKeyBoard.dataSource = self;
        _chatKeyBoard.keyBoardStyle = KeyBoardStyleComment;
        _chatKeyBoard.allowVoice = NO;
        _chatKeyBoard.allowMore = NO;
        _chatKeyBoard.allowSwitchBar = NO;
        _chatKeyBoard.placeHolder = @"评论";
        [self.view addSubview:_chatKeyBoard];
        [self.view bringSubviewToFront:_chatKeyBoard];
    }
    return _chatKeyBoard;
}
#pragma mark - ChatKeyBoardDelegate
-(void)chatKeyBoardSendText:(NSString *)text{
    MessageModel *messageModel = [self.dataSource objectAtIndex:self.currentIndexPath.row];
    messageModel.shouldUpdateCache = YES;
    
    //创建一个新的commentModel,并且相应的属性赋值，然后加到评论数组的最后
    CommentModel *commentModel = [[CommentModel alloc]init];
    commentModel.commentUserName = @"流氓";
    commentModel.commentUserId = @"274";
    commentModel.commentPhoto = @"http://q.qlogo.cn/qqapp/1104706859/189AA89FAADD207E76D066059F924AE0/100";
    commentModel.commentByUserName = self.replayTheSeletedCellModel?self.replayTheSeletedCellModel.commentUserName:@"";
//    commentModel.commentId = [NSString stringWithFormat:@"",[]];
    commentModel.commentText = text;
    [messageModel.commentModelArray addObject:commentModel];
    
    messageModel.shouldUpdateCache = YES;
    [self reloadCellHeightForModel:messageModel atIndexPath:self.currentIndexPath];
    [self.chatKeyBoard keyboardDownForComment];
    self.chatKeyBoard.placeHolder = nil;
}
- (void)chatKeyBoardFacePicked:(ChatKeyBoard *)chatKeyBoard faceStyle:(NSInteger)faceStyle faceName:(NSString *)faceName delete:(BOOL)isDeleteKey{
    NSLog(@"%@",faceName);
}
- (void)chatKeyBoardAddFaceSubject:(ChatKeyBoard *)chatKeyBoard{
    NSLog(@"%@",chatKeyBoard);
}
- (void)chatKeyBoardSetFaceSubject:(ChatKeyBoard *)chatKeyBoard{
    NSLog(@"%@",chatKeyBoard);
    
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"仿朋友圈";
    self.view.backgroundColor =[UIColor greenColor];
    
    //初始化数据
    [self initDataSourse];
    
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
//    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}
#pragma mark - 初始化数据
-(void)initDataSourse{
    self.dataSource = [[NSMutableArray alloc]init];
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"]]];
    NSDictionary *jsonDict =[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
   
    for (NSDictionary *dict in jsonDict[@"data"][@"rows"]) {
        
       MessageModel *model = [[MessageModel alloc]initWithDict:dict];
        [self.dataSource addObject:model];
    }
}
#pragma mark - UITableViewDelegate && UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"messageCell";
    
    MessageCell *cell = [self.tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell =[[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        cell.delegate =self;
    }else{
        NSLog(@"MessageCell 复用了！！！");
    }
    
    UIWindow *window =[UIApplication sharedApplication].keyWindow;
    __weak typeof(self) weakSelf = self;
    __weak typeof(_tableView) weakTable = _tableView;
    __weak typeof(window) weakWindow = window;
    
    __block MessageModel *model =[self.dataSource objectAtIndex:indexPath.row];
    //传值
    [cell configCellWithModel:model indexPath:indexPath];
    cell.backgroundColor =[UIColor whiteColor];
    //评论
    cell.CommentBtnClickBlock = ^(UIButton *commentBtn,NSIndexPath * indexPath){
    //不是点击cell进行回复，则置空replayTheSeletedCellModel，因为这个时候是点击评论按钮进行评论，不是回复某某某
        self.replayTheSeletedCellModel = nil;
        weakSelf.seletedCellHeight = 0.0;
        weakSelf.needUpdateOffset = YES;
        
//        weakSelf.chatKeyBoard.placeHolder = [NSString stringWithFormat:@"评论%@",model.userName];
        
        weakSelf.history_Y_offset = [commentBtn convertRect:commentBtn.bounds toView:weakWindow].origin.y;
        weakSelf.currentIndexPath = indexPath;
        
//        [weakSelf.chatKeyBoard keyboardUpforComment];
    };
    
    //更多
    cell.MoreBtnClickBlock = ^(UIButton *moreBtn,NSIndexPath *indexPath){
        
//        [weakSelf.chatKeyBoard keyboardDownForComment];
//        weakSelf.chatKeyBoard.placeHolder = nil;
        
        model.isExpand = !model.isExpand;
        model.shouldUpdateCache = YES;
        [weakTable reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationNone)];
        
    };
    
    //点击九宫格
    cell.tapImageBlock = ^(NSInteger index,NSArray *dataSource,NSIndexPath *indexpath){
//        [weakSelf.chatKeyBoard keyboardDownForComment];
    };
    
    //点击文字
    cell.tapTextBlock = ^(UILabel *desLabel){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:desLabel.text delegate:weakSelf cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    };
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageModel *messageModel =[self.dataSource objectAtIndex:indexPath.row];
    
    CGFloat h =[MessageCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
        
        MessageCell *cell =(MessageCell*)sourceCell;
        [cell configCellWithModel:messageModel indexPath:indexPath];
    
    } cache:^NSDictionary *{
        
        NSDictionary *cache =@{kHYBCacheUniqueKey : messageModel.cid,
                               kHYBCacheStateKey:@"",
                               kHYBRecalculateForStateKey:@(messageModel.shouldUpdateCache)};
        
        messageModel.shouldUpdateCache = NO;
        return cache;
    }];
    
    return h;
}
#pragma mark - passCellHeightWithModel
-(void)passCellHeightWithMessageModel:(MessageModel *)messageModel commentModel:(CommentModel *)commentModel atCommentIndexPath:(NSIndexPath *)commentIndexPath cellHeight:(CGFloat)cellHeight commentCell:(CommentCell *)commentCell messageCell:(MessageCell *)messageCell{
    
    self.needUpdateOffset = YES;
    self.replayTheSeletedCellModel = commentModel;
    self.currentIndexPath = [self.tableView indexPathForCell:messageCell];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.history_Y_offset =[commentCell.contentLabel convertRect:commentCell.contentLabel.bounds toView:window].origin.y;
    self.seletedCellHeight = cellHeight;
}

-(void)reloadCellHeightForModel:(MessageModel *)model atIndexPath:(NSIndexPath *)indexPath{
    model.shouldUpdateCache = YES;
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationFade)];
}


#pragma mark
#pragma mark keyboardWillShow
/*
- (void)keyboardWillShow:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    __block  CGFloat keyboardHeight = [aValue CGRectValue].size.height;
    if (keyboardHeight==0) {//解决搜狗输入法三次调用此方法的bug、
        //        IOS8.0之后可以安装第三方键盘，如搜狗输入法之类的。
        //        获得的高度都为0.这是因为键盘弹出的方法:- (void)keyBoardWillShow:(NSNotification *)notification需要执行三次,你如果打印一下,你会发现键盘高度为:第一次:0;第二次:216:第三次:282.并不是获取不到高度,而是第三次才获取真正的高度.
        return;
    }
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect newTextViewFrame = self.view.bounds;
    newTextViewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    CGFloat delta = 0.0;
    if (self.seletedCellHeight){//点击某行，进行回复某人
        delta = self.history_Y_offset - ([UIApplication sharedApplication].keyWindow.bounds.size.height - keyboardHeight-self.seletedCellHeight-49);
    }else{//点击评论按钮
        delta = self.history_Y_offset - ([UIApplication sharedApplication].keyWindow.bounds.size.height - keyboardHeight-49-24-10);//24为评论按钮高度，10为评论按钮上部的5加评论按钮下部的5
    }
    CGPoint offset = self.tableView.contentOffset;
    offset.y += delta;
    if (offset.y < 0) {
        offset.y = 0;
    }
    if (self.needUpdateOffset) {
        [self.tableView setContentOffset:offset animated:YES];
    }
}
*/
#pragma mark
#pragma mark keyboardWillHide
/*
- (void)keyboardWillHide:(NSNotification *)notification {
    //    NSValue *animationDurationValue = [notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    //    NSTimeInterval animationDuration;
    //    [animationDurationValue getValue:&animationDuration];
    //    [UIView animateWithDuration:animationDuration animations:^{
    //    }];
    self.needUpdateOffset = NO;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.chatKeyBoard keyboardDownForComment];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"CommentViewController didReceiveMemoryWarning");
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self.chatKeyBoard keyboardDownForComment];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"CommentViewController dealloc");
}
*/


@end
