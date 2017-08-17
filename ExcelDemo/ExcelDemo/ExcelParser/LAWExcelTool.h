//
//  LAWExcelTools.h
//  ExcelDemo
//
//  Created by molangwu on 2017/8/17.
//  Copyright © 2017年 molangwu. All rights reserved.
//  Github: https://github.com/molangwu/ExcelParseForIOS.git
//  E-mail: 672593619@qq.com

#import <Foundation/Foundation.h>

@class LAWExcelTool;
@protocol LAWExcelParserDelegate <NSObject>

@required

/**
 *  处理解析的结果
 *
 *  @param parser      解析器
 *  @param responseObj 解析结果
 *
 */
- (void)parser:(LAWExcelTool *)parser success:(id)responseObj;


@end

@interface LAWExcelTool : NSObject

@property (nonatomic, weak) id<LAWExcelParserDelegate> delegate;    // 回调处理

+(LAWExcelTool *) shareInstance;

-(void) parserExcelWithPath:(NSString *)filePath;

-(void) parserExcel_XLS_WithPath:(NSString *)filePath;
-(void) parserExcel_XLSX_WithPath:(NSString *)filePath;
-(void) parserExcel_CSV_WithPath:(NSString *)filePath;

@end


