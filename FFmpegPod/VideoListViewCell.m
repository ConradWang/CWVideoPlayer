//
//  VideoListViewCell.m
//  FFmpegPod
//
//  Created by Staff on 2017/7/13.
//  Copyright © 2017年 Staff. All rights reserved.
//

#import "VideoListViewCell.h"

@implementation VideoListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
