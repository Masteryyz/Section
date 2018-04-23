//
//  GCDAsynSocketManager.m
//  Section
//
//  Created by QZL on 2017/9/28.
//  Copyright © 2017年 WTF. All rights reserved.
//

#import "GCDAsynSocketManager.h"

#define SocketServiceHost @"45.76.202.151"
#define SocketPort 6784

static GCDAsynSocketManager * managerInstance = nil;
static long writeTag = 1;
static long readTag = 200;

static long timeOut = 15;

@interface GCDAsynSocketManager () <GCDAsyncSocketDelegate>

/**
 握手次数
 */
@property (nonatomic, assign) NSInteger shakeCount;

/**
 断线重连计时器
 */
@property (nonatomic, strong) NSTimer * reLinkTimer;

/**
 断线重连计数器
 */
@property (nonatomic, assign) NSInteger reLinkCount;

/**
 错误信息收集
 */
@property (nonatomic, strong) NSError * error;


//数据集合
@property (nonatomic, strong) NSData * jsonData;
@property (nonatomic, strong) NSData * responseData;

@end

@implementation GCDAsynSocketManager

- (void)socket_connetToServiceHostWithJsonData:(NSData *)jsonData andConnetBlock:(returnBlock)returnBlock hasError:(errorBlock)errorBlock {

    if (!self.socket) {
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    
    _shakeCount = 0;
    _error = nil;
    
    _jsonData = jsonData;
    _responseData = [NSData data];
    _returnBlock = returnBlock;
    _errorBlock = errorBlock;
    
    NSError * error = nil;
    
    [self.socket connectToHost:SocketServiceHost onPort:SocketPort error:&error];

    if (error) {
        _error = error;
        
        NSLog(@"%@" , error);
        
        if (errorBlock) {
            errorBlock(error);
        }
        
    }

}

#pragma mark -- socket链接成功了 -- delegate --

/**
 链接成功, 准备向服务器发送数据

 @param sock sock
 @param host SocketServiceHost
 @param port SocketPort
 */
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    
    if (_jsonData) {
        
        //读写
        [self.socket writeData:_jsonData withTimeout:timeOut tag:writeTag];
        [self.socket readDataWithTimeout:timeOut tag:readTag];
        
    } else {
        
        if (_errorBlock) {
            _errorBlock([NSError errorWithDomain:NSCocoaErrorDomain code:SocketPort userInfo:@{@"error" : @"连接成功但是没有向服务器发送任何数据"}]);
        }
        
    }
    
}


/**
 服务器读取数据之后, 给予的响应

 @param sock socket
 @param data 响应数据
 @param tag 标志位
 */
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {//成功处理

    if (tag == readTag) {
     
        [self.socket readDataWithTimeout:timeOut tag:readTag];
        
        self.shakeCount ++;
        
        //准备进行校验 success / error -- 外部校验
        
        if (_returnBlock) {
            _returnBlock (data);
        }
        
    } else {
    
        if (_errorBlock) {
            _errorBlock([NSError errorWithDomain:NSCocoaErrorDomain code:SocketPort userInfo:@{@"error" : @"tag值异常"}]);
        }
    
    }

}

#pragma mark -- socket链接失败了 -- delegate --
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {//失败回调

    NSLog( @" 连接失败");
    _error = err;
    
    //重置握手次数
    self.shakeCount = 0;
    
    //检查程序状态 (前台 --> 断线重连) (后台 --> 短线不重连)
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    
    NSLog(@"%ld" , (long)state);
    
    if (state == UIApplicationStateActive) {
     
        //准备进行重连
        self.reLinkCount ++;
        
        //降低重链频率
        NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:self.reLinkCount * 1.0 target:self selector:@selector(reConnectService:) userInfo:nil repeats:NO];
        
        self.reLinkTimer = timer;
        
    } else {
    
        if (_errorBlock) {
            _errorBlock([NSError errorWithDomain:NSCocoaErrorDomain code:SocketPort userInfo:@{@"error" : @"APP处于后台运行"}]);
        }
    
    }
    
}

- (void) reConnectService:(id) sender {//重新连接
    
    self.shakeCount = 0;
//    self.reLinkCount = 0;
    
    _error = nil;
    
    NSError * error = nil;
    
    [self.socket connectToHost:SocketServiceHost onPort:SocketPort error:&error];
    
    if (error) {
        _error = error;
        
        NSLog(@"%@" , error);
        
        if (_errorBlock) {
            _errorBlock(_error);
        }
        
    }
    
}

/**
 断开链接
 */
- (void)socket_disConnet {//断开连接
    
    self.shakeCount = 0;
    self.reLinkCount = 0;
    
    [self.reLinkTimer invalidate];
    self.reLinkTimer = nil;
    
    [self.socket disconnect];
    
}

//--------------------------------------------------------- Factory
+ (GCDAsynSocketManager *)shareManager {
    return [[self alloc]init];
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    if (managerInstance == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            managerInstance = [super allocWithZone:zone];
            [managerInstance addObserver:managerInstance forKeyPath:@"status" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        });
    }
    return managerInstance;
}

- (id)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        managerInstance = [super init];
        
        //初始化握手次数
        self.shakeCount = 0;
        
        self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
        
        self.error = nil;
        
    });
    return managerInstance;
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return managerInstance;
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return managerInstance;
}


@end
