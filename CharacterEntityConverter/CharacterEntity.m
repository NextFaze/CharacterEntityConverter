//
//  CharacterEntity.m
//
//  Created by Andrew Williams on 18/03/11.
//  Copyright 2011 2moro mobile. All rights reserved.
//

#import "CharacterEntity.h"


@implementation CharacterEntity

@synthesize name, character, codePoint, standard, dtd, oldISO, desc;

- (void)dealloc {
    [name release];
    [character release];
    [standard release];
    [dtd release];
    [oldISO release];
    [desc release];
    
    [super dealloc];
}

@end
