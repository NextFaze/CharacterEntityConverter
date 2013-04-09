
# CharacterEntityConverter

CharacterEntityConverter - Objective C library for character entity conversions

## Installation

    > git clone git://github.com/NextfazeSD/CharacterEntityConverter.git

## Interfaces

CharacterEntityConverter:

    + (NSString *)decodeEntities:(NSString *)string;
    + (NSString *)decodeEntitiesForXML:(NSString *)string;
    + (NSString *)encodeEntities:(NSString *)string;
    + (NSString *)encodeEntitiesForXML:(NSString *)string;
    + (NSString *)encodeEntities:(NSString *)string fromCodePoint:(unsigned int)fromCodePoint html:(BOOL)html;

NSString+CharacterEntityConverter:  (NSString category)

    - (NSString *)stringByEncodingEntities;
    - (NSString *)stringByEncodingEntitiesForXML;
    - (NSString *)stringByDecodingEntities;
    - (NSString *)stringByDecodingEntitiesForXML;

NSMutableString+CharacterEntityConverter:  (NSMutableString category)

    - (void)encodeEntities;
    - (void)encodeEntitiesForXML;
    - (void)decodeEntities;
    - (void)decodeEntitiesForXML;

## Synopsis

decoding character entities

    #import "NSString+CharacterEntityConverter.h"

    [@"foo &amp; bar" stringByDecodingEntities];            // -> "foo & bar"
    [@"foo &amp; &trade;" stringByDecodingEntitiesForXML];  // -> "foo &amp; bar ™"  (&trade; is not valid in XML)

encoding character entities

    #import "NSString+CharacterEntityConverter.h"

    [@"foo & bar" stringByEncodingEntities];          // -> "foo &amp; bar"
    [@"foo & bar ™" stringByEncodingEntitiesForXML];   // -> "foo &amp; bar &#8482;" (&trade; is not valid in XML)
    
## License

WordPressSyncer is licensed under the terms of the [Apache License, version 2.0](http://www.apache.org/licenses/LICENSE-2.0.html). Please see the [LICENSE](https://github.com/NextfazeSD/CharacterEntityConverter/blob/master/LICENSE) file for full details.

## Credits

WordPressSyncer is brought to you by [Andrew Williams](http://github.com/sobakasu) and supported by the [NextFaze](http://www.nextfaze.com) team and the GitHub community.

