/******************************************************/
//
//  ProjectName: ZXLSXReader
//  FileName   : ZContentParser.m
//  Author     : Casanova.Z/朱静宁 16/8/24.
//  E-mail     : casanova.z@qq.com
//  Blog       : http://blog.sina.com.cn/casanovaZHU
//
//  Copyright © 2016年 casanova. All rights reserved.
/******************************************************/

#import "ZContentParser.h"
#import "ZContent.h"
#import "ZSheetCol.h"
#import "config.h"

@interface ZContentParser ()
{
    NSString *currentSheetName; // 当前文件（sheet）名称
    
}
@property (nonatomic, strong) NSMutableArray<ZContent *> *contentArr;   // 存储所有的解析出的数据
@property (nonatomic, copy) NSMutableString *currentString; // 当前解析出来的数据
@property (nonatomic, strong) NSMutableArray *vArr;         // 记录sharedString.xml中的数据是否已经被引用了，如果应用了，则会重复操作同一个数据，因为如果在数据内容相同，在sharedString.xml中是不会重复出现的（so 在解析的时候，如果值有重复，contenArr相对就会缺少一个），故如果已经被使用，则需要在重新添加对象，设置其值，


@end


@implementation ZContentParser


- (NSMutableArray *)vArr {
    
    if (!_vArr) {
        _vArr = [NSMutableArray array];
    }
    return _vArr;
}

- (NSMutableArray<ZContent *> *)contentArr {
    
    if (!_contentArr) {
        _contentArr = [NSMutableArray array];
    }
    return _contentArr;
}

- (NSMutableString *)currentString {
    
    if (!_currentString) {
        _currentString = [NSMutableString stringWithFormat:@""];
    }
    return _currentString;
}
/**
 *  开始解析
 *
 *  @return 解析出的数据
 */
- (id)startParse {

    // 指定要解析的文件的路径
    NSString *path = [NSString stringWithFormat:@"%@/xl/sharedStrings.xml",destinationPath];
    self.parseFilePath = path;
    
    // 进行解析，
    self.xmlParser.delegate = self;
    [self.xmlParser parse];

    return [self makeContent];
}

//准备节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    
    self.currentElement = elementName;
}

// 3. 查找节点内容，可能会多次
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([self.currentElement isEqualToString:@"t"]) {
        
        [self.currentString appendString:string];
    }
}

//解析完一个节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{

    if ([elementName isEqualToString:@"t"]) {
        
        ZContent *content = [[ZContent alloc] init];
        content.value     = self.currentString;
        self.currentString = nil;
        [self.contentArr addObject:content];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    self.xmlParser = nil;
}


/**
 *  为content对象填充keyName数据
 *
 *  @return 填充后的最终数据
 */
- (NSArray *)makeContent{
    
    if(self.allColDict && self.allColDict.count > 0){
        NSArray *arrKeys = self.allColDict.allKeys;
        // 索引里每个格子的索引都有，只是格子中为数字的索引中直接就是数据，如果为中文或者英文的，则为格子内容的索引，故此处的索引个数是对的，但是到后面解析的时候，从sharedStrings.xml中解析出来的数据要比索引个数少，因为数字的内容直接就在索引文件中显示，sharedStrings.xml文件里没有在体现，
            // 故这里要做的是将已经有的对象属性进行填充，并对没有添加的对象进行添加，实现个数对等
        for (int i = 0; i < arrKeys.count; i++) {
            
            NSString *sheetName = arrKeys[i];
            NSArray *arr = self.allColDict[sheetName];
            for (int j = 0 ; j < arr.count; j++) {
             
                ZSheetCol *sheetCol = arr[j];
                if([sheetCol.t isEqualToString:@"s"]){
                   
                    NSInteger v = [sheetCol.v integerValue];
                    if ([self.vArr containsObject:sheetCol.v]) {
                        
                        ZContent *content = [[ZContent alloc] init];
                        content.keyName   = sheetCol.r;
                        content.sheetName = sheetName;
                        content.value = self.contentArr[v].value;
                        [self.contentArr addObject:content];
                    }else{
                        
                        self.contentArr[v].keyName = sheetCol.r;
                        self.contentArr[v].sheetName = sheetName;
                        [self.vArr addObject:sheetCol.v];   // 标记是否已经使用过该值
                    }
                }else{
                    ZContent *content = [[ZContent alloc] init];
                    content.keyName   = sheetCol.r;
                    content.sheetName = sheetName;
                    content.value     = sheetCol.v;
                    [self.contentArr addObject:content];
                }
            }
        }
    }
    [self sortArrayAsc];
    return self.contentArr;
}


/**
 *  给数组排序,先判断sheet中的sheetName的大小
 *  后再sheetName相同的情况下判断的keyName的大小
 *
 *  @param arr 需要排序的数组
 */
- (void)sortArrayAsc{
    
    [self.contentArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        ZContent *content1 = (ZContent *)obj1;
        ZContent *content2 = (ZContent *)obj2;
        if (content1.sheetName > content2.sheetName) {
            return YES;
        }else{
            return NO;
        }
    }];
    
    [self.contentArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        ZContent *content1 = (ZContent *)obj1;
        ZContent *content2 = (ZContent *)obj2;
        if ([content1.sheetName isEqualToString:content2.sheetName]&&content1.keyName > content2.keyName) {
            return YES;
        }else{
            return NO;
        }
    }];
}
@end
