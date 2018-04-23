//
//  AppDelegate.m
//  Section
//
//  Created by QZL on 2017/1/18.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "YZBasicTabbarController.h"
#import "YZGuidePage.h"
#import "YZMainPageViewController.h"

@interface AppDelegate ()<YZGuidePageDelegate>

@property (nonatomic, assign) NSInteger ins;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.isSecret = YES;
    
    [self creatShortcutItem];  //动态创建应用图标上的3D touch快捷选项
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    //如果是从快捷选项标签启动app，则根据不同标识执行不同操作，然后返回NO，防止调用- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler
    if (shortcutItem) {
        //判断设置的快捷选项标签唯一标识，根据不同标识执行不同操作
        if([shortcutItem.type isEqualToString:@"com.yang.one"]){
            NSLog(@"新启动APP-- 第一个按钮");
        } else if ([shortcutItem.type isEqualToString:@"com.yang.search"]) {
            //进入搜索界面
            NSLog(@"新启动APP-- 搜索");
        } else if ([shortcutItem.type isEqualToString:@"com.yang.add"]) {
            //进入分享界面
            NSLog(@"新启动APP-- 添加联系人");
        }else if ([shortcutItem.type isEqualToString:@"com.yang.share"]) {
            //进入分享页面
            NSLog(@"新启动APP-- 分享");
        }
        
        return NO;
    }
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
//    YZBasicTabbarController * tabbarController = [YZBasicTabbarController shareinstancetype];
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appOldCurVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"CFBundleShortVersionString"];
    NSString *appNewCurVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] setObject:appNewCurVersion forKey:@"CFBundleShortVersionString"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    YZGuidePage * guidePage = [[YZGuidePage alloc] init];
    guidePage.delegate = self;
    
    if ([appOldCurVersion isEqualToString:appNewCurVersion]) {

        self.window.rootViewController = [[YZBasicNavigationController alloc] initWithRootViewController:[YZMainPageViewController new]];
        
    } else {
        
//        self.window.rootViewController = guidePage;

        self.window.rootViewController = [[YZBasicNavigationController alloc] initWithRootViewController:[YZMainPageViewController new]];
        
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)creatShortcutItem {
    //创建系统风格的icon
    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
    //创建快捷选项
    UIApplicationShortcutItem * item = [[UIApplicationShortcutItem alloc]initWithType:@"com.yang.share" localizedTitle:@"找朋友" localizedSubtitle:@"好友一箩筐" icon:icon userInfo:nil];
    
    //创建系统风格的icon
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeDate];
    //创建快捷选项
    UIApplicationShortcutItem * item1 = [[UIApplicationShortcutItem alloc]initWithType:@"com.yang.share" localizedTitle:@"好日子" localizedSubtitle:@"啪啪啪" icon:icon1 userInfo:nil];
    
    //创建系统风格的icon
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeHome];
    //创建快捷选项
    UIApplicationShortcutItem * item2 = [[UIApplicationShortcutItem alloc]initWithType:@"com.yang.share" localizedTitle:@"首页" localizedSubtitle:@"进入推荐" icon:icon2 userInfo:nil];
    
    //创建系统风格的icon
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeMail];
    //创建快捷选项
    UIApplicationShortcutItem * item3 = [[UIApplicationShortcutItem alloc]initWithType:@"com.yang.share" localizedTitle:@"消息" localizedSubtitle:@"私人订制" icon:icon3 userInfo:nil];
    
    //添加到快捷选项数组
    [UIApplication sharedApplication].shortcutItems = @[item,item1,item2,item3];
}

- (void)jumpToMainPage:(id)sender {

    self.window.rootViewController = [YZBasicTabbarController shareinstancetype];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
