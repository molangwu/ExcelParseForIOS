//
//  CSVParser.h
//  ExcelDemo
//
//  Created by molangwu on 2017/8/17.
//  Copyright © 2017年 molangwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSVParser : NSObject

+ (NSMutableArray *)readCSVData:(NSString *)filePath;

@end
