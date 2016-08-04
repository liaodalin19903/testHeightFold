//
//  TableViewCellFold.m
//  testHeightFold
//
//  Created by 优谱德 on 16/8/3.
//  Copyright © 2016年 优谱德. All rights reserved.
//

#import "TableViewCellFold.h"

static AgModel *stactic_model;

@implementation TableViewCellFold

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
    [self initUI];
    
    
}

#pragma mark - init 

- (void)initUI {

    [self.foldButton addTarget:self action:@selector(responFold:) forControlEvents:UIControlEventTouchUpInside];
    
    /* 数据 */
    //self.content.text = self.model.content;
    
}

#pragma mark - 类方法

+ (CGFloat)cellDefaultHeight:(AgModel *)model {


    
    return 125;
}

+ (CGFloat)cellMoreHeight:(AgModel *)model{
    
    //展开后得高度(计算出文本内容的高度+固定控件的高度)
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    CGSize size = [model.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, 100000) options:option attributes:attribute context:nil].size;
    
    return size.height + 60 + 20;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    
    if (self.model.open)
    {
        _content.numberOfLines = 0;
        
        _content.text = self.model.content;
        
        [_content sizeToFit];
        
        ///计算文本高度
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
        NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
        CGSize size = [self.model.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, 100000) options:option attributes:attribute context:nil].size;
        
       // [_content setFrame:CGRectMake(_content.frame.origin.x, _content.frame.origin.y, [UIScreen mainScreen].bounds.size.width - 30, size.height)];
        [_content setFrame:CGRectMake(8, 8, _content.frame.size.width, _content.frame.size.height)];
        
        [_foldButton setTitle:@"收起" forState:UIControlStateNormal];
        
        //self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(_foldButton.frame) + 20);
    }
    else
    {
        
        _content.numberOfLines = 3;
        
        _content.text = self.model.content;
        
        [_content sizeToFit];
        
        [_foldButton setTitle:@"展开" forState:UIControlStateNormal];
       // [_content setFrame:CGRectMake(_content.frame.origin.x, _content.frame.origin.y, [UIScreen mainScreen].bounds.size.width - 30, 35)];
        //[_content sizeToFit];
        
        NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
        NSStringDrawingOptions option = (NSStringDrawingOptions)(NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
        CGSize size = [self.model.content boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 30, 100000) options:option attributes:attribute context:nil].size;
        
        
        
        [_content setFrame:CGRectMake(8, 8, _content.frame.size.width, _content.frame.size.height)];
        
         //self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, CGRectGetMaxY(_foldButton.frame) + 20);
    }

}


#pragma mark - getter

- (void)setModel:(AgModel *)model {

    _model = model;
    stactic_model = _model;
}


#pragma mark - click

- (void)responFold:(UIButton *)sender {
    
    self.model.open = !self.model.open;

    
    if (self.refresh) {
        
        self.refresh(self);
    }
    
}


@end
