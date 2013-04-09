//
//  NSMutableString+CharacterEntityConverter.m
//  CharacterEntityConverter
//
//  Created by Andrew Williams on 18/03/11.
//  Copyright 2013 NextFaze. All rights reserved.
//

#import "NSMutableString+CharacterEntityConverter.h"
#import "CharacterEntityConverter.h"

@implementation NSMutableString (CharacterEntityConverter)

- (void)encodeEntities {
    [self setString:[CharacterEntityConverter encodeEntities:self]];
}
- (void)encodeEntitiesForXML {
    [self setString:[CharacterEntityConverter encodeEntitiesForXML:self]];
}
- (void)decodeEntities {
    [self setString:[CharacterEntityConverter decodeEntities:self]];
}
- (void)decodeEntitiesForXML {
    [self setString:[CharacterEntityConverter decodeEntitiesForXML:self]];
}

@end
