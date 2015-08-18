

#import "XYZPhoto.h"

@implementation XYZPhoto

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
        
        self.imageView.layer.borderWidth = 1;
        self.imageView.layer.cornerRadius = 10;
        self.imageView.layer.masksToBounds =YES;
        self.imageView.layer.borderColor = [[UIColor clearColor] CGColor];
        
        self.imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage)];
        [self addGestureRecognizer:tap];
        
//        UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipImage)];
//        [swip setDirection:UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight];
//        [self addGestureRecognizer:swip];
        self.speed = 0.15;

        [self startMove];
        
     }
    return self;
}

- (void)tapImage {
    
      XYZPhoto * XYZ = self;

    [UIView animateWithDuration:0.5 animations:^{
        
        CGFloat W = XYZ.superview.bounds.size.width*2/3;
        CGFloat H =  XYZ.superview.bounds.size.height*0.3;
        
        CGFloat X = arc4random()%(int)(XYZ.superview.bounds.size.width -W );
        CGFloat Y = arc4random()%(int)(XYZ.superview.bounds.size.height-H-140);
        if (XYZ.state == XYZPhotoStateNormal||XYZ.state == XYZPhotoStateTogether) {
            XYZ.oldFrame = XYZ.frame;
            XYZ.oldAlpha = XYZ.alpha;
            XYZ.oldSpeed = XYZ.speed;
            if (XYZ.state == XYZPhotoStateNormal) {
                XYZ.frame = CGRectMake(X, Y,W ,H );
            }else{
                XYZ.frame = CGRectMake(X, Y,W ,H );

            }
            
            XYZ.imageView.frame = XYZ.bounds;
            [XYZ.superview bringSubviewToFront:XYZ];
            XYZ.speed = 0;
            XYZ.alpha = 1;
            XYZ.state = XYZPhotoStateBig;
            
        } else if (XYZ.state == XYZPhotoStateBig) {
            XYZ.frame = XYZ.oldFrame;
            XYZ.alpha = XYZ.oldAlpha;
            XYZ.speed = XYZ.oldSpeed;
            XYZ.imageView.frame = XYZ.bounds;
             XYZ.state = XYZPhotoStateNormal;
        }
        
    }];
   
}

//- (void)swipImage {
//    
//    if (self.state == XYZPhotoStateBig) {
//        [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
//        self.state = XYZPhotoStateDraw;
//    } else if (self.state == XYZPhotoStateDraw){
//        [self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
//        self.state = XYZPhotoStateBig;
//    }
//}



- (void)setImageAlphaAndSpeedAndSize:(float)alpha {
    self.alpha = alpha;
//    self.speed = alpha;
    self.transform = CGAffineTransformScale(self.transform, alpha, alpha);
}

- (void)movePhotos {
      XYZPhoto * XYZ = self;

//    [UIView animateWithDuration:0.5 animations:^{

    XYZ.center = CGPointMake(XYZ.center.x + XYZ.speed, XYZ.center.y);
    if (XYZ.center.x > XYZ.superview.bounds.size.width + XYZ.frame.size.width/2) {
        XYZ.center = CGPointMake(-XYZ.frame.size.width/2, arc4random()%(int)(XYZ.superview.bounds.size.height+10 - XYZ.bounds.size.height) + XYZ.bounds.size.height/2);
    }
//    }];
}
-(void)startMove
{
    
    self.timer = [NSTimer timerWithTimeInterval:19/20 target:self selector:@selector(movePhotos) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:@"NSDefaultRunLoopMode"];
    
//        self.timer =    [NSTimer scheduledTimerWithTimeInterval:1/3 target:self selector:@selector(movePhotos) userInfo:nil repeats:YES];
}
-(void)stopMove
{
    [self.timer invalidate];
    self.timer =nil;
}


@end
