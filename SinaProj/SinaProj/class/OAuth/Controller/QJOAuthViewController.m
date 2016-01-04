//
//  QJOAuthViewController.m
//  SinaProj
//
//  Created by 杨丽娟 on 15/12/28.
//  Copyright © 2015年 Qin.Yu. All rights reserved.
//

#import "QJOAuthViewController.h"
#import "QJAccount.h"
#import "QJPublicTool.h"
#import "QJHttpTool.h"
#import "MBProgressHUD+MJ.h"

@interface QJOAuthViewController ()<UIWebViewDelegate>

@end

@implementation QJOAuthViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWebView *webView = [[UIWebView alloc]init];
    
    webView.frame = self.view.bounds;
    
    webView.delegate = self;
    
    [self.view addSubview:webView];
    
    
    NSURL *url = [NSURL URLWithString:QJAPPLoginUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [webView loadRequest:request];
}

#pragma mark -- webview delegate
/**
 *  webview请求之前都会调用这个方法，询问是否允许加载
 *
 *  @param webView        <#webView description#>
 *  @param request        <#request description#>
 *  @param navigationType <#navigationType description#>
 *
 *  @return YES：可以
 */
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"code="];
        
    if (range.length) {
        int loc = (int)(range.location + range.length);
        NSString *codeStr = [urlStr substringFromIndex:loc];
        [self accessTokenWithCode:codeStr];
        
        //不加载回调网址请求
        return NO;
    }

    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

/**
 *  send a POST,code to acccess token
 client_id		string	申请应用时分配的AppKey。
 client_secret		string	申请应用时分配的AppSecret。
 grant_type		string	请求的类型，填写authorization_code
 
 grant_type为authorization_code时
 
 code		string	调用authorize获得的code值。
 redirect_uri		string
 */
- (void)accessTokenWithCode:(NSString *)code
{
    //说明返回的事json
    //Mgr.responseSerializer = [AFJSONRequestSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = QJAPPKey;
    params[@"client_secret"] = @"39603eb68a84badef4ff319a480840b2";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = [code copy];
    params[@"redirect_uri"] = QJAPPRedirect_Url;
    
    [QJHttpTool postWithURL:QJAPP_POST_ForAccessToken params:params success:^(id response) {
        QJAccount *account = [QJAccount accountWithDict:response];
        ArchiveAccount(account);
        [QJPublicTool chooseRootViewController];
        [MBProgressHUD hideHUD];

    } failure:^(NSError *error) {
        ALog(@"failure:%@", error);
        [MBProgressHUD hideHUD];
    }];
}
@end
