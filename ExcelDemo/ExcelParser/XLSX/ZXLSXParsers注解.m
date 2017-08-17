/******************************************************/
//  NSString+ZXLSXParsers__.h
//  ZXLSXReader
//
//  Created by Casanova.Z/朱静宁 16/8/24.
//  博   客 :http://blog.sina.com.cn/casanovaZHU
//  E-mail :casanova.z@qq.com
//
//  Copyright © 2016年 casanova. All rights reserved.
/******************************************************/

/* 
 xlsx文件的解析步骤
 因为xlsx文件可以解压，在解压的文件中有相应的内容部署情况记录
 在xl文件夹下的sheet文件中记录着每个格子（A1,A2）的值在shareStrings在文件中的位置索引，
 解析这两个文件就可得到对应的xlsx的文件内容
 
 
 1. 解压缩，用第三方库SSZipArchive，需导入libz.tbd库
 2. xml解析xl下的workbook.xml文件查询到底有几个sheet文件
 3. 解析sheet中的数据，得到具体值在sharedStrings.xml中的索引，
 4. 封装数据，返回其中已经有多线程了，不必自添加多线程执行此任务
 
 // 使用方法
 1.创建ZXLSXParser对象,
 + (instancetype)defaultZXLSXParser;
 
 2.设置要解析的文件路径
 NSString *unzipFilePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"xlsx"];
 [_xmlPaser setParseFilePath:unzipFilePath];
 
 3.设置输出数据时的格式
 [_xmlPaser setParseOutType:ZParseOutTypeJson]; // JSON字符串格式
 //    [_xmlPaser setParseOutType:ZParseOutTypeArrayObj];// 数组中存放的是ZContent对象
 //    [_xmlPaser setParseOutType:ZParseOutTypeArrayDict];// 数组中盛放的是字典，每个字典存放每一格的相关数据
 
 4.设置代理，处理结果，设置的ParseOutType类型，在返回接受处理的时候要类型匹配
 _xmlPaser.delegate = self;
 
 5.开始解析
 [_xmlPaser parse];

 */

