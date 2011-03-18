//
//  NSMutableString+CharacterEntityConverter.h
//  CharacterEntityConverter
//
//  Created by Andrew Williams on 18/03/11.
//  Copyright 2011 2moro mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString (CharacterEntityConverter)

- (void)encodeEntities;
- (void)encodeEntitiesForXML;
- (void)decodeEntities;
- (void)decodeEntitiesForXML;

@end
