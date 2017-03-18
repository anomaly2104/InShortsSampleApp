#import "UANewsCardView.h"

@implementation UANewsCardView

- (void)layoutSubviews {
    [super layoutSubviews];
    self.containerView.frame = CGRectMake(self.containerX, self.containerY, self.containerWidth, self.containerHeight);
    self.containerView.translatesAutoresizingMaskIntoConstraints = YES;
}

@end
