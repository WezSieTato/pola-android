#import <AVFoundation/AVFoundation.h>
#import "BPScanCodeView.h"
#import "BPStackView.h"
#import "BPConst.h"

const int SCAN_CODE_MARGIN = 15;

@interface BPScanCodeView ()
@property(nonatomic, readonly) UIView *rectangleView;
@property(nonatomic, readonly) UIView *dimView;
@end

@implementation BPScanCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _dimView = [[UIView alloc] initWithFrame:CGRectZero];
        _dimView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3f];
        [self addSubview:_dimView];
        
        _rectangleView = [[UIView alloc] initWithFrame:CGRectZero];
        _rectangleView.layer.borderWidth = 1.f;
        _rectangleView.layer.borderColor = [[UIColor whiteColor] CGColor];
        [self addSubview:_rectangleView];

        _stackView = [[BPStackView alloc] initWithFrame:CGRectZero];
        [self addSubview:_stackView];
        
        _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_menuButton setImage:[UIImage imageNamed:@"BurgerIcon"] forState:UIControlStateNormal];
        [_menuButton sizeToFit];
        [self addSubview:_menuButton];
    }

    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.stackView.frame = self.bounds;

    self.dimView.frame = self.bounds;

    CGRect rect = self.rectangleView.frame;
    rect.size.width = CGRectGetWidth(self.bounds) / 1.4f;
    rect.size.height = rect.size.width / 2;
    rect.origin.x = CGRectGetWidth(self.bounds) / 2 - CGRectGetWidth(rect) / 2;
    rect.origin.y = CGRectGetHeight(self.bounds) / 2 - CGRectGetHeight(rect);
    self.rectangleView.frame = rect;

    rect = self.menuButton.frame;
    rect.origin.x = CGRectGetWidth(self.bounds) - SCAN_CODE_MARGIN - CGRectGetWidth(rect);
    rect.origin.y = STATUS_BAR_HEIGHT + SCAN_CODE_MARGIN;
    self.menuButton.frame = rect;
}


- (void)setVideoLayer:(AVCaptureVideoPreviewLayer *)videoLayer {
    if (_videoLayer == videoLayer) {
        return;
    }

    [_videoLayer removeFromSuperlayer];
    _videoLayer = videoLayer;
    [videoLayer setFrame:self.layer.bounds];
    [self.layer addSublayer:videoLayer];

    [self bringSubviewToFront:self.dimView];
    [self bringSubviewToFront:self.rectangleView];
    [self bringSubviewToFront:self.stackView];
    [self bringSubviewToFront:self.menuButton];
}

@end