
#import "LPActionSheet.h"
#import "UIColor+expanded.h"
#import "NSString+Common.h"
static const CGFloat kRowHeight = 48.0f;
static const CGFloat kRowLineHeight = 0.5f;
static const CGFloat kSeparatorHeight = 6.0f;
static const CGFloat kTitleFontSize = 13.0f;
static const CGFloat kButtonTitleFontSize = 18.0f;
static const NSTimeInterval kAnimateDuration = 0.3f;

@interface LPActionSheet ()

/** block回调 */
@property (copy, nonatomic) LPActionSheetBlock actionSheetBlock;
/** 背景图片 */
@property (strong, nonatomic) UIView *backgroundView;
/** 弹出视图 */
@property (strong, nonatomic) UIView *actionSheetView;

/**
 * 收起视图
 */
- (void)dismiss;

/**
 * 通过颜色生成图片
 */
- (UIImage *)imageWithColor:(UIColor *)color;

@end

@implementation LPActionSheet

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithTitle:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil properties:nil handler:nil];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithTitle:nil cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil properties:nil handler:nil];
}

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
                   properties:(NSDictionary *)properties
                      handler:(LPActionSheetBlock)actionSheetBlock
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _actionSheetBlock = actionSheetBlock;
        
        CGFloat actionSheetHeight = 0;
        
        _backgroundView = [[UIView alloc] initWithFrame:self.frame];
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
        _backgroundView.alpha = 0;
        [self addSubview:_backgroundView];
        
        _actionSheetView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 0)];
        _actionSheetView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        _actionSheetView.backgroundColor = [UIColor colorWithRed:238.0f/255.0f green:238.0f/255.0f blue:238.0f/255.0f alpha:1.0f];
        [self addSubview:_actionSheetView];
        
        UIImage *normalImage = [self imageWithColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
        UIImage *highlightedImage = [self imageWithColor:[UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]];
        
        if (title && title.length > 0)
        {
            actionSheetHeight += kRowLineHeight;
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, actionSheetHeight, self.frame.size.width, 80)];
            titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            titleLabel.text = title;
            titleLabel.backgroundColor = [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
            UIColor *titleColor = [UIColor colorWithRed:135.0f/255.0f green:135.0f/255.0f blue:135.0f/255.0f alpha:1.0f];
            titleLabel.textColor = properties&&properties[FirstTextColor] ? [UIColor colorWithHexString:properties[FirstTextColor]]: titleColor;
            
            CGFloat titleHeight;
            if(properties&&properties[FirstFontSize]){
                [titleLabel.text getFont:titleLabel.font
                                    size:CGSizeMake(self.frame.size.width, 300)
                               lineSpace:8.0
                                   label:titleLabel];
                titleHeight = 40;
            }else{
                titleHeight = ceil([title boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kTitleFontSize]} context:nil].size.height) + 15*2;
            }
            CGRect rect = titleLabel.frame;
            rect.size.height = titleHeight;
            titleLabel.frame = rect;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            UIFont *titleFont = [UIFont systemFontOfSize:kTitleFontSize];
            titleLabel.font = properties&&properties[FirstFontSize] ? [UIFont systemFontOfSize:((NSString *)(properties[FirstFontSize])).intValue]: titleFont;
            titleLabel.numberOfLines = 0;
            [_actionSheetView addSubview:titleLabel];
            actionSheetHeight += titleHeight;
        }
        
        if (destructiveButtonTitle && destructiveButtonTitle.length > 0)
        {
            actionSheetHeight += kRowLineHeight;
            
            UIButton *destructiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
            destructiveButton.frame = CGRectMake(0, actionSheetHeight, self.frame.size.width, kRowHeight);
            destructiveButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            destructiveButton.tag = -1;
            destructiveButton.titleLabel.font = [UIFont systemFontOfSize:kButtonTitleFontSize];
            [destructiveButton setTitle:destructiveButtonTitle forState:UIControlStateNormal];
            [destructiveButton setTitleColor:[UIColor colorWithRed:230.0f/255.0f green:66.0f/255.0f blue:66.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
            [destructiveButton setBackgroundImage:normalImage forState:UIControlStateNormal];
            [destructiveButton setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
            [destructiveButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_actionSheetView addSubview:destructiveButton];
            
            actionSheetHeight += kRowHeight;
        }
        
        if (otherButtonTitles && [otherButtonTitles count] > 0)
        {
            for (int i = 0; i < otherButtonTitles.count; i++)
            {
                actionSheetHeight += kRowLineHeight;
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(0, actionSheetHeight, self.frame.size.width, kRowHeight);
                button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
                button.tag = i+1;
                UIFont *font = [UIFont systemFontOfSize:kButtonTitleFontSize];
                button.titleLabel.font = properties&&properties[SecondFontSize]?[UIFont systemFontOfSize:((NSString *)(properties[SecondFontSize])).intValue]:font;
                [button setTitle:otherButtonTitles[i] forState:UIControlStateNormal];
                UIColor *color = [UIColor colorWithRed:64.0f/255.0f green:64.0f/255.0f blue:64.0f/255.0f alpha:1.0f];
                [button setTitleColor:properties&&properties[SecondTextColor] ? [UIColor colorWithHexString:properties[SecondTextColor]]:color forState:UIControlStateNormal];
                [button setBackgroundImage:normalImage forState:UIControlStateNormal];
                [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
                [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [_actionSheetView addSubview:button];
                
                actionSheetHeight += kRowHeight;
            }
        }
        
        if (cancelButtonTitle && cancelButtonTitle.length > 0)
        {
            actionSheetHeight += kSeparatorHeight;
            
            UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
            cancelButton.frame = CGRectMake(0, actionSheetHeight, self.frame.size.width, kRowHeight);
            cancelButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            cancelButton.tag = 0;
            UIFont *font = [UIFont systemFontOfSize:kButtonTitleFontSize];
            cancelButton.titleLabel.font = properties&&properties[ThirdFontSize] ? [UIFont systemFontOfSize:((NSString *)(properties[ThirdFontSize])).intValue]:font;
            [cancelButton setTitle:cancelButtonTitle ?: @"取消" forState:UIControlStateNormal];
            UIColor *titleColor = [UIColor colorWithRed:64.0f/255.0f green:64.0f/255.0f blue:64.0f/255.0f alpha:1.0f];
            [cancelButton setTitleColor:properties&&properties[ThirdTextColor] ? [UIColor colorWithHexString:properties[ThirdTextColor]]: titleColor forState:UIControlStateNormal];
            [cancelButton setBackgroundImage:normalImage forState:UIControlStateNormal];
            [cancelButton setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
            [cancelButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_actionSheetView addSubview:cancelButton];
            
            actionSheetHeight += kRowHeight;
        }
        
        _actionSheetView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, actionSheetHeight);
    }
    
    return self;
}

+ (instancetype)actionSheetWithTitle:(NSString *)title
                   cancelButtonTitle:(NSString *)cancelButtonTitle
              destructiveButtonTitle:(NSString *)destructiveButtonTitle
                   otherButtonTitles:(NSArray *)otherButtonTitles
                          properties:(NSDictionary *)properties
                             handler:(LPActionSheetBlock)actionSheetBlock
{
    return [[self alloc] initWithTitle:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles
                               properties:(NSDictionary *)properties
                               handler:actionSheetBlock];
}

+ (void)showActionSheetWithTitle:(NSString *)title
               cancelButtonTitle:(NSString *)cancelButtonTitle
          destructiveButtonTitle:(NSString *)destructiveButtonTitle
               otherButtonTitles:(NSArray *)otherButtonTitles
                      properties:(NSDictionary *)properties
                         handler:(LPActionSheetBlock)actionSheetBlock
{
    LPActionSheet *lpActionSheet = [self actionSheetWithTitle:title cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles properties:properties handler:actionSheetBlock];
    [lpActionSheet show];
}

- (void)show
{
    // 在主线程中处理,否则在viewDidLoad方法中直接调用,会先加本视图,后加控制器的视图到UIWindow上,导致本视图无法显示出来,这样处理后便会优先加控制器的视图到UIWindow上
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows)
        {
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            
            if(windowOnMainScreen && windowIsVisible && windowLevelNormal)
            {
                [window addSubview:self];
                break;
            }
        }
        
        [UIView animateWithDuration:kAnimateDuration delay:0 usingSpringWithDamping:0.7f initialSpringVelocity:0.7f options:UIViewAnimationOptionCurveEaseInOut animations:^{
            self.backgroundView.alpha = 1.0f;
            self.actionSheetView.frame = CGRectMake(0, self.frame.size.height-self.actionSheetView.frame.size.height, self.frame.size.width, self.actionSheetView.frame.size.height);
        } completion:nil];
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:kAnimateDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backgroundView.alpha = 0.0f;
        self.actionSheetView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.actionSheetView.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.backgroundView];
    if (!CGRectContainsPoint(self.actionSheetView.frame, point))
    {
        if (self.actionSheetBlock)
        {
            self.actionSheetBlock(self, 0);
        }
        
        [self dismiss];
    }
}

- (void)buttonClicked:(UIButton *)button
{
    if (self.actionSheetBlock)
    {
        self.actionSheetBlock(self, button.tag);
    }
    
    [self dismiss];
}

- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"LPActionSheet dealloc");
#endif
}

@end
