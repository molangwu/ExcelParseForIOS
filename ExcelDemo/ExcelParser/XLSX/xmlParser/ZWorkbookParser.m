/******************************************************/
//
//  ProjectName: ZXLSXReader
//  FileName   : ZWorkbookParser.m
//  Author     : Casanova.Z/朱静宁 16/8/24.
//  E-mail     : casanova.z@qq.com
//  Blog       : http://blog.sina.com.cn/casanovaZHU
//
//  Copyright © 2016年 casanova. All rights reserved.
/******************************************************/

#import "ZWorkbookParser.h"
#import "ZSheet.h"
#import "config.h"

@interface ZWorkbookParser ()

@property (nonatomic, strong) ZSheet *sheet;                // sheet数据模型
@property (nonatomic, strong) NSMutableArray *sheetArr;     // 存放workbook中解析出的sheet的信息

@end


@implementation ZWorkbookParser

#pragma -mark 懒加载
- (NSMutableArray *)sheetArr {
    
    if (!_sheetArr) {
        _sheetArr = [NSMutableArray array];
    }
    return _sheetArr;
}

/**
 *  开始解析
 *
 *  @return 解析出的数据
 */
- (id)startParse {
    
    NSString *workbookPath = [NSString stringWithFormat:@"%@%@",destinationPath,@"/xl/workbook.xml"];
    [self setParseFilePath:workbookPath];
    self.xmlParser.delegate = self;
    if([self.xmlParser parse]){
        return self.sheetArr;
    }
    return nil;
}

//准备节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    
    self.currentElement = elementName;
    if ([self.currentElement isEqualToString:@"sheet"]) {
        self.sheet = [[ZSheet alloc] init];
        self.sheet.name = attributeDict[@"name"];
        self.sheet.sheetId = attributeDict[@"sheetId"];
        self.sheet.rid = attributeDict[@"r:id"];
        [self.sheetArr addObject:self.sheet];
    }
}

//解析完一个节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    
    self.currentElement = nil;
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    self.xmlParser = nil;
}

@end
