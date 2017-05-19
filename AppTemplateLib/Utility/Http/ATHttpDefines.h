//
//  ATHttpDefines.h
//  AppTemplateLib
//
//  Created by linzhiman on 15/7/31.
//  Copyright (c) 2015年 apptemplate. All rights reserved.
//

#ifndef AppTemplateLib_ATHttpDefines_h
#define AppTemplateLib_ATHttpDefines_h

@class ATHttpGet;
@class ATHttpPost;
@class ATHttpMultipartPost;

typedef void (^ http_get_block_t)(ATHttpGet *httpGet);
typedef void (^ http_post_block_t)(ATHttpPost *httpPost);
typedef void (^ http_multipart_post_block_t)(ATHttpMultipartPost *httpMultipartPost);
typedef void (^ http_result_block_t)(NSHTTPURLResponse *response, NSData *data, NSError *error);

enum {
    ATHttpRequestTimeout = 30
};

enum {
    ATHttpErrorForgetStartHttpRequest = -1,
    ATHttpErrorTaskWasCancelled = -2
};

#endif
