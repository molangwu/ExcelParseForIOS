/******************************************************/
//
//  ProjectName: ZXLSXReader
//  FileName   : ZWorkbook.h
//  Author     : Casanova.Z/朱静宁 16/8/24.
//  E-mail     : casanova.z@qq.com
//  Blog       : http://blog.sina.com.cn/casanovaZHU
//
//  Copyright © 2016年 casanova. All rights reserved.
/******************************************************/

#import <Foundation/Foundation.h>

@interface ZSheet : NSObject

@property (nonatomic, copy) NSString *name;     // sheet的name属性值
@property (nonatomic, copy) NSString *sheetId;  // sheet的sheetId属性值
@property (nonatomic, copy) NSString *rid;      // sheet的r:id属性值

@end
