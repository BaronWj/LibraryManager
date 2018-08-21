


#define FirstFontSize @"FirstFontSize"
#define SecondFontSize @"SecondFontSize"
#define ThirdFontSize @"ThirdFontSize"

#define FirstTextColor @"FirstTextColor"
#define SecondTextColor @"SecondTextColor"
#define ThirdTextColor @"ThirdTextColor"

#import <UIKit/UIKit.h>
@class LPActionSheet;

/**
 * block回调
 *
 * @param actionSheet LPActionSheet对象自身
 * @param index       被点击按钮标识,取消: 0, 删除: -1, 其他: 1.2.3...
 */
typedef void(^LPActionSheetBlock)(LPActionSheet *actionSheet, NSInteger index);

@interface LPActionSheet : UIView

/**
 * 创建LPActionSheet对象
 *
 * @param title                  提示文本
 * @param cancelButtonTitle      取消按钮文本
 * @param destructiveButtonTitle 删除按钮文本
 * @param otherButtonTitles      其他按钮文本
 * @param block                  block回调
 *
 * @return LPActionSheet对象
 */
- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
                   properties:(NSDictionary *)properties
                      handler:(LPActionSheetBlock)actionSheetBlock NS_DESIGNATED_INITIALIZER;

/**
 * 创建LPActionSheet对象(便利构造器)
 *
 * @param title                  提示文本
 * @param cancelButtonTitle      取消按钮文本
 * @param destructiveButtonTitle 删除按钮文本
 * @param otherButtonTitles      其他按钮文本
 * @param block                  block回调
 *
 * @return LPActionSheet对象
 */
+ (instancetype)actionSheetWithTitle:(NSString *)title
                   cancelButtonTitle:(NSString *)cancelButtonTitle
              destructiveButtonTitle:(NSString *)destructiveButtonTitle
                   otherButtonTitles:(NSArray *)otherButtonTitles
                          properties:(NSDictionary *)properties
                             handler:(LPActionSheetBlock)actionSheetBlock;

/**
 * 弹出LPActionSheet视图
 *
 * @param title                  提示文本
 * @param cancelButtonTitle      取消按钮文本
 * @param destructiveButtonTitle 删除按钮文本
 * @param otherButtonTitles      其他按钮文本
 * @param block                  block回调
 *
 * @return LPActionSheet对象
 */
+ (void)showActionSheetWithTitle:(NSString *)title
               cancelButtonTitle:(NSString *)cancelButtonTitle
          destructiveButtonTitle:(NSString *)destructiveButtonTitle
               otherButtonTitles:(NSArray *)otherButtonTitles
                      properties:(NSDictionary *)properties
                         handler:(LPActionSheetBlock)actionSheetBlock;

/**
 * 弹出视图
 */
- (void)show;

@end
