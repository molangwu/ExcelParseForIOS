/******************************************************/
//
//  ProjectName: ZXLSXReader
//  FileName   : ZContent.h
//  Author     : Casanova.Z/朱静宁 16/8/25.
//  E-mail     : casanova.z@qq.com
//  Blog       : http://blog.sina.com.cn/casanovaZHU
//
//  Copyright © 2016年 casanova. All rights reserved.
/******************************************************/

#import <Foundation/Foundation.h>

@interface ZContent : NSObject<NSCoding>

@property (nonatomic, copy) NSString *sheetName;    // 所在文件的名称(sheet1,sheet2)
@property (nonatomic, copy) NSString *keyName;      // 在sheet中的标示(A1,B3)
@property (nonatomic, copy) NSString *value;        // 对应文件下对应标识下的值

@end
