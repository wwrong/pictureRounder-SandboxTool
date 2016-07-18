//
//  SandboxManager.h
//  轮播器和沙盒工具
//
//  Created by Guan Nan Wang on 16/6/28.
//  Copyright © 2016年 Guan Nan Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SandboxManager : NSObject

+(void)checkSandboxfiles;

+(void)deleteSandboxFileAtPathStringOrURL:(NSObject *)target;

+(void)deleteFilesInDocuments;
+(void)deleteFilesInCaches;
+(void)deleteFilesInTemp;
+(void)clearUserDefault;
@end



//1、做一个轮播的控件
/**
 *  使用UICollectionView
    使用三个cell，实现无限循环。
    仿照zeus主页轮播的UI
 */







//2、做一个查看沙盒的控件，并且支持基本文件的查看及删除
/**
 沙盒目录：
 documents
 caches
 temp
 perferences
 
 
 *  功能：
    查看文件：分别使用NSFileManager遍历这些文件夹，返回其中是否有数据，如果有，返回数据的数量。
    删除：可以选择删除某个目录下的全部文件，方法是直接删除这个文件夹？
    基本文件的查看和删除。
 */


