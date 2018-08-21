//
//  NSString+Common.m
//  okayEducation
//
//  Created by lee on 16/7/13.
//  Copyright © 2016年 OKAY.XDF.CN. All rights reserved.
//

#import "NSString+Common.h"

@implementation NSString (Common)

/**
 * 判null转@""
 */
+ (NSString *)toString:(id)object
{
    NSString *str = @"";
    if(object && ![object isKindOfClass:[NSNull class]]){
        str = [NSString stringWithFormat:@"%@",object];
    }
    return str;
}

+ (NSString *)append:(NSString *)str key:(NSString *)key
{
    if(!str){
        str = @"";
    }
    return [NSString stringWithFormat:@"%@%@",str,key];
}

+ (BOOL)isBlankString:(NSString *)string{
    if (string == nil) {
        
        return YES;
        
    }
    if (string == NULL) {
        
        return YES;
        
    }
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
}


/**
 * 获取内容size
 */
- (CGSize)getSize:(CGSize)size font:(UIFont *)font
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil] context:nil].size;
}

-(CGFloat)getFont:(UIFont*)font
             size:(CGSize)labelSize
        lineSpace:(CGFloat)lineSpace
            label:(UILabel *)label
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpace;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.f
                          };
    if(label){
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
//        [attributedString addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, [self length])];
        [attributedString addAttributes:dic range:NSMakeRange(0, [self length])];
        label.attributedText = attributedString;
    }
    CGSize size = [self boundingRectWithSize:labelSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size.height;
}

- (NSString *)stringTakeOutWhiteSpaceAndNewLine
{
    NSCharacterSet  *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}



+ (NSString *)appendQiniuStr:(NSString *)url withHeight:(NSInteger)height
{
//        http://odum9helk.qnssl.com/resource/gogopher.jpg?imageView2/2/h/200
    NSString *str = [NSString stringWithFormat:@"?imageView2/2/h/%d",height*2];
    return [url stringByAppendingString:str];
}

+ (NSString *)getAssistantAvatar:(NSString *)role
{
    NSString *defaultAvatar = @"";
    switch (role.integerValue) {
        case 1://家庭教育
            defaultAvatar = @"head_family";
            break;
        case 2://数据报告
            defaultAvatar = @"head_report";
            break;
        case 3://OKAY客服
            defaultAvatar = @"head_okay";
            break;
        case 4://机构
            defaultAvatar = @"head_default";
            break;
        default:
            defaultAvatar = @"head_default";
            break;
    }
    return defaultAvatar;
}

+ (NSString *)getCardColor:(NSInteger )category
{
    NSString *defaultColor = @"0x54BFFF";
    switch (category) {
        case 0://通知公告
            defaultColor = @"0x54BFFF";
            break;
        case 1://教育咨询
            defaultColor = @"0x738098";
            break;
        case 2://数据报告
            defaultColor = @"0x3BD1A8";
            break;
        default:
            defaultColor = @"0x54BFFF";
            break;
    }
    return defaultColor;
}

//拼接json字符串
+ (NSString *)UIUtilsFomateJsonWithDictionary:(NSDictionary *)dic {
    NSArray *keys = [dic allKeys];
    NSString *string = [NSString string];
    for (NSString *key in keys) {
        NSString *value = [dic objectForKey:key];
        value = [NSString stringWithFormat:@"\"%@\"",value];
        NSString *newkey = [NSString stringWithFormat:@"\"%@\"",key];
        if (!string.length) {
            string = [NSString stringWithFormat:@"%@:%@",newkey,value];
        }else {
            string = [NSString stringWithFormat:@"%@:%@,%@",newkey,value,string];
        }
    }
    string = [NSString stringWithFormat:@"%@,",string];
    return string;
}

@end
