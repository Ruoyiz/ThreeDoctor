//
//  HttpFile.h
//  loginDemo
//
//  Created by 若义张 on 16/1/26.
//  Copyright © 2016年 若义张. All rights reserved.
//

#ifndef HttpFile_h
#define HttpFile_h

// weibo
#define FSinaWeiboAppKey  @"1099830903"
#define FSinaWeiboRedirectURI  @"http://www.addinghome.com/pa"

// wechat
#define FWeChatAppKey  @"wxfc96be57479a708d"
#define FWeChatAppSecret  @"7f74cd9a074293fcc5687d64ccc0c6aa"


//#define baseUrl @"http://192.168.1.136/frontend/web/index.php?r=" //基URL
#define baseUrl @"http://123.57.190.178/frontend/web/index.php?r="
//登陆
#define Http_Login @"chc/user/login"
#define Http_SendSMS @"chc/sms/send"
#define Http_Logout @"chc/user/logout"
#define Http_UserUpdate @"chc/user/update"
#define Http_ChangeDevice @"chc/user/imei"
#define Http_ChangePassWord @"chc/user/password"
#endif /* HttpFile_h */
