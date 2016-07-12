//
//  LiveViewController.m
//  LiveProject
//
//  Created by dd on 16/7/8.
//  Copyright © 2016年 dd. All rights reserved.
//

#import "LiveViewController.h"
#import "LiveFlowLayout.h"
#import "LiveViewCell.h"
#import "LiveListModel.h"

@interface LiveViewController ()
{
    LiveListModel *_liveListModel;
}

@end

@implementation LiveViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    return [super initWithCollectionViewLayout:[[LiveFlowLayout alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // Register cell classes
    //    [self.collectionView registerClass:[LiveViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([LiveViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.automaticallyChangeAlpha = YES;
    [header beginRefreshing];
    self.collectionView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    footer.automaticallyChangeAlpha = YES;
    footer.triggerAutomaticallyRefreshPercent = 0.1;
    self.collectionView.mj_footer = footer;
    
    
    // Do any additional setup after loading the view.
}

- (void)refresh
{
    DLog(@"刷新");
    [[NetAccessor sharedInstance] sendGetObjectFormUrl:[NSString stringWithFormat:@"%@%@",_main_url,_liveList_url] parameters:nil connectClass:nil progress:^(NSProgress *taskProgress) {
        
    } finished:^(EnumServerStatus status, id object) {
        if (status == Enum_SUCCESS) {
            _liveListModel = [LiveListModel yy_modelWithJSON:object];
            [self.collectionView reloadData];
        }
        [self.collectionView.mj_header endRefreshing];
    }];
    
    
}

- (void)loadMoreData
{
    DLog(@"加载");
    [self.collectionView reloadData];
    [self.collectionView.mj_footer endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _liveListModel.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LiveViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell sizeToFit];
    
    if (_liveListModel.data.count) {
        Data *data = [_liveListModel.data objectAtIndex:indexPath.row];
        cell.liveData = data;
    }
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
 // Uncomment this method to specify if the specified item should be highlighted during tracking
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
 }
 */

/*
 // Uncomment this method to specify if the specified item should be selected
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
 return YES;
 }
 */

/*
 // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
 - (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
 }
 
 - (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
 }
 
 - (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
 }
 */

@end
