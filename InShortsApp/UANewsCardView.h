#import <UIKit/UIKit.h>

@interface UANewsCardView : UIView

@property (weak, nonatomic) IBOutlet UIView *containerView;

- (void)setImageURLString:(NSString *)imageURLString;
- (void)setTitle:(NSString *)title;
- (void)setContent:(NSString *)content;

@end
