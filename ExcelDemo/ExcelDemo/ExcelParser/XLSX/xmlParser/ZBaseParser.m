/******************************************************/
//
//  ProjectName: ZXLSXReader
//  FileName   : ZBaseParser.m
//  Author     : Casanova.Z/朱静宁 16/8/24.
//  E-mail     : casanova.z@qq.com
//  Blog       : http://blog.sina.com.cn/casanovaZHU
//
//  Copyright © 2016年 casanova. All rights reserved.
/******************************************************/

#import "ZBaseParser.h"

@implementation ZBaseParser

- (NSXMLParser *)xmlParser {
    
    if (!_xmlParser) {
        
        NSData *data = [[NSData alloc] initWithContentsOfFile:self.parseFilePath];
        _xmlParser = [[NSXMLParser alloc] initWithData:data];
    }
    return _xmlParser;
}


@end
