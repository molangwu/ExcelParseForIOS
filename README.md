## 前言
由于项目需要解析excel，在网上找了很久，都没有找到一个齐全的轮子，所以我修改和整合了网上的解析excel教程。
##教程介绍
####1.解析csv
- CSV：
即逗号分隔值，其文件以纯文本形式存储表格数据（数字和文本）。
- 解析思路：
读取该文件，根据\n和，来解析出excel数据
\n用来区分excel的行
,用来区分excel的列

####2.解析 xls：
- xls
 就是 Microsoft Excel 工作表，是一种非常常用的电子表格格式。
- 解析思路
通过DHxlsReader框架来实现解析

####3.解析xlsx
- xlsx
即Microsoft Office EXCEL 2007/2010/2013/2016文档的扩展名
- 解析思路
 07版之后的excel基本都是xlsx格式的,其本质上其实是一个压缩文件,打开之后是一个文件夹,如下图

![1.png](http://upload-images.jianshu.io/upload_images/2814521-b1da8fb3792f95e2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![2.png](http://upload-images.jianshu.io/upload_images/2814521-1495c05d35b65a00.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

我们来分析一下这个文件夹的结构;shareString是一个公共的字符串池,相当于,给我们表中字符串贴上一个标签一样.然后我们先分析一下shareString.xml里面的内容

-----
![3.png](http://upload-images.jianshu.io/upload_images/2814521-c1f636df409757cb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

下面来解析worksheet中sheet1.xml

-----
![4.png](http://upload-images.jianshu.io/upload_images/2814521-95becc1395474a58.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

然后就这样循环的查下去,把你需要的内容查找出来

-  具体做法
   - 解压缩，用第三方库SSZipArchive，需导入libz.tbd库
   -  xml解析xl下的workbook.xml文件查询到底有几个sheet文件
   -  解析sheet中的数据，得到具体值在sharedStrings.xml中的索引，
   -  封装数据，返回其中已经有多线程了，不必自添加多线程执行此任务

-----
## 教程安装和使用
- 把ExcelParser文件夹拷贝的项目里面
- 导入libiconv.2.dylib和libz.tbd,
libiconv.2.dylib添加的时候可能要注意一点,要点加号,Add Other...,然后command+shift+g, 输入/usr/lib/ ,你就可以找到了.
- 设置header search Path
因为DHxlsReader中用到了C的库,所以你的头文件要加上下图所示.

![5.png](http://upload-images.jianshu.io/upload_images/2814521-0f83cbaea7c7e901.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

-  添加 .PCH文件 
否则会提示 NSObjct没找到
创建一个ExcelDemoDHlibxls-Prefix.pch文件 ,文件内容如下
````
//
// Prefix header for all source files of the 'TestDHlibxls' target in the 'TestDHlibxls' project
//

#import <Availability.h>

#ifndef __IPHONE_4_0
#warning "This project uses features only available in iOS SDK 4.0 and later."
#endif

#ifdef __OBJC__
	#import <UIKit/UIKit.h>
	#import <Foundation/Foundation.h>
#endif

````
修改Precompile Prefix Headers 为 yes
添加.pch文件路径到Prefix Header  如下图
![E31850E5-5B2C-4C54-B097-3091B9B04E25.png](http://upload-images.jianshu.io/upload_images/2814521-bf9c507834683e2a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
- clean项目
- build项目

[简书地址](http://www.jianshu.com/u/fc12eeedb47d)

---- 

#### 参考链接

http://www.jianshu.com/p/95c88a7073a6

http://blog.csdn.net/qxuewei/article/details/51733142

----
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
