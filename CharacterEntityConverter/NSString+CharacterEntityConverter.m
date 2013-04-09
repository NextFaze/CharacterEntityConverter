//
//  NSString+CharacterEntityConverter.m
//  CharacterEntityConverter
//
//  Created by Andrew Williams on 18/03/11.
//  Copyright 2013 NextFaze. All rights reserved.
//

#import "NSString+CharacterEntityConverter.h"
#import "CharacterEntityConverter.h"

@implementation NSString (CharacterEntityConverter)

- (NSString *)stringByEncodingEntities {
    return [CharacterEntityConverter encodeEntities:self];
}
- (NSString *)stringByEncodingEntitiesForXML {
    return [CharacterEntityConverter encodeEntitiesForXML:self];
}
- (NSString *)stringByDecodingEntities {
    return [CharacterEntityConverter decodeEntities:self];
}
- (NSString *)stringByDecodingEntitiesForXML {
    return [CharacterEntityConverter decodeEntitiesForXML:self];
}

@end
