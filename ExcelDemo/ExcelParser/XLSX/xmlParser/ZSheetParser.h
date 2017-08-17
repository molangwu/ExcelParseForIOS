/******************************************************/
//
//  ProjectName: ZXLSXReader
//  FileName   : ZSheetParser.h
//  Author     : Casanova.Z/朱静宁 16/8/24.
//  E-mail     : casanova.z@qq.com
//  Blog       : http://blog.sina.com.cn/casanovaZHU
//
//  Copyright © 2016年 casanova. All rights reserved.
/******************************************************/

#import "ZBaseParser.h"
#import "ZPaserProtocol.h"

@interface ZSheetParser : ZBaseParser <ZPaserProtocol,NSXMLParserDelegate>

@property (nonatomic, strong) NSArray *sheetArr;    // 从workbook解析出的sheet的名称等信息


@end
