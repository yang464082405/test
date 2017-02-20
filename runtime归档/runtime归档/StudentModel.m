//
//  StudentModel.m
//  runtime归档
//
//  Created by 刘永玉 on 17/2/15.
//  Copyright © 2017年 LYY. All rights reserved.
//

#import "StudentModel.h"
#import <objc/runtime.h>


@implementation StudentModel

/*  非runtime 归档解档
// 存档的时候需要实现
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
}

// 解档的时候需要实现
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.sex  = [aDecoder decodeObjectForKey:@"sex"];
    }
    return self;
}
 */


// runtime 归档解档
// 返回self的所有对象名称
+ (NSArray *)propertyOfSelf{
    unsigned int count;
    
    // 1. 获得类中的所有成员变量
    Ivar *ivarList = class_copyIvarList(self, &count);

    NSMutableArray *properNames =[NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        
        // 2.获得成员属性名
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        
        // 3.除去下划线，从第一个角标开始截取
        NSString *key = [name substringFromIndex:1];
        
        [properNames addObject:key];
    }
    
    return [properNames copy];
}

// 归档
- (void)encodeWithCoder:(NSCoder *)enCoder{
    // 取得所有成员变量名
    NSArray *properNames = [[self class] propertyOfSelf];
    
    for (NSString *propertyName in properNames) {
        // 创建指向get方法
        SEL getSel = NSSelectorFromString(propertyName);
        // 对每一个属性实现归档
        [enCoder encodeObject:[self performSelector:getSel] forKey:propertyName];
    }
} 

// 解档
- (id)initWithCoder:(NSCoder *)aDecoder{
    // 取得所有成员变量名
    NSArray *properNames = [[self class] propertyOfSelf];
    
    for (NSString *propertyName in properNames) {
        // 创建指向属性的set方法
        // 1.获取属性名的第一个字符，变为大写字母
        NSString *firstCharater = [propertyName substringToIndex:1].uppercaseString;
        // 2.替换掉属性名的第一个字符为大写字符，并拼接出set方法的方法名
        NSString *setPropertyName = [NSString stringWithFormat:@"set%@%@:",firstCharater,[propertyName substringFromIndex:1]];
        SEL setSel = NSSelectorFromString(setPropertyName);
        [self performSelector:setSel withObject:[aDecoder decodeObjectForKey:propertyName]];
    }
    return  self;
}

- (NSString *)description{
    NSMutableString *descriptionString = [NSMutableString stringWithFormat:@"\n"];
    // 取得所有成员变量名
    NSArray *properNames = [[self class] propertyOfSelf];
    for (NSString *propertyName in properNames) {
        // 创建指向get方法
        SEL getSel = NSSelectorFromString(propertyName);
        
        NSString *propertyNameString = [NSString stringWithFormat:@"%@ - %@\n",propertyName,[self performSelector:getSel]];
        [descriptionString appendString:propertyNameString];
    }
    return [descriptionString copy];
}



@end


@implementation MYLinkModel


@end


