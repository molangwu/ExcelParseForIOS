/******************************************************/
//
//  ProjectName: ZXLSXReader
//  FileName   : ZXMLParser.h
//  Author     : Casanova.Z/朱静宁 16/8/24.
//  E-mail     : casanova.z@qq.com
//  Blog       : http://blog.sina.com.cn/casanovaZHU
//
//  Copyright © 2016年 casanova. All rights reserved.
/******************************************************/

#import <Foundation/Foundation.h>

/**
 解析xlsx之后数据存储的格式
 */
typedef enum : NSUInteger {
    
    ZParseOutTypeJson = 1,      // json字符串格式
    ZParseOutTypeArrayObj,  // 数组盛放对象格式
    ZParseOutTypeArrayDict  // 数组盛放字典格式
} ZParseOutType;

@class ZXLSXParser;

@protocol ZXLSXParserDelegate <NSObject>

@required

/**
 *  处理解析的结果
 *
 *  @param parser      解析器
 *  @param responseObj 解析结果
 *  @param error       解析错误
 */
- (void)parser:(ZXLSXParser *)parser success:(id)responseObj;


@end


@interface ZXLSXParser : NSObject

@property (nonatomic, weak) id<ZXLSXParserDelegate> delegate;    // 回调处理
@property (nonatomic, copy) NSString *parseFilePath;            // 等待解析的文件路径
@property (nonatomic, assign) ZParseOutType parseOutType;       // 解析后数据的输出类型

/**
 *  得到当前的xmlParser的解析对象
 *
 *  @return 对象
 */
+ (instancetype)defaultZXLSXParser;

/**
 *  开始解析
 *
 *  @return 解析后的数据
 */
- (void)parse;


@end
