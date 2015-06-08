//
//  Tools.m
//  GroupPurchase
//
//  Created by MacPro.com on 14-8-26.
//
//

#import "Tools.h"
#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"
@implementation Tools

+ (NSString *)md5:(NSString *)string;

{   //const char *original_str = [string UTF8String];
    unsigned char result[32];
    //CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}
//16进制颜色(html颜色值)字符串转为UIColor
+(UIColor *) hexStringToColor: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
 
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+(CGFloat)widthForWithNSSting:(NSString *)string stringHeight:(CGFloat )stringHeight fontSize:(CGFloat)fontSize
{
    
    CGRect rect=  [string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, stringHeight) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin  attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil] context:nil];
    return rect.size.width;
}
+(CGFloat)heightForWithNSSting:(NSString *)string stringWidth:(CGFloat )stringWidth fontSize:(CGFloat)fontSize;
{
    CGRect rect=  [string boundingRectWithSize:CGSizeMake(stringWidth, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin  attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:fontSize],NSFontAttributeName, nil] context:nil];
    return rect.size.height;
    
}
+(void)showAlertViewWithTitle:(NSString *)title
{
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"" message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}
+(void )saveObject:(id)string ToNSDefaultsWithKey:(NSString *)key;
{
    if (![string isKindOfClass:[NSString class]]) {
       string=@"";
    }
    NSUserDefaults *userDefaults= [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:string forKey:key];
    [userDefaults synchronize];
}

+(NSString *)loadStandUserDefaultObjectForKey:(NSString *)key
{
    NSString *str=[[NSUserDefaults standardUserDefaults]objectForKey:key];
    return str;
}
//取消键盘第一响应;
+(void)resignKeyBoardInView:(UIView *)view
{
    for (UIView *v in view.subviews) {
        if ([v.subviews count] > 0) {
            [self resignKeyBoardInView:v];
        }
        
        if ([v isKindOfClass:[UITextView class]] || [v isKindOfClass:[UITextField class]]) {
            [v resignFirstResponder];
        }
    }
    
}
//判断手机号;
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    NSLog(@"手机号");
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobileNum];
}
//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
+(NSMutableAttributedString*)setString:(NSString*)string spacingHight:(NSInteger)spacing
{
    NSMutableAttributedString* attString =[[NSMutableAttributedString alloc]initWithString:string];
    NSMutableParagraphStyle * paragraphStyle =[[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:spacing];
    [attString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string.length)];
    return attString;
}
//打电话

+(void)call:(NSString *)phoneNumber
{
    NSString *phoneNum=[NSString stringWithFormat:@"tel:%@",phoneNumber];
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:phoneNum]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNum]]; //拨号
    }else{
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"您的设备不支持打电话" message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

#pragma mark 清空字符串中的空白字符
+ (NSString *)trimString:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+(NSString*)deviceString
{
    // 需要#import "sys/utsname.h"
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSLog(@" deviceString  %@",deviceString);
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";

    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceString isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    NSLog(@"NOTE: Unknown device type: %@", deviceString);
    return deviceString;
}

@end
