/******************************************************/
//
//  ProjectName: ZXLSXReader
//  FileName   : ZXMLParser.m
//  Author     : Casanova.Z/朱静宁 16/8/24.
//  E-mail     : casanova.z@qq.com
//  Blog       : http://blog.sina.com.cn/casanovaZHU
//
//  Copyright © 2016年 casanova. All rights reserved.
/******************************************************/

#import "ZXLSXParser.h"
#import "config.h"
#import "SSZipArchive.h"
#import "ZWorkbookParser.h"
#import "ZSheetParser.h"
#import "ZContentParser.h"
#import "ZContent.h"

@interface ZXLSXParser ()


@property (nonatomic, strong) ZWorkbookParser *wbParser;    // workbookParser的解析器
@property (nonatomic, strong) ZSheetParser *sheetParser;    // sheetParser的解析器
@property (nonatomic, strong) ZContentParser *contentParser;// 内容的解析器


@end

@implementation ZXLSXParser

+ (instancetype)defaultZXLSXParser {
    
    static ZXLSXParser *_xLSXParser;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _xLSXParser = [[ZXLSXParser alloc] init];
    });
    
    return _xLSXParser;
}

- (ZParseOutType)parseOutType {
    
    if(!_parseOutType){
        _parseOutType = ZParseOutTypeArrayObj;
    }
    return _parseOutType;
}


- (void)parse {
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // 解压xlsx文件
        [SSZipArchive  unzipFileAtPath:self.parseFilePath toDestination:destinationPath];
        
        // 解析workbook.xml文件
        NSArray *sheetArr = [weakSelf parseWorkbook];
        
        // 解析sheet文件，获取具体值在sharedString.xml中的索引
        NSDictionary *dict = [weakSelf parseSheetWithSheetArr:sheetArr];
        
        // 解析最终结果
        NSArray<ZContent *> *result = [weakSelf parseSharedStringsWithAllColDict:dict];
        
        if([_delegate respondsToSelector:@selector(parser:success:)]){

            id finalResult = [weakSelf makeOutContent:result];
            [weakSelf.delegate parser:weakSelf success:finalResult];
        }else{
            NSLog(@"delegate is fail....");
        }
        
        // 删除临时文件
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            if([fileManager fileExistsAtPath:destinationPath]){
                NSError *error;
                if([fileManager removeItemAtPath:destinationPath error:&error]&& !error){
//                    NSLog(@"file remove success....");
                }else if(error){
                    NSLog(@"file remove failure.... error:%@",error);
                }
            }
        });
    });
}

/**
 *  解析workbook.xml中的数据
 *
 *  @return sheet的集合数组
 */
- (NSArray *)parseWorkbook{

    _wbParser = [[ZWorkbookParser alloc] init];
    return [_wbParser startParse];
}


/**
 *  解析每个sheet文件
 *
 *  @return 解析出的数据数组
 */
- (NSDictionary *)parseSheetWithSheetArr:(NSArray *)arr {
  
    _sheetParser = [[ZSheetParser alloc] init];
    [_sheetParser setSheetArr:arr];
    return [_sheetParser startParse];
}

/**
 *  根据索引从sharedStrings.xml中解析数据
 *
 *  @param dict 从sheet中解析出来的索引数据
 *
 *  @return 对应的数据数组
 */
- (NSArray<ZContent *> *)parseSharedStringsWithAllColDict:(NSDictionary *)dict {

    _contentParser = [[ZContentParser alloc] init];
    [_contentParser setAllColDict:dict];
    return [_contentParser startParse];
}

/**
 *  根据设置的输出数据格式，重组数据
 *
 *  @return 重组后的数据
 */
- (id)makeOutContent:(NSArray<ZContent *> *)resultArr {
    
    id resultObj = nil;
    
    switch (self.parseOutType) {
        case ZParseOutTypeJson:
            
            resultObj = [self makeJsonString:resultArr];
            break;
            
        case ZParseOutTypeArrayObj:
            
            resultObj = resultArr;
            break;
            
        case ZParseOutTypeArrayDict:
            resultObj = [self makeArrayDictWithResultArray:resultArr];
            break;
            
        default:
            resultObj = nil;
            break;
    }
    
    return resultObj;
}

/**
 *  将结果集合组合成json字符串
 *
 *  @param arr 结果集合
 *
 *  @return json字符串
 */
- (NSString *)makeJsonString:(NSArray *)arr {
    
    NSError *error;
    NSArray *dictArr = [self makeArrayDictWithResultArray:arr];
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictArr options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }else{
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    return nil;
}

/**
 *  将结果集合组合成数组加字典的形式
 *
 *  @param arr 结果集合
 *
 *  @return 结果集合
 */
- (NSArray<NSDictionary *> *)makeArrayDictWithResultArray:(NSArray *)arr {
    
    NSMutableArray *resultArr = [NSMutableArray array];
    for(int i = 0;i< arr.count;i++){
        
        ZContent *content = arr[i];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"sheetName"] = content.sheetName;
        dict[@"keyName"] = content.keyName;
        dict[@"value"] = content.value;
        [resultArr addObject:dict];
    }
    return resultArr;
}



@end
