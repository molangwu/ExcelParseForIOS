//
//  CSVParser.m
//  ExcelDemo
//
//  Created by molangwu on 2017/8/17.
//  Copyright © 2017年 molangwu. All rights reserved.
//

#import "CSVParser.h"

@implementation CSVParser

+ (NSMutableArray *)readCSVData:(NSString *)filePath {
    NSMutableArray *_InfoArray;
    if (_InfoArray) {
        return NULL;
    }
    _InfoArray=[[NSMutableArray alloc]init];
    
    FILE *fp=fopen([filePath UTF8String], "r");
    if (fp) {
        // 处理文本信息 转化 成 数组文件
        do {
            char buf[BUFSIZ];
            fgets(buf, BUFSIZ, fp);
            
            // 处理文本信息 转化 成 数组文件
            NSString *s=[[NSString alloc]initWithUTF8String:(const char *)buf];
            NSString *ss=[s stringByReplacingOccurrencesOfString:@"\r" withString:@""];
            ss=[ss stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            NSArray *a=[ss componentsSeparatedByString:@","];
            
            [_InfoArray addObject:a];
        } while (!feof(fp));
        
    }
    return _InfoArray;
}
@end
