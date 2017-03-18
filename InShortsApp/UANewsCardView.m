#import "UANewsCardView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UANewsCardView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation UANewsCardView

- (void)layoutSubviews {
    [super layoutSubviews];
    self.containerView.frame = CGRectMake(self.containerX, self.containerY, self.containerWidth, self.containerHeight);
    self.containerView.translatesAutoresizingMaskIntoConstraints = YES;
}

- (void)setImageURLString:(NSString *)imageURLString {
  [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageURLString]
                    placeholderImage:nil];
}

- (void)setTitle:(NSString *)title {
  self.titleLabel.text = title;
}

- (void)setContent:(NSString *)content {
  self.contentLabel.text = content;
}

@end
