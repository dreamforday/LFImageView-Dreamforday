//
//  ViewController.m
//  LFImageViewDemo
//
//  Created by WangZhiWei on 16/5/26.
//  Copyright © 2016年 youku. All rights reserved.
//

#import "ViewController.h"
#import "LFImageExampleView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kCellHight ceil((kScreenWidth) *3.0/4.0)

@interface LFImageViewExampleCell : UITableViewCell

@property (nonatomic, strong) LFImageExampleView *webImageView;

@end

@implementation LFImageViewExampleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, kScreenWidth, kCellHight);
        _webImageView = [LFImageExampleView new];
        _webImageView.frame = self.frame;
        _webImageView.clipsToBounds = YES;
        _webImageView.contentMode = UIViewContentModeScaleAspectFill;
        _webImageView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_webImageView];
    }
    return  self;
}

@end

@interface ViewController ()

@property (nonatomic, copy) NSArray *imageLinks;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.iTableView.delegate = self;
    self.iTableView.dataSource = self;
    self.iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *links = @[
                       /*
                        You can add your image url here.
                        */
                       
                       // progressive jpeg
                       @"https://s-media-cache-ak0.pinimg.com/1200x/2e/0c/c5/2e0cc5d86e7b7cd42af225c29f21c37f.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2047158/beerhenge.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/2016158/avalanche.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1839353/pilsner.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1833469/porter.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1521183/farmers.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1391053/tents.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1399501/imperial_beer.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1488711/fishin.jpg",
                       @"https://d13yacurqjgara.cloudfront.net/users/26059/screenshots/1466318/getaway.jpg",
                       
                       // animated webp and apng: http://littlesvr.ca/apng/gif_apng_webp.html
                       @"http://littlesvr.ca/apng/images/BladeRunner.png",
                       //@"http://littlesvr.ca/apng/images/Contact.webp",
                       ];
    self.imageLinks = links;
    [self.iTableView reloadData];
    
}


#pragma  mark --UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHight;
}

#pragma mark --UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.imageLinks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LFImageViewExampleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell) cell = [[LFImageViewExampleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.webImageView.image = nil;
    [cell.webImageView lf_setImageWithURL:[NSURL URLWithString:self.imageLinks[indexPath.row]]placeholderImage:[UIImage imageNamed:@"pia.png"] errorholderImage:[UIImage imageNamed:@"cube.png"] ];
    cell.webImageView.compledBlock = ^(UIImage *image, NSError *error,BOOL finished)
    {
        NSLog(@"%@",error.domain);
    };
    
    return  cell;
}
@end
