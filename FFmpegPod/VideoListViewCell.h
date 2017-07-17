//
//  VideoListViewCell.h
//  FFmpegPod
//
//  Created by Staff on 2017/7/13.
//  Copyright © 2017年 Staff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoListViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *videoIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

@end
