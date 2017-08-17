/******************************************************/
//
//  ProjectName: ZXLSXReader
//  FileName   : ZBaseParser.h
//  Author     : Casanova.Z/朱静宁 16/8/24.
//  E-mail     : casanova.z@qq.com
//  Blog       : http://blog.sina.com.cn/casanovaZHU
//
//  Copyright © 2016年 casanova. All rights reserved.
/******************************************************/

#import <Foundation/Foundation.h>

@interface ZBaseParser : NSObject  

@property (nonatomic, copy) NSString *parseFilePath;    // 要解析的文件路径
@property (nonatomic, strong) NSXMLParser *xmlParser;   // xml解析器
@property (nonatomic, copy) NSString *currentElement;   // 当前节点的名称


@end
