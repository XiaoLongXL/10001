//
//  RouteCollectionViewCell.m
//  TravelAgain02
//
//  Created by lanou on 15/7/18.
//  Copyright (c) 2015年 XXL. All rights reserved.
//

#import "RouteCollectionViewCell.h"
#import "XLTool.h"

@implementation RouteCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imagev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - heightScaleMakeAdaptationScreen(20))];
        self.imagev.backgroundColor = [UIColor yellowColor];
        self.trailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - heightScaleMakeAdaptationScreen(20), frame.size.width, heightScaleMakeAdaptationScreen(20))];
        self.trailLabel.backgroundColor = [UIColor clearColor];
        self.trailLabel.textAlignment = NSTextAlignmentCenter;
        self.trailLabel.textColor = [UIColor blueColor];
        [self.contentView addSubview:self.trailLabel];
        [self.contentView addSubview:self.imagev];
    }
    return self;
}

@end
