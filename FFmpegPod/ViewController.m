//
//  ViewController.m
//  FFmpegPod
//
//  Created by Staff on 2017/7/12.
//  Copyright © 2017年 Staff. All rights reserved.
//

#import "ViewController.h"
#import "KxMovieDecoder.h"
#import "KxMovieViewController.h"
#import "VideoListViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *nameArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.nameArray = @[@"灯彩嘉年华广告.avi", @"灯彩嘉年华广告.mkv", @"test.mov", @"test.mp4", @"高清测试视频短片.rmvb"];
    //self.nameArray = @[];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"VideoListViewCell" bundle:nil] forCellReuseIdentifier:@"id"];
    self.tableView.tableFooterView = [UIView new];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name = self.nameArray[indexPath.row];
    NSArray *nameComponents = [name componentsSeparatedByString:@"."];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:nameComponents[0] ofType:nameComponents.lastObject];
    KxMovieViewController *movieVC = [KxMovieViewController movieViewControllerWithContentPath:filePath parameters:nil];
    [self presentViewController:movieVC animated:YES completion:^{
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name = self.nameArray[indexPath.row];
    NSArray *nameComponents = [name componentsSeparatedByString:@"."];
    
    VideoListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    cell.nameLabel.text = name;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:nameComponents[0] ofType:nameComponents.lastObject];
    
    KxMovieDecoder *aDecoder = [[KxMovieDecoder alloc] init];
    [aDecoder thumbImageWithContentPath:filePath atTimestamp:3 completeBlock:^(UIImage *thumbImage) {
        if (thumbImage) {
            cell.videoIconImageView.image = thumbImage;
        }
    }];
    
    long long fileSize = [self fileSizeAtPath:filePath];
    if (fileSize > 1024 * 1024) {
        cell.sizeLabel.text = [NSString stringWithFormat:@"%.1fMB", fileSize / (1024.0 * 1024.0)];
    } else {
        cell.sizeLabel.text = [NSString stringWithFormat:@"%.1fKB", fileSize / 1024.0];
    }
    return cell;
}


- (long long) fileSizeAtPath:(NSString*) filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:filePath]){
        
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

@end
