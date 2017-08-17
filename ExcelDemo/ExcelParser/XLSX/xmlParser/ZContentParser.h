/******************************************************/
//
//  ProjectName: ZXLSXReader
//  FileName   : ZContentParser.h
//  Author     : Casanova.Z/朱静宁 16/8/24.
//  E-mail     : casanova.z@qq.com
//  Blog       : http://blog.sina.com.cn/casanovaZHU
//
//  Copyright © 2016年 casanova. All rights reserved.
/******************************************************/

#import "ZBaseParser.h"
#import "ZPaserProtocol.h"

@interface ZContentParser : ZBaseParser <ZPaserProtocol,NSXMLParserDelegate>

@property (nonatomic, strong) NSDictionary *allColDict;    // 从所有sheet解析出的col的信息

@end
