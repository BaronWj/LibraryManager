//
//  NSString+Common.h
//  okayEducation
//
//  Created by lee on 16/7/13.
//  Copyright © 2016年 OKAY.XDF.CN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Common)

+ (NSString *)toString:(id)object;

+ (BOOL)isBlankString:(NSString *)string;//判断是否为空字符串

+ (NSString *)append:(NSString *)str key:(NSString *)key;

- (CGSize)getSize:(CGSize)size font:(UIFont *)font;

-(CGFloat)getFont:(UIFont*)font
             size:(CGSize)labelSize
        lineSpace:(CGFloat)lineSpace
            label:(UILabel *)label;

+ (NSString *)appendQiniuStr:(NSString *)url withSize:(CGSize)size;

+ (NSString *)appendQiniuStr:(NSString *)url withHeight:(NSInteger)height;

+ (NSString *)getAssistantAvatar:(NSString *)role;

+ (NSString *)getCardColor:(NSInteger )category;

- (NSString *)stringTakeOutWhiteSpaceAndNewLine;

+ (NSString *)UIUtilsFomateJsonWithDictionary:(NSDictionary *)dic;
@end
