//
//  TableViewCellFold.h
//  testHeightFold
//
//  Created by 优谱德 on 16/8/3.
//  Copyright © 2016年 优谱德. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AgModel.h"

#import "TableViewCellFold.h"

typedef void(^Refresh)(UITableViewCell *cell);  // 这里多传一个model，如果有id可以判断indexPath，因为小心分页加载的问题

@interface TableViewCellFold : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIButton *foldButton;


@property (nonatomic, strong) AgModel *model;



@property (nonatomic, copy) Refresh refresh;


///未展开时的高度
+ (CGFloat)cellDefaultHeight:(AgModel *)model;
///展开后的高度
+ (CGFloat)cellMoreHeight:(AgModel *)model;

@end
