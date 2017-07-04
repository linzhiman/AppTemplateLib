//
//  ATSentenceSearchEngine.m
//  yyhd
//
//  Created by Gideon-Mac on 13-11-19.
//
//

#import "ATSentenceSearchEngine.h"
#import "T9SearchEngine.h"

@implementation ATSentenceSearchEngine
{
    CT9SearchEngine *_t9Engine;
}

- (id)init
{
    self = [super init];
    if (self){
        _t9Engine = new CT9SearchEngine;
    }
    return self;
}

- (void)addSentence:(NSString*)sentence flag:(unsigned)sentenceFlags token:(const int)token
{
    if (!_t9Engine || !sentence){
        return;
    }
    LPCWSTR text = (LPCWSTR)[sentence cStringUsingEncoding:NSUnicodeStringEncoding];
    _t9Engine->addSentence(text, sentenceFlags, token);
}

- (void)removeAllSentences
{
    if (!_t9Engine) {
        return;
    }
    _t9Engine->removeAllSentences();
}

- (NSArray*)search:(NSString*)t9key falg:(unsigned)searchingFlags
{
    if (!_t9Engine) {
        return nil;
    }
    std::deque<int> result;
    LPCWSTR text = (LPCWSTR)[t9key cStringUsingEncoding:NSUnicodeStringEncoding];
    _t9Engine->search(text, searchingFlags, &result);
    
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:(result.size())];
    for (std::deque<int>::iterator it = result.begin(); it != result.end(); ++it) {
        [array addObject:[NSNumber numberWithInt:*it]];
    }
    return array;
}

- (void)dealloc {
    [self removeAllSentences];
    if (_t9Engine) {
        delete _t9Engine;
        _t9Engine = NULL;
    }
}

@end
