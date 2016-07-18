//
//  SandboxManager.m
//  轮播器和沙盒工具
//
//  Created by Guan Nan Wang on 16/6/28.
//  Copyright © 2016年 Guan Nan Wang. All rights reserved.
//

#import "SandboxManager.h"


@implementation SandboxManager


+(void)checkSandboxfiles{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    
//     遍历document
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSError *error = nil;
    NSArray *documentDataArray = [manager contentsOfDirectoryAtPath:documentPath error:&error];
    [self fileNumberof:documentDataArray forDirectory:@"document"];
    
    
//     遍历caches
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    error = nil;
    NSArray *cachesDataArray = [manager contentsOfDirectoryAtPath:cachesPath error:&error];
    [self fileNumberof:cachesDataArray forDirectory:@"caches"];

//     遍历temp
    NSString *tempPath = NSTemporaryDirectory();
    error = nil;
    NSArray *tempDataArray = [manager contentsOfDirectoryAtPath:tempPath error:&error];
    [self fileNumberof:tempDataArray forDirectory:@"temp"];
    
//     检查preference    ???
     NSUserDefaults *defaults =  [NSUserDefaults standardUserDefaults];
    if (defaults == nil) {
        NSLog(@"用户偏好不存在");
    }
    else{
        NSLog(@"用户偏好存在");
    }
    
}

+(void)fileNumberof:(NSArray *)array forDirectory:(NSString *)dir{
    if (array.count == 0) {
        NSLog(@"%@目录是空目录",dir);
    }
    else{
        NSLog(@"%@目录下有%lu个文件(文件夹)",dir,array.count);
    }
}



//清空documents文件夹
+(void)deleteFilesInDocuments{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSError *error = nil;
    [manager removeItemAtPath:documentsPath error:&error];
    if (error == nil) {
        NSLog(@"document目录成功清空");
    }
    else{
        NSLog(@"删除document文件时发生错误%@",error);
    }

}


//清空caches文件夹
+(void)deleteFilesInCaches{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSError *error = nil;
    [manager removeItemAtPath:cachesPath error:&error];
    if (error == nil) {
        NSLog(@"caches目录成功清空");
    }
    else{
        NSLog(@"删除caches文件时发生错误%@",error);
    }

}

//清空temp文件夹
+(void)deleteFilesInTemp{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *tempPath = NSTemporaryDirectory();
    NSError *error = nil;
    [manager removeItemAtPath:tempPath error:&error];
    if (error == nil) {
        NSLog(@"temp目录成功清空");
    }
    else{
        NSLog(@"删除temp文件时发生错误%@",error);
    }
}


//用户偏好，发现并不准确，最好也不清空？
+(void)clearUserDefault{
    [NSUserDefaults resetStandardUserDefaults];
    
//       用户偏好到底怎么清空？？？？？？？？？？？？？？？
    
    NSLog(@"用户偏好已清空");
    
}



+(void)deleteSandboxFileAtPathStringOrURL:(NSObject *)target{
    
}

@end
