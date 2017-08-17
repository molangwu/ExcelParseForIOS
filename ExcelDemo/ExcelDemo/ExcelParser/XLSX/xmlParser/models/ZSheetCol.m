/******************************************************/
//
//  ProjectName: ZXLSXReader
//  FileName   : ZSheetCol.m
//  Author     : Casanova.Z/朱静宁 16/8/24.
//  E-mail     : casanova.z@qq.com
//  Blog       : http://blog.sina.com.cn/casanovaZHU
//
//  Copyright © 2016年 casanova. All rights reserved.
/******************************************************/

#import "ZSheetCol.h"

@implementation ZSheetCol


- (NSString *)description {
    
    return [NSString stringWithFormat:@"row:%@ r:%@ t:%@ v:%@",self.row,self.r,self.t,self.v];
}

@end
