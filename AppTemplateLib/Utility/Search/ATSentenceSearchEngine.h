//
//  ATSentenceSearchEngine.h
//  yyhd
//
//  Created by Gideon-Mac on 13-11-19.
//
//

#import <Foundation/Foundation.h>

@interface ATSentenceSearchEngine : NSObject

- (void)addSentence:(NSString*)sentence flag:(unsigned)sentenceFlags token:(const int)token;
- (void)removeAllSentences;
- (NSArray*)search:(NSString*)t9key falg:(unsigned)searchingFlags;

@end
