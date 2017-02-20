//
//  ViewController.m
//  runtime归档
//
//  Created by 刘永玉 on 17/2/15.
//  Copyright © 2017年 LYY. All rights reserved.
//

#import "ViewController.h"
#import "StudentModel.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    StudentModel *student = [[StudentModel alloc] init];
    student.sex = @"0";
    student.name = @"张三";
    // 将student对象归档到file中
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:student] forKey:@"proviceCityArray"];
//    [NSKeyedArchiver archiveRootObject:student toFile:file]
    
    // 从file存档中解析对象到student中
    StudentModel *student_0 = [NSKeyedUnarchiver unarchiveObjectWithData:[userDefaults objectForKey:@"proviceCityArray"]];
    NSLog(@"student_0===%@......====%@",student_0.name, student_0.sex);
    
//    StudentModel *student_0 = [NSKeyedUnarchiver unarchiveObjectWithFile:file];



    MYLinkModel *MYmodel = [[MYLinkModel alloc] init];
    MYmodel.linkText = @"122211";
    NSLog(@"mymodel===%@", MYmodel.linkText);
    




}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
