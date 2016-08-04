//
//  ViewController.m
//  testHeightFold
//
//  Created by 优谱德 on 16/8/3.
//  Copyright © 2016年 优谱德. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCellFold.h"
#import "AgModel.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableVIew;

@property (nonatomic, strong) NSMutableArray <AgModel *> *models;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initData];
    [self initUI];
}

#pragma mark - init

- (void)initData {

    _models = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i < 5; i ++) {
        
        AgModel *model = [[AgModel alloc] init];
        
        model.content = @"http://192.168.1.123:8080http://192.168.1.123:8080http://192.168.1.123:8080http://192.168.1.123:8080http://192.168.1.123:8080http://192.168.1.123:8080http://192.168.1.123:8080http://192.168.1.123:8080";
        
        model.open = NO;
        
        [_models addObject:model];
    }
    

    
}

- (void)initUI {

    self.tableVIew.delegate = self;
    self.tableVIew.dataSource = self;
}

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cell_id = @"TableViewCellFold";
    
    TableViewCellFold *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];

    
    if (cell == nil) {
        
        cell = [[NSBundle mainBundle] loadNibNamed:@"TableViewCellFold" owner:self options:nil].firstObject;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if ([self.models count] > indexPath.row)
    {
        //这里的判断是为了防止数组越界
        cell.model = [self.models objectAtIndex:indexPath.row];
    }

    
    cell.refresh = ^(UITableViewCell *currentCell) {
    
        // 这里多传一个model，如果有id可以判断indexPath，因为小心分页加载的问题

        NSIndexPath *indexRow = [self.tableVIew indexPathForCell:(TableViewCellFold *)currentCell];
        
        [self.tableVIew reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexRow, nil] withRowAnimation:UITableViewRowAnimationAutomatic];
    };
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    /*return cell.frame.size.height;*/
    
    AgModel *model = nil;
    if ([self.models count] > indexPath.row)
    {
        model = [self.models objectAtIndex:indexPath.row];
    }
    
    // 根据isShowMoreText属性判断cell的高度
    if (model.open)
    {
        return [TableViewCellFold cellMoreHeight:model];
    }
    else
    {
        return [TableViewCellFold cellDefaultHeight:model];
    }
    return 0;
    
}







@end
