//
//  CharacterEntity.h
//
//  Created by Andrew Williams on 18/03/11.
//  Copyright 2011 2moro mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CharacterEntity : NSObject {
    NSString *name, *character, *standard, *dtd, *oldISO, *desc;
    int codePoint;
}

@property (nonatomic, retain) NSString *name, *character, *standard, *dtd, *oldISO, *desc;
@property (nonatomic, assign) int codePoint;

@end
