/******************************************************/
//
//  ProjectName: ZXLSXReader
//  FileName   : ZWorkbook.m
//  Author     : Casanova.Z/朱静宁 16/8/24.
//  E-mail     : casanova.z@qq.com
//  Blog       : http://blog.sina.com.cn/casanovaZHU
//
//  Copyright © 2016年 casanova. All rights reserved.
/******************************************************/

#import "ZSheet.h"

@implementation ZSheet

- (NSString *)description {
    
    return [NSString stringWithFormat:@"name:%@ sheetId:%@ rid:%@",self.name,self.sheetId,self.rid];
}


@end
