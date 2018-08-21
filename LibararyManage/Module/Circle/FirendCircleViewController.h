//
//  FirendCircleViewController.h
//  LibararyManage
//
//  Created by 潘伟杰 on 2018/8/14.
//  Copyright © 2018年 renda. All rights reserved.
//

#import "BaseViewController.h"

@interface FirendCircleViewController : BaseViewController<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *circleCollectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end
