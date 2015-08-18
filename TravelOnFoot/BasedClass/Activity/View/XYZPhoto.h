
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, XYZPhotoState) {
    XYZPhotoStateNormal,
    XYZPhotoStateBig,
    XYZPhotoStateDraw,
    XYZPhotoStateTogether
};

#define IMAGEWIDTH 160
#define IMAGEHEIGHT 130
@interface XYZPhoto : UIView
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic) float speed;
@property (nonatomic) CGRect oldFrame;
@property (nonatomic) float oldSpeed;
@property (nonatomic) float oldAlpha;
@property (nonatomic) int state;


@property(nonatomic,strong)NSTimer * timer;




 - (void)setImageAlphaAndSpeedAndSize:(float)alpha;


-(void)stopMove;
-(void)startMove;

@end
