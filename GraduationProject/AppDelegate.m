//
//  AppDelegate.m
//  GraduationProject
//
//  Created by CYM on 2020/4/18.
//  Copyright © 2020年 CYM. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import "GPTabBarViewController.h"
#import "ZBLocalNotification.h"

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@property (nonatomic ,strong) NSMutableArray *userInfos;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:1];
    self.userInfos = [[NSMutableArray alloc]init];
    [self registerLocalNotification:launchOptions application:application];
    [self setTabbarAndWindow];
    [self createDateBase];
    [self createFileManager];
    return YES;
}

// createFileManager
- (void)createFileManager {
    GPFileManager *manager = [GPFileManager shareInstance];
    [manager createGPFilesFolder];
}

// createDateBase
- (void)createDateBase {
    DBTool *db = [DBTool shareInstance];
    [db createAppAllDBs];
}

// set Tabbar & Window
- (void)setTabbarAndWindow {
    // 初始化窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    // 初始化tabbar
    GPTabBarViewController *tabbarVC = [[GPTabBarViewController alloc] init];
    // 设置根试图控制器
    self.window.rootViewController = tabbarVC;
    // 显示窗口
    [self.window makeKeyAndVisible];
}

#pragma mark - UNUserNotification

//处理接收到的通知信息
- (void)filteredUserInfo {
    if (self.userInfos.count == 0) {
        return;
    }
    //选出你希望显示的通知信息，以下方法是显示优先级高的，你可以判断不同的条件
    //排序所有收到的通知信息，对比优先级，把优先级最高的放首位
    [self.userInfos sortUsingComparator:^NSComparisonResult(NSDictionary * obj1, NSDictionary * obj2) {
        if ([obj1[ZBNotificationPriority] integerValue] < [obj2[ZBNotificationPriority] integerValue]) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
    
    //自定义展示推送内容
    //    [self showAlarmAlertWithUserInfo:self.userInfos.firstObject];
    NSLog(@"%@",self.userInfos.firstObject);
    //重置userInfo容器
    [self.userInfos removeAllObjects];
}
//添加通知到userInfo容器
- (void)waitMultipleUserInfo:(NSDictionary *)userInfo {
    [self.userInfos addObject:userInfo];
    //创建信号量，设置为0
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t quene = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(quene, ^{
        
        if (self.userInfos.count == 1) {
            //信号量为0时，那么这个函数就阻塞当前线程等待timeout，时间到后继续执行
            //0.3秒内第一次进入则等待0.3秒，0.3秒后对本时间段内提醒提取优先级最高的一个
            //就是保存在极短时间内（我这里设置为0.3s）收到的所有通知，然后进行处理
            dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC));
            dispatch_async(dispatch_get_main_queue(), ^{
                [self filteredUserInfo];
            });
        }
    });
    
}

#pragma mark - localNotification

// iOS10以下 在前台收到推送回调
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    [self waitMultipleUserInfo:notification.userInfo];
}

#pragma mark - UNUserNotificationCenterDelegate
// iOS10 在前台收到推送回调
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(nonnull UNNotification *)notification withCompletionHandler:(nonnull void (^)(UNNotificationPresentationOptions))completionHandler{
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; //收到推送消息的全部内容
    
    if ([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 收到远程通知");
    }else{
        NSLog(@"ios10 收到本地通知userInfo:%@",content.userInfo);
        [self waitMultipleUserInfo:content.userInfo];
    }
    completionHandler(UNNotificationPresentationOptionBadge |
                      UNNotificationPresentationOptionSound
                      );
    
}

- (void)registerLocalNotification:(NSDictionary *)launchOptions application:(UIApplication *)application {
    //注册通知
    if (@available(iOS 8, *)) {
        if (UIDevice.currentDevice.systemVersion.floatValue >=10.0) {
            if (@available(iOS 10, *)) {
                UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
                //请求获取通知权限（角标，声音，弹框）
                [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge |
                                                         UNAuthorizationOptionSound |
                                                         UNAuthorizationOptionAlert)
                                      completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                          if (granted) {
                                              //获取用户是否同意开启通知
                                              NSLog(@"开启通知成功!");
                                          }
                                      }];
            }
        }else{
            // 注册本地通知, ios8之后必须要注册
            if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)]){
                [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
            }
        }
    }
}

#pragma mark - app

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
