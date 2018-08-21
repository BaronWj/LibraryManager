//
//  MethodDefine.h
//  LibararyManage
//
//  Created by 潘伟杰 on 2018/8/20.
//  Copyright © 2018年 renda. All rights reserved.
//

#ifndef MethodDefine_h
#define MethodDefine_h


#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define IMAGE_PATH(fileName) [NSString stringWithFormat:@"%@/%@.png", [[NSBundle mainBundle] resourcePath], fileName]

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

//#define IAIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//#define GET_NUMBER(dict,key) [DictTool getNumberValue:dict withKey:key]
//#define GET_STR(dict,key) [DictTool getStringValue:dict withKey:key]
//#define GET_INT(dict,key) [[DictTool getNumberValue:dict withKey:key] integerValue]
//#define GET_ARRAY(dict,key,class) [DictTool getArrayValue:dict withKey:key withItemClass:class]
//#define GET_ARR(dict,key) [DictTool getArrayValue:dict withKey:key]
//#define GET_BOOL(dict,key) [[DictTool getNumberValue:dict withKey:key] boolValue]
//#define GET_DIC(dict,key) [DictTool getDictionaryValue:dict withKey:key]

#define OkPostNotify(name,value) [[NSNotificationCenter defaultCenter] postNotificationName:name object:value]
#define OkAddNotify(target,SEL,nam,value) [[NSNotificationCenter defaultCenter] addObserver:target selector:SEL name:nam object:value]
#define OkRemoveNotify(target) [[NSNotificationCenter defaultCenter] removeObserver:target]

#define IS_IPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define IS_IPhone_4 ([[UIScreen mainScreen] bounds].size.height < 568.0)
#define IS_IPhone_5_Low ([[UIScreen mainScreen] bounds].size.height <= 568.0)


#define iOS8 [[[UIDevice currentDevice] systemVersion] floatValue]>=8.0

#define iOS10 ([[UIDevice currentDevice].systemVersion intValue]>=10?YES:NO)

#define iOS11 ([[UIDevice currentDevice].systemVersion intValue]>=11?YES:NO)


#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define CHATVIEWBACKGROUNDCOLOR [UIColor colorWithRed:0.936 green:0.932 blue:0.907 alpha:1]

#define OKAYUserDefaultsGET(key) [[NSUserDefaults standardUserDefaults] objectForKey:key] // 取
#define OKDUserDefaultsSET(object,key) [[NSUserDefaults standardUserDefaults] setObject:object forKey:key]  // 写
#define OKUserDefaultsSynchronize [[NSUserDefaults standardUserDefaults] synchronize] // 存
#define OKUserDefaultsRemove(key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:key]  // 删

#define OkNotificationCenter [NSNotificationCenter defaultCenter]

#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)

#endif /* MethodDefine_h */
