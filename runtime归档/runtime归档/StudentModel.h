//
//  StudentModel.h
//  runtime归档
//
//  Created by 刘永玉 on 17/2/15.
//  Copyright © 2017年 LYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentModel : NSObject <NSCoding>

/** name */
@property (nonatomic,copy) NSString *name;
/** sex */
@property (nonatomic,copy) NSString *sex;



@end

@interface MYLinkModel : NSObject

@property (nonatomic, copy) NSString *linkText;  //链接内容

@end


