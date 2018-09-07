//
//  FirstViewController.m
//  LibararyManage
//
//  Created by 潘伟杰 on 2018/8/12.
//  Copyright © 2018年 renda. All rights reserved.
//

#import "FirstViewController.h"
#import "FMDB.h"

#define  message_for(a, b) NSLog(@#a " and " #b ": We love you!")
#define  tokenpaster(n) NSLog (@"system" #n " = %d", system##n)

@interface FirstViewController ()
@property(nonatomic,strong)FMDatabase *db;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self test];
}

- (void)test{
    /* local variable definition */
    int a = 10;
    
    /* do loop execution */
    do
    {
        if( a == 15)
        {
            /* skip the iteration */
            a = a + 1;
            continue;
        }
        NSLog(@"value of a: %d", a);
              a++;
              
        }while( a < 20 );
    
    
    message_for(Carole, Debra);
    int system34 = 40;
    tokenpaster(34);
    [self createDB];
    [self insert];
    [self query];
}


- (void)createDB{
    //1.获得数据库文件的路径
        NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName=[doc stringByAppendingPathComponent:@"student.sqlite"];
    
    NSLog(@"==========%@",fileName);
         //2.获得数据库
         FMDatabase *db=[FMDatabase databaseWithPath:fileName];
    
         //3.打开数据库
         if ([db open]) {
                 //4.创表
                BOOL result=[db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
                if (result) {
                    NSLog(@"创表成功");
                    }else
                {
                         NSLog(@"创表失败");
                     }
             }
        self.db=db;
}



//插入数据
 -(void)insert
 {
    for (int i = 0; i<10; i++) {
            NSString *name = [NSString stringWithFormat:@"jack-%d", arc4random_uniform(100)];
            // executeUpdate : 不确定的参数用?来占位
                [self.db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);", name, @(arc4random_uniform(40))];
                //        [self.db executeUpdate:@"INSERT INTO t_student (name, age) VALUES (?, ?);" withArgumentsInArray:@[name, @(arc4random_uniform(40))]];
    
                 // executeUpdateWithFormat : 不确定的参数用%@、%d等来占位
                 //        [self.db executeUpdateWithFormat:@"INSERT INTO t_student (name, age) VALUES (%@, %d);", name, arc4random_uniform(40)];
             }
     }

 //删除数据
 -(void)delete
 {
         //    [self.db executeUpdate:@"DELETE FROM t_student;"];
         [self.db executeUpdate:@"DROP TABLE IF EXISTS t_student;"];
         [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
     }

 //查询
 - (void)query
 {
         // 1.执行查询语句
         FMResultSet *resultSet = [self.db executeQuery:@"SELECT * FROM t_student"];

         // 2.遍历结果
         while ([resultSet next]) {
                int ID = [resultSet intForColumn:@"id"];
                 NSString *name = [resultSet stringForColumn:@"name"];
                 int age = [resultSet intForColumn:@"age"];
                 NSLog(@"%d %@ %d", ID, name, age);
             }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
