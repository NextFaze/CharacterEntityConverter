//
//  CharacterEntity.m
//
//  Created by Andrew Williams on 18/03/11.
//  Copyright 2013 NextFaze. All rights reserved.
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
