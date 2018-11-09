//
//  BinzAPITool.m
//  XiaoTuanTuanHD
//
//  Created by 张彬 on 2018/8/4.
//  Copyright © 2018年 bin.z. All rights reserved.
//  内部封装DPAPI工具类

#import "BinzAPITool.h"
#import "DPAPI.h"

@interface BinzAPITool () <DPRequestDelegate>

// 大众点评api
@property (nonatomic, strong) DPAPI *dpAPI;
// 成功字典
//@property (nonatomic, strong) NSMutableDictionary *successDictionary;
// 失败字典
//@property (nonatomic, strong) NSMutableDictionary *failureDictionary;
// 包含了成功的block、失败的block
@property (nonatomic, strong) NSMutableDictionary *requestBlockDictionary;

@end

@implementation BinzAPITool

BinzSingletonM(APITool)

#pragma mark - lazy

- (DPAPI *)dpAPI{
    if (!_dpAPI) {
        _dpAPI = [[DPAPI alloc] init];
    }
    return _dpAPI;
}

//- (NSMutableDictionary *)successDictionary{
//    if (!_successDictionary) {
//        _successDictionary = [NSMutableDictionary dictionary];
//    }
//    return _successDictionary;
//}
//
//- (NSMutableDictionary *)failureDictionary{
//    if (!_failureDictionary) {
//        _failureDictionary = [NSMutableDictionary dictionary];
//    }
//    return _failureDictionary;
//}

- (NSMutableDictionary *)requestBlockDictionary{
    if (!_requestBlockDictionary) {
        _requestBlockDictionary = [NSMutableDictionary dictionary];
    }
    return _requestBlockDictionary;
}

// 发送请求
- (void)requestWithURL:(NSString *)url params:(NSMutableDictionary *)params success:(void (^)(id json)) success failure:(void (^)(NSError * error))failure{
    DPRequest *request = [self.dpAPI requestWithURL:url params:params delegate:self];
    // 方式一
    request.success = success;
    request.failure = failure;
    // 方式二
//    //successDictonary字典中 一个request.description的key 对应着 一个success的value
//    [self.successDictionary setObject:success forKey:request.description];
//    // failureDictionary字典中 一个request.description的key 对应着 一个failure的value
//    [self.failureDictionary setObject:failure forKey:request.description];
//    void (^requestBlock) (id json,NSError *error) = ^(id json,NSError *error){
//        if (success && json) {
//            success(json);
//        }
//        if (failure && error) {
//            failure(error);
//        }
//    };
//    self.requestBlockDictionary[request.description] = requestBlock;
}

#pragma mark - DPRequestDelegate

- (void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result{
    // 方式一
    if (result && request.success) {
        request.success(result);
    }
    // 方式二
//    void (^success)(id json) = self.successDictionary[request.description];
//    if (success && result) {
//        success(result);
//    }
    // 方式三
    // 取出block
//    void (^requestBlock) (id json,NSError *error) = self.requestBlockDictionary[request.description];
//    if (requestBlock) {
//        requestBlock(result, nil);
//    }
}

- (void)request:(DPRequest *)request didFailWithError:(NSError *)error{

    //方式一
    if (error && request.failure) {
        request.failure(error);
    }
    // 方式二
//    void (^failure)(NSError *error) = self.failureDictionary[request.description];
//    if (failure && error) {
//        failure(error);
//    }
    // 方式三
    // 取出block
//    void (^requestBlock) (id json,NSError *error) = self.requestBlockDictionary[request.description];
//    if (requestBlock) {
//        requestBlock(nil, error);
//    }
}

@end
