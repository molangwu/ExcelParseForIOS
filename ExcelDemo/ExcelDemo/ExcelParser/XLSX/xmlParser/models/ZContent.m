/******************************************************/
//
//  ProjectName: ZXLSXReader
//  FileName   : ZContent.m
//  Author     : Casanova.Z/朱静宁 16/8/25.
//  E-mail     : casanova.z@qq.com
//  Blog       : http://blog.sina.com.cn/casanovaZHU
//
//  Copyright © 2016年 casanova. All rights reserved.
/******************************************************/

#import "ZContent.h"

static NSString *kSheetName = @"sheetName";    // 所在文件的名称(sheet1,sheet2)
static NSString *kKeyName = @"keyName";      // 在sheet中的标示(A1,B3)
static NSString *kValue = @"value";        // 对应文件下对应标识下的值

@implementation ZContent


- (NSString *)description {
    
    return [NSString stringWithFormat:@"sheetName:%@ keyName:%@ value:%@",self.sheetName,self.keyName,self.value];
}


- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.sheetName forKey:kSheetName];
    [aCoder encodeObject:self.keyName forKey:kKeyName];
    [aCoder encodeObject:self.value forKey:kValue];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        self.sheetName = [aDecoder decodeObjectForKey:kSheetName];
        self.keyName = [aDecoder decodeObjectForKey:kKeyName];
        self.value = [aDecoder decodeObjectForKey:kValue];
    }
    return self;
}




@end
