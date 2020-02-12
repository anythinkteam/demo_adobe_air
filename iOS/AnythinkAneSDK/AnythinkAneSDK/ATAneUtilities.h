
#import <UIKit/UIKit.h>
@interface ATAneUtilities : NSObject

@end

@interface NSDictionary (KAKit)
-(NSString*) jsonString;
-(BOOL)containsObjectForKey:(id)key;
@end

@interface NSData(AnyThinkKit)
+(instancetype) dataWithUTF8String:(const char*)string;
@end

@interface UIColor (Hex)
// 透明度固定为1，以0x开头的十六进制转换成的颜色
+ (UIColor *)colorWithHex:(long)hexColor;
// 0x开头的十六进制转换成的颜色,透明度可调整
+ (UIColor *)colorWithHex:(long)hexColor alpha:(float)opacity;
// 颜色转换三：iOS中十六进制的颜色（以#开头）转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
