//
//  QJHomeViewController.m
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/24.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import "QJHomeViewController.h"
#import "QJTitleButton.h"
#import "QJHttpTool.h"
#import "QJAccount.h"
#import "QJStatus.h"
#import "QJUser.h"
#import "QJStatusFrame.h"
#import "QJStatusCell.h"
#import "QJStatusTool.h"
#import "QJHomeStatusParam.h"
#import "QJHomeStatusesResult.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"

@interface QJHomeViewController ()<MJRefreshBaseViewDelegate>
@property(nonatomic, strong)NSMutableArray  *statusFrames;
@property(nonatomic, weak) QJTitleButton *titleBtn;
@property(nonatomic, weak) MJRefreshFooterView *refreshFooterView;
@property(nonatomic, weak) MJRefreshHeaderView *refreshHeadView;
@end

@implementation QJHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self SetupNarBar];
    
    [self SetupNavTitleView];
    
    [self SetupUserData];
    
    [self SetupRefreshView];
    
    self.tableView.backgroundColor = RGB(226, 226, 226);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, QJStatueCellMargin, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)dealloc
{
    [self.refreshFooterView free];
    [self.refreshHeadView free];
}

- (void)refresh
{
    //if ([self.tabBarItem.badgeValue intValue] > 0) {
        [self.refreshHeadView beginRefreshing];
    //}
}

- (NSMutableArray *)statusFrames
{
    if(_statusFrames == nil){
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)SetupUserData
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    QJAccount *account = unArchiveAccount();
    params[@"access_token"] = account.access_token;
    params[@"uid"] = @(account.uid);
#warning 整个项目类似于此需日后改进，模仿微博的loadNewData&loadMoreData
    [QJHttpTool getWithURL:QJAPPGet_User_Url params:params success:^(id response) {
        QJUser *user = [QJUser objectWithKeyValues:(NSDictionary *)response];
        [self.titleBtn setTitle:user.name  forState:UIControlStateNormal];
        account.name = user.name;
        ArchiveAccount(account);
    } failure:^(NSError *error) {
        ALog(@"%@", error);
    }];
}

- (void)SetupRefreshView
{
    MJRefreshHeaderView *refreshHeadView = [MJRefreshHeaderView header];
    refreshHeadView.scrollView = self.tableView;
    refreshHeadView.delegate = self;
    [refreshHeadView beginRefreshing];
    self.refreshHeadView = refreshHeadView;
    
    MJRefreshFooterView *refreshFooterView = [MJRefreshFooterView footer];
    refreshFooterView.scrollView = self.tableView;
    refreshFooterView.delegate = self;
    self.refreshFooterView = refreshFooterView;
//    footer.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView){
//        
//    };
}

- (void)loadNewData
{
    self.tabBarItem.badgeValue = nil;
    QJAccount *account = unArchiveAccount();
    QJHomeStatusParam *param = [[QJHomeStatusParam alloc]init];
    param.access_token = account.access_token;
    param.count = @5;
    if(self.statusFrames.count){
        QJStatusFrame *statusFrame = [self.statusFrames firstObject];
        param.since_id = @([statusFrame.status.idstr longLongValue]);
    }
    [QJStatusTool homeStatusWithParam:param success:^(QJHomeStatusesResult *result) {
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        //[QJStatus objectArrayWithKeyValuesArray:response[@"statuses"]];
        for(QJStatus *status in result.statuses){
            QJStatusFrame *statusFrame = [[QJStatusFrame alloc]init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        NSMutableArray *tempStatusArray = [NSMutableArray array];
        [tempStatusArray addObjectsFromArray:statusFrameArray];
        [tempStatusArray addObjectsFromArray:self.statusFrames];
        self.statusFrames = tempStatusArray;
        
        [self.tableView reloadData];
        [self.refreshHeadView endRefreshing];
        [self ShowRefreshStatusCount:(int)statusFrameArray.count];
    } failure:^(NSError *error) {
        [self.refreshHeadView endRefreshing];
    }];
}

- (void)loadMoreData
{
    QJAccount *account = unArchiveAccount();
    QJHomeStatusParam *param = [[QJHomeStatusParam alloc]init];
    param.access_token = account.access_token;
    param.count = @5;
    if(self.statusFrames.count){
        QJStatusFrame *statusFrame = [self.statusFrames lastObject];
        param.max_id = @([statusFrame.status.idstr longLongValue] - 1);
    }

    [QJStatusTool homeStatusWithParam:param success:^(QJHomeStatusesResult *result) {
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        //[QJStatus objectArrayWithKeyValuesArray:response[@"statuses"]];
        for(QJStatus *status in result.statuses){
            QJStatusFrame *statusFrame = [[QJStatusFrame alloc]init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        
        [self.statusFrames addObjectsFromArray:statusFrameArray];
        
        [self.tableView reloadData];
        [self.refreshFooterView endRefreshing];
    } failure:^(NSError *error) {
        [self.refreshFooterView endRefreshing];
    }];
}
#pragma mark -- MJRefresh delegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if ([refreshView isKindOfClass:[MJRefreshHeaderView class]]) {
        [self loadNewData];
    }else{
        [self loadMoreData];
    }
}
#pragma mark ---MJRefresh delegate end

- (void)ShowRefreshStatusCount:(int)count
{
    UIButton *btn = [[UIButton alloc]init];
    [btn setBackgroundImage:[UIImage resizedImageWithName:@"timeline_new_status_background"] forState:UIControlStateNormal];
    
    //[btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];

    btn.userInteractionEnabled = NO;
    
    if (count) {
        [btn setTitle:[NSString stringWithFormat:@"共有%d条微博数据", count] forState:UIControlStateNormal];
    }else{
        [btn setTitle:@"没有微博数据" forState:UIControlStateNormal];
    }
    
    CGFloat btnH = 30;
    CGFloat btnY = 64 - btnH;
    CGFloat btnX = 0;
    CGFloat btnW = self.view.frame.size.width;
    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    
    [self.navigationController.view insertSubview:btn belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:1.0 animations:^{
        btn.transform = CGAffineTransformMakeTranslation(0 , btnH+2);
    }completion:^(BOOL finished) {
        
        if (iOS7_OR_LATER) {
            [UIView animateKeyframesWithDuration:0.7 delay:1.0 options:UIViewKeyframeAnimationOptionLayoutSubviews animations:^{
                btn.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                btn.hidden = YES;
            }];
        }else{
            [UIView animateWithDuration:0.7 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
                btn.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                btn.hidden = YES;
            }];
        }
        
    }];
}

- (void)SetupNarBar
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_friendsearch" selectedImageName:@"navigationbar_friendsearch_highlighted" taget:self action:@selector(Home_Click_Left_FriendSearchBtn)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:@"navigationbar_pop" selectedImageName:@"navigationbar_pop_highlighted" taget:self action:@selector(Home_Click_Right_Pop)];
}

- (void)SetupNavTitleView
{
    QJTitleButton *titleBtn = [[QJTitleButton alloc]init];
    titleBtn.frame = CGRectMake(0, 0, self.view.frame.size.width/3.0, 30);
    QJAccount *account = unArchiveAccount();
    if (account.name) {
        [titleBtn setTitle:account.name forState:UIControlStateNormal];
    }else{
        [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    }
    
    [titleBtn setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateSelected];
    [titleBtn addTarget:self action:@selector(Home_Click_TitleBtn:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleBtn;
    self.titleBtn = titleBtn;
}

- (void)Home_Click_TitleBtn:(QJTitleButton *)titleBtn
{
    titleBtn.selected = !titleBtn.isSelected;
//    if (titleBtn.currentImage == [UIImage imageWithName:@"navigationbar_arrow_down"]) {
//        [titleBtn setImage:[UIImage imageWithName:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
//    }else{
//        [titleBtn setImage:[UIImage imageWithName:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
//    }
}

- (void)Home_Click_Left_FriendSearchBtn
{
    
}

- (void)Home_Click_Right_Pop
{
    
}

#if 0
- (void)SetupStatusData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    QJAccount *account = unArchiveAccount();
    params[@"access_token"] = account.access_token;
    //params[@"count"] = @5;
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSMutableArray *statusFrameArray = [NSMutableArray array];
        NSArray *statusesArray = [QJStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        for(QJStatus *status in statusesArray){
            QJStatusFrame *statusFrame = [[QJStatusFrame alloc]init];
            statusFrame.status = status;
            [statusFrameArray addObject:statusFrame];
        }
        self.statusFrames = statusFrameArray;
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#endif

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QJStatusCell *cell = [QJStatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
//    UIViewController *vc = [[UIViewController alloc]init];
//    vc.view.backgroundColor = [UIColor greenColor];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- tableView delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QJStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    
    return statusFrame.cellHeight;
}

@end
