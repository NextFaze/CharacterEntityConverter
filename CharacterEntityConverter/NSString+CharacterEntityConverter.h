//
//  NSString+CharacterEntityConverter.h
//  CharacterEntityConverter
//
//  Created by Andrew Williams on 18/03/11.
//  Copyright 2013 NextFaze. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (CharacterEntityConverter)

- (NSString *)stringByEncodingEntities;
- (NSString *)stringByEncodingEntitiesForXML;
- (NSString *)stringByDecodingEntities;
- (NSString *)stringByDecodingEntitiesForXML;

@end
