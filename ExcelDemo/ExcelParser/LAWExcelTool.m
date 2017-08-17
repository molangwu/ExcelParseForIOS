//
//  LAWExcelTools.m
//  ExcelDemo
//
//  Created by molangwu on 2017/8/17.
//  Copyright © 2017年 molangwu. All rights reserved.
//

#import "LAWExcelTool.h"
#import "ZWorkbookParser.h"
#import "ZXLSXParser.h"
#import "ZContent.h"
#import "CSV/CSVParser.h"
#import "DHxlsReaderIOS.h"

@interface LAWExcelTool()<ZXLSXParserDelegate>

@property (nonatomic, strong) ZXLSXParser *xmlPaser;

@end

@implementation LAWExcelTool

// 单例模式
+(LAWExcelTool *)shareInstance {
    static LAWExcelTool *instance;
    @synchronized(self) {
        if(!instance) {
            instance = [[LAWExcelTool alloc] init];
        }
    }
    return instance;
}

//解析excel
-(void) parserExcelWithPath:(NSString *)filePath {
    
    NSString *mimeType = [[[filePath componentsSeparatedByString:@"."] lastObject] lowercaseString];
    
    if([mimeType isEqualToString:@"csv"]) {
        [self parserExcel_CSV_WithPath:filePath];
    } else if ([mimeType isEqualToString:@"xls"]) {
        [self parserExcel_XLS_WithPath:filePath];
    } else if ([mimeType isEqualToString:@"xlsx"]) {
        [self parserExcel_XLSX_WithPath:filePath];
    } else {
        NSLog(@"excel格式不支持");
    }
}
//解析XLSX类型的excel
-(void)parserExcel_XLSX_WithPath:(NSString *)filePath {
    _xmlPaser = [ZXLSXParser defaultZXLSXParser];
    [_xmlPaser setParseFilePath:filePath];
    [_xmlPaser setParseOutType:ZParseOutTypeArrayObj];
    _xmlPaser.delegate = self;
    [_xmlPaser parse];
}
//解析XLS类型的excel
-(void)parserExcel_XLS_WithPath:(NSString *)filePath {
    NSMutableArray<ZContent *> *resultArray = [NSMutableArray array];
     DHxlsReader *reader = [DHxlsReader xlsReaderFromFile:filePath];
    NSString *text = @"";
    text = [text stringByAppendingFormat:@"AppName: %@\n", reader.appName];
    text = [text stringByAppendingFormat:@"Author: %@\n", reader.author];
    text = [text stringByAppendingFormat:@"Category: %@\n", reader.category];
    text = [text stringByAppendingFormat:@"Comment: %@\n", reader.comment];
    text = [text stringByAppendingFormat:@"Company: %@\n", reader.company];
    text = [text stringByAppendingFormat:@"Keywords: %@\n", reader.keywords];
    text = [text stringByAppendingFormat:@"LastAuthor: %@\n", reader.lastAuthor];
    text = [text stringByAppendingFormat:@"Manager: %@\n", reader.manager];
    text = [text stringByAppendingFormat:@"Subject: %@\n", reader.subject];
    text = [text stringByAppendingFormat:@"Title: %@\n", reader.title];
    [reader startIterator:0];
    int rows = reader.getRows;
    int cols = reader.getCols;
    for(int r=1;r<=rows;r++) {
        for(int c=1;c<=cols;c++) {
            unichar ch =64 + c;
            NSString *str =[NSString stringWithUTF8String:(char *)&ch];
            DHcell *cell = [reader cellInWorkSheetIndex:0 row:r col:c];
            ZContent *content = [[ZContent alloc] init];
            content.sheetName = [reader sheetNameAtIndex:0];
            content.keyName = [NSString stringWithFormat: @"%@%d", str,c+r-1];
            content.value = [cell dump];
            [resultArray addObject:content];
        }
    }
    
    __weak typeof(self) weakSelf = self;
    
    if([_delegate respondsToSelector:@selector(parser:success:)]){
        
        [weakSelf.delegate parser:weakSelf success:resultArray];
    }else{
        NSLog(@"delegate is fail....");
    }
    
}

//解析CSV类型的excel
-(void)parserExcel_CSV_WithPath:(NSString *)filePath {
    NSMutableArray *result = [CSVParser readCSVData:filePath];

    NSMutableArray<ZContent *> *resultArray = [NSMutableArray array];
    int row = 0;
    for(NSArray *item in result) {
        
        for(int i=0;i<item.count; i++) {
            
            unichar ch =65 + i;
            NSString *str =[NSString stringWithUTF8String:(char *)&ch];
            ZContent *content = [[ZContent alloc] init];
            content.sheetName = @"sheetName1";
            content.keyName = [NSString stringWithFormat: @"%@%d", str,i+1+row];
            content.value = item[i];
            [resultArray addObject:content];
        }
        row++;
        
    }
    
    __weak typeof(self) weakSelf = self;
    
    if([_delegate respondsToSelector:@selector(parser:success:)]){
        
        [weakSelf.delegate parser:weakSelf success:resultArray];
    }else{
        NSLog(@"delegate is fail....");
    }    
}


#pragma -mark xmlParser的结果代理方法
- (void)parser:(ZXLSXParser *)parser success:(id)responseObj {
    
    __weak typeof(self) weakSelf = self;
    
    if([_delegate respondsToSelector:@selector(parser:success:)]){
        
        [weakSelf.delegate parser:weakSelf success:responseObj];
    }else{
        NSLog(@"delegate is fail....");
    }

}


@end
