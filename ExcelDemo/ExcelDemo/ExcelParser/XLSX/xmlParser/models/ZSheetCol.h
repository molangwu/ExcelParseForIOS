/******************************************************/
//
//  ProjectName: ZXLSXReader
//  FileName   : ZSheetCol.h
//  Author     : Casanova.Z/朱静宁 16/8/24.
//  E-mail     : casanova.z@qq.com
//  Blog       : http://blog.sina.com.cn/casanovaZHU
//
//  Copyright © 2016年 casanova. All rights reserved.
/******************************************************/


/**
 *  此文件为sheet中解析出来的每列中的数据
 */

#import <Foundation/Foundation.h>

@interface ZSheetCol : NSObject

@property (nonatomic, copy) NSString *r;    // sheet中的c节点中属性r
@property (nonatomic, copy) NSString *s;    // sheet中的c节点中属性s
@property (nonatomic, copy) NSString *t;    // sheet中的c节点中属性t
@property (nonatomic, copy) NSString *v;    // sheet中的c节点中属性v
@property (nonatomic, copy) NSString *row;  // sheet中的c列所处的行号


@end
