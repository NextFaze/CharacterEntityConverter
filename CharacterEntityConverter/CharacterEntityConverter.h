//
//  HTMLEntityConverter.h
//  WordPressSyncer
//
//  Created by Andrew Williams on 18/03/11.
//  Copyright 2013 NextFaze. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef LOG
#ifdef DEBUG
#define LOG(format, ...) NSLog(@"%s:%@", __PRETTY_FUNCTION__,[NSString stringWithFormat:format, ## __VA_ARGS__])
#else
#define LOG(format, ...)
#endif
#endif

@interface CharacterEntityConverter : NSObject {
    
}

+ (NSString *)decodeEntities:(NSString *)string;
+ (NSString *)decodeEntitiesForXML:(NSString *)string;
+ (NSString *)encodeEntities:(NSString *)string;
+ (NSString *)encodeEntitiesForXML:(NSString *)string;
+ (NSString *)encodeEntities:(NSString *)string fromCodePoint:(unsigned int)fromCodePoint html:(BOOL)html;

@end
