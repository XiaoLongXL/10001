//
//  ActivityTableViewCell.m
//  GZSMyDouBan
//
//  Created by xiaolong on 15/6/27.
//  Copyright (c) 2015年 XXl. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "XLTool.h"
@interface ActivityTableViewCell ()


@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UILabel * tagLabel;
@property (nonatomic,strong) UIView * tagView;

@property (nonatomic,strong) UILabel * destinationLabel;
@property (nonatomic,strong) UILabel * min_costLabel;
@property (nonatomic,strong) UILabel * timeLabel;
@property (nonatomic,strong) UIImageView * clubView;
@property (nonatomic,strong) UILabel * clubNameLabel;
@property (nonatomic,strong) UIImageView * coverView;
@property (nonatomic,strong) UIImageView * cellBackgroudImageview;

@end

@implementation ActivityTableViewCell
+(instancetype)cellWithTableView:(UITableView *)tabelView
{
    static NSString * cellID = @"ctivityTableViewCell";
    ActivityTableViewCell * cell = [tabelView  dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[ActivityTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    return cell;
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupSubview];
        [self setBackgroundColor:[UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1]];
    }
    return self;
}
//-(void)layoutSubviews
//{
//    [super layoutSubviews];
////    [self setupSubview];
//}
-(UIImageView *)coverView
{
    if (_coverView==nil) {
        _coverView = [[UIImageView alloc]init];
    }
    return _coverView;
}
-(UIImageView *)cellBackgroudImageview
{
    if (_cellBackgroudImageview==nil) {
        _cellBackgroudImageview = [[UIImageView alloc]init];
        
//        //背景View
        _cellBackgroudImageview.backgroundColor = [UIColor colorWithRed:240/255.0 green:250/255.0 blue:250/255.0 alpha:1];

        _cellBackgroudImageview.layer.cornerRadius = 20;
        _cellBackgroudImageview.layer.masksToBounds =YES;
        
        _cellBackgroudImageview.contentMode =  UIViewContentModeScaleAspectFill;
    }
    return _cellBackgroudImageview;
}
-(UIImageView *)clubView
{
    if (_clubView==nil) {
        _clubView = [[UIImageView alloc]init];
    }
    return _clubView;
}-(void)setupSubview
{
     [self.contentView addSubview:self.cellBackgroudImageview];
    CGFloat scaleFont = heightScaleMakeAdaptationScreen(1);
    self.titleLabel = [self setLabelWith:widthScaleMakeAdaptationScreen(20)];
    
    self.tagView = [[UIImageView alloc ]init ];
    [self.cellBackgroudImageview addSubview:_tagView];
    
    self.destinationLabel = [self setLabelWith:15*scaleFont];

    
    self.timeLabel = [self setLabelWith:15*scaleFont];
    [self.timeLabel setFont:[UIFont fontWithName:@"DBLCDTempBlack" size:15*scaleFont]];

    self.min_costLabel = [self setLabelWith:15*scaleFont];
    self.min_costLabel.textColor = [UIColor redColor];
    [self.min_costLabel setFont:[UIFont fontWithName:@"Zapfino" size:15*scaleFont]];

    
     [self.cellBackgroudImageview addSubview:self.clubView];
    
    self.clubNameLabel = [self setLabelWith:15*scaleFont];
;
     [self.cellBackgroudImageview addSubview:self.coverView];
    

}
-(UILabel*)setLabelWith:(CGFloat)FontSize
{
    
    UILabel * label = [[UILabel alloc]init ];
    label.numberOfLines = 0;
//    label.contentMode = UIViewContentModeCenter ;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.font = [UIFont systemFontOfSize:FontSize];
    [self.cellBackgroudImageview addSubview:label];
    return label;
}
-(void)setModel:(ActivitiesModel *)model
{
    _model = model;
    [self setSubciewsConnect:model];
    [self setSubciewsFrame:model];
}
-(void)setSubciewsConnect:(ActivitiesModel *)model
{
    
    _titleLabel.text = model.title;
    
        [self.coverView sd_setImageWithURL:[NSURL URLWithString:model.cover] placeholderImage:[UIImage imageNamed:@"2.jpg"]];

    
    self.destinationLabel.text = [NSString stringWithFormat:@"%@-%@",model.city,model.destination];
    self.timeLabel.text =[NSString stringWithFormat:@"游程 %@ 天",model.days];
    
    self.min_costLabel.text = [NSString stringWithFormat:@"￥:%@",model.min_cost];
    NSDictionary * dic = model.club;
    [self.clubView sd_setImageWithURL:[NSURL URLWithString:dic[@"logo"]]placeholderImage:[UIImage imageNamed:@"2.jpg"]];
    
    self.clubNameLabel.text = dic[@"title"];

}
-(void)setSubciewsFrame:(ActivitiesModel *)model
{
    CGFloat margin = widthScaleMakeAdaptationScreen(10);
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width -3*margin ;
    CGFloat photoWidth = cellWidth*0.3;
    CGFloat Xmargin = 1.5*margin;
    CGFloat infoStart =photoWidth + 3*margin;
    CGFloat Ymargin = margin;

    CGFloat labelW = cellWidth-infoStart -margin;
    
   CGRect rect =  [XLTool getTextSizeWithText:self.titleLabel.text textWidth:cellWidth-3*margin textFont:2*margin];
    
    [self.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:1.9*margin]];
    [self.timeLabel sizeToFit];

    [self.titleLabel setFrame:CGRectMakeAdaptationScreen(Xmargin, 2*Ymargin, cellWidth-3*margin, rect.size.height)];
    self.titleLabel.font = [UIFont systemFontOfSize:1.7*margin];
    [self.tagView setFrame:CGRectMake(Xmargin, CGRectGetMaxY(_titleLabel.frame)+Ymargin, cellWidth, 2*margin)];
    NSMutableArray * tagArr = model.tag;
    for (int i= 0; i<tagArr.count;i++) {
        UILabel * label = [[UILabel alloc]init];
        label.backgroundColor = [UIColor whiteColor];
        label.text = tagArr[i];
        
        label.layer.cornerRadius = margin;
        label.layer.masksToBounds =YES;
        label.layer.borderWidth =1 ;
        label.textAlignment = NSTextAlignmentCenter;

        label.contentMode = UIViewContentModeCenter ;
        [label setFont: [UIFont systemFontOfSize:13*0.1*margin]];
//        [label sizeToFit];
        [label setFrame:CGRectMake(i*50*0.1*margin, 0,45*0.1*margin , 23*0.1*margin)];
        
        [self.tagView addSubview:label];
        
    }
    [self.coverView setFrame:CGRectMake(Xmargin, CGRectGetMaxY(_tagView.frame)+2*Ymargin, photoWidth, 13*margin)];
    
    [self.destinationLabel setFrame:CGRectMake(infoStart, CGRectGetMaxY(_tagView.frame)+2*Ymargin, labelW, 2*margin)];
    [self.timeLabel setFrame:CGRectMake(infoStart, CGRectGetMaxY(_destinationLabel.frame)+Ymargin, labelW, 2*margin)];
    [self.min_costLabel setFrame:CGRectMake(infoStart, CGRectGetMaxY(_timeLabel.frame)+Ymargin, labelW, 3*margin)];

    [self.clubView setFrame:CGRectMake(infoStart, CGRectGetMaxY(_min_costLabel.frame)+margin, 3*margin, 3*margin)];
    
    [self.clubNameLabel setFrame:CGRectMake(CGRectGetMaxX(_clubView.frame)+margin, CGRectGetMaxY(_min_costLabel.frame)+margin, labelW - 3*margin, 3*margin)];
[self.cellBackgroudImageview setFrame:CGRectMake(1.5*margin, margin, cellWidth , CGRectGetMaxY(_coverView.frame)+2*margin)];
    
     self.cellheight = CGRectGetMaxY(_cellBackgroudImageview.frame)+margin;

 
}
- (void)awakeFromNib {
 }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
 }

@end
