//
//  FirendCircleViewController.m
//  LibararyManage
//
//  Created by 潘伟杰 on 2018/8/14.
//  Copyright © 2018年 renda. All rights reserved.
//

#import "FirendCircleViewController.h"
#import "SearchBookViewController.h"
#import "UIColor+expanded.h"
@interface FirendCircleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) SearchBookViewController * searchBook;
@end

@implementation FirendCircleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.circleCollectionView.delegate = self;
    self.circleCollectionView.dataSource = self;
    self.searchBar.delegate = self;
    self.searchBar.tintColor = [UIColor colorWithHexString:@"0x1E90FF"];
    self.searchBook = [[SearchBookViewController alloc] init];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --
#pragma mark -- SearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    UINavigationController * rootNav = [[UINavigationController alloc] initWithRootViewController:self.searchBook];
    [self presentViewController:rootNav animated:YES completion:nil];
    
    return YES;
}


-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
}


#pragma mark --
#pragma mark -- UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"circleCollectionCell";
    static NSString *addCell = @"addCollectionCell";

    UICollectionViewCell * cell = nil;
  
    if(indexPath.row == 2){
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:addCell forIndexPath:indexPath];
    }else{
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    }
//    cell.imageView.image = [UIImage imageNamed:self.photos[indexPath.item]];
    return cell;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
