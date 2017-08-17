/******************************************************/
//  NSString+ZPaserProtocol.h
//  ZXLSXReader
//
//  Created by Casanova.Z/朱静宁 16/8/24.
//  博   客 :http://blog.sina.com.cn/casanovaZHU
//  E-mail :casanova.z@qq.com
//
//  Copyright © 2016年 casanova. All rights reserved.
/******************************************************/


/**
 *  此文件规范解析类所具有的功能
 */
#import <Foundation/Foundation.h>

@protocol ZPaserProtocol <NSObject>


@required

/**
 *  开始解析
 *
 *  @return 解析出的数据
 */
- (id)startParse;


@end
