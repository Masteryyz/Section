//
//  YZTableViewCell.m
//  Section
//
//  Created by QZL on 2018/3/27.
//  Copyright © 2018年 WTF. All rights reserved.
//

#import "YZTableViewCell.h"

#define kTitleLabelFontSize H(12.0f)

@interface YZTableViewCell ()

@property (nonatomic, strong) UILabel * statumNameLabel;
@property (nonatomic, strong) UILabel * englishNameLabel;
@property (nonatomic, strong) UILabel * dateLabel;

@property (nonatomic, strong) UILabel * danLabel ;

@end

@implementation YZTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataDic:(NSDictionary *)dataDic {
    
    _dataDic = dataDic;
    
    _statumNameLabel.text = [NSString stringWithFormat:@"场馆名:   %@" , [dataDic valueForKey:@"statiumName"]];
    [_statumNameLabel sizeToFit];
    
    _statumNameLabel.mj_origin = CGPointMake(H(10), H(10));
    
    _englishNameLabel.text = [NSString stringWithFormat:@"英文名:   %@" , [dataDic valueForKey:@"englishName"]];
    [_englishNameLabel sizeToFit];
    
    _englishNameLabel.mj_origin = CGPointMake(H(10), CGRectGetMaxY(_statumNameLabel.frame) + H(10));
    
    NSString * birthdayStr = [NSString stringWithFormat:@"%@" , [dataDic valueForKey:@"birthday"]];
    
    if (birthdayStr.length > 10) {
        birthdayStr = [birthdayStr substringToIndex:10];
    }
    
    _dateLabel.text = [NSString stringWithFormat:@"生    日:   %@" , birthdayStr];;
    [_dateLabel sizeToFit];
    
    _dateLabel.mj_origin = CGPointMake(H(10), CGRectGetMaxY(_englishNameLabel.frame) + H(10));
    
    
    _danLabel.text = [NSString stringWithFormat:@"段    位:   %@" , [dataDic valueForKey:@"applyDan"]];
    [_danLabel sizeToFit];
    
    _danLabel.mj_origin = CGPointMake(H(10), CGRectGetMaxY(_dateLabel.frame) + H(10));
    
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self configUI];
        
    }
    
    return self;
    
}

- (void) configUI {
    
    _statumNameLabel = [YZUnit configNormalLabelWithFont:kTitleLabelFontSize];
    _statumNameLabel.text = @"---";
    _statumNameLabel.textColor = [self getTextColor];
    
    [self.contentView addSubview:_statumNameLabel];
    
    _englishNameLabel = [YZUnit configNormalLabelWithFont:kTitleLabelFontSize];
    _englishNameLabel.text = @"---";
    _englishNameLabel.textColor = [self getTextColor];
    
    [self.contentView addSubview:_englishNameLabel];
    
    if (!_dateLabel) {//详情
        
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 1, 1)];
        [self.contentView addSubview:_dateLabel];
        _dateLabel.font = [UIFont systemFontOfSize:H(12.0f)];
        _dateLabel.textColor = [self getTextColor];
        _dateLabel.numberOfLines = 1;
        _dateLabel.text = @"---";
        
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        
        [_dateLabel sizeToFit];
    }
    
    _danLabel = [YZUnit configNormalLabelWithFont:kTitleLabelFontSize];
    _danLabel.text = @"---";
    _danLabel.textColor = [self getTextColor];
    
    [self.contentView addSubview:_danLabel];
    
}

- (UIColor *) getTextColor {
    return [UIColor colorWithHexValue:0x333333 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
