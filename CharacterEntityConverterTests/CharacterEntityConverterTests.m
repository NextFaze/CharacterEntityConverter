//
//  CharacterEntityConverterTests.m
//  CharacterEntityConverterTests
//
//  Created by Andrew Williams on 18/03/11.
//  Copyright 2011 2moro mobile. All rights reserved.
//

#import "CharacterEntityConverterTests.h"
#import "CharacterEntityConverter.h"
#import "NSString+CharacterEntityConverter.h"
#import "NSMutableString+CharacterEntityConverter.h"

@implementation CharacterEntityConverterTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

//+ (NSString *)decodeEntities:(NSString *)string;
//+ (NSString *)decodeEntitiesForXML:(NSString *)string;

- (void)testDecodeEntitiesNamed
{
    NSString *ret;
    
    ret = [CharacterEntityConverter decodeEntities:@"foo &amp; bar"];
    STAssertEqualObjects(ret, @"foo & bar", nil);

    ret = [CharacterEntityConverter decodeEntities:@"foo bar &amp;"];
    STAssertEqualObjects(ret, @"foo bar &", nil);

    ret = [CharacterEntityConverter decodeEntities:@"foo bar &amp; &quot;"];
    STAssertEqualObjects(ret, @"foo bar & \"", nil);
}

- (void)testDecodeEntitiesHex
{
    NSString *ret;
    
    ret = [CharacterEntityConverter decodeEntities:@"foo &#x26; bar"];
    STAssertEqualObjects(ret, @"foo & bar", nil);
    
    ret = [CharacterEntityConverter decodeEntities:@"foo bar &#x26;"];
    STAssertEqualObjects(ret, @"foo bar &", nil);
    
    ret = [CharacterEntityConverter decodeEntities:@"foo bar &#x26; &#x22;"];
    STAssertEqualObjects(ret, @"foo bar & \"", nil);
}

- (void)testDecodeEntitiesNumeric
{
    NSString *ret;
    
    ret = [CharacterEntityConverter decodeEntities:@"foo &amp; bar"];
    STAssertEqualObjects(ret, @"foo & bar", nil);
    
    ret = [CharacterEntityConverter decodeEntities:@"foo bar &#38;"];
    STAssertEqualObjects(ret, @"foo bar &", nil);
    
    ret = [CharacterEntityConverter decodeEntities:@"foo bar &#38; &#34;"];
    STAssertEqualObjects(ret, @"foo bar & \"", nil);
}

- (void)testDecodeEntitiesForXML
{
    NSString *ret;
    
    ret = [CharacterEntityConverter decodeEntitiesForXML:@"foo &#38; bar &trade;"];
    STAssertEqualObjects(ret, @"foo &#38; bar ™", nil);
    
    ret = [CharacterEntityConverter decodeEntitiesForXML:@"foo bar &amp; &trade;"];
    STAssertEqualObjects(ret, @"foo bar &amp; ™", nil);
    
    ret = [CharacterEntityConverter decodeEntitiesForXML:@"foo bar &#38; &#34;"];
    STAssertEqualObjects(ret, @"foo bar &#38; &#34;", nil);
}

- (void)testEncodeEntities
{
    NSString *ret;
    
    ret = [CharacterEntityConverter encodeEntities:@"foo & bar ™"];
    STAssertEqualObjects(ret, @"foo &amp; bar &trade;", nil);
    
    ret = [CharacterEntityConverter encodeEntities:@"foo bar & ™"];
    STAssertEqualObjects(ret, @"foo bar &amp; &trade;", nil);

    ret = [CharacterEntityConverter encodeEntities:@"foo bar ¥"];
    STAssertEqualObjects(ret, @"foo bar &yen;", nil);

    ret = [CharacterEntityConverter encodeEntities:@"foo bar & \""];
    STAssertEqualObjects(ret, @"foo bar &amp; &quot;", nil);
}


- (void)testEncodeEntitiesForXML
{
    NSString *ret;
    
    ret = [CharacterEntityConverter encodeEntitiesForXML:@"foo & bar ™"];
    STAssertEqualObjects(ret, @"foo &amp; bar &#8482;", nil);
    
    ret = [CharacterEntityConverter encodeEntitiesForXML:@"foo bar & ™"];
    STAssertEqualObjects(ret, @"foo bar &amp; &#8482;", nil);
    
    ret = [CharacterEntityConverter encodeEntitiesForXML:@"foo bar ¥"];
    STAssertEqualObjects(ret, @"foo bar &#165;", nil);
    
    ret = [CharacterEntityConverter encodeEntitiesForXML:@"foo bar & \""];
    STAssertEqualObjects(ret, @"foo bar &amp; &quot;", nil);
}

#pragma mark NSString+CharacterEntityConverter tests

- (void)testNSStringCategory {
    NSString *str;
    
    str = [[NSString stringWithString:@"foo &amp; bar &yen;"] stringByDecodingEntities];
    STAssertEqualObjects(str, @"foo & bar ¥", nil);
    
    str = [[NSString stringWithString:@"foo &amp; bar &yen;"] stringByDecodingEntitiesForXML];
    STAssertEqualObjects(str, @"foo &amp; bar ¥", nil);
    
    str = [[NSString stringWithString:@"foo & bar ¥"] stringByEncodingEntities];
    STAssertEqualObjects(str, @"foo &amp; bar &yen;", nil);
    
    str = [[NSString stringWithString:@"foo & bar ¥"] stringByEncodingEntitiesForXML];
    STAssertEqualObjects(str, @"foo &amp; bar &#165;", nil);

}

#pragma mark NSMutableString+CharacterEntityConverter tests

- (void)testNSMutableStringCategory {
    NSMutableString *str;
    
    [str = [NSMutableString stringWithString:@"foo &amp; bar &yen;"] decodeEntities];
    STAssertEqualObjects(str, @"foo & bar ¥", nil);

    [str = [NSMutableString stringWithString:@"foo &amp; bar &yen;"] decodeEntitiesForXML];
    STAssertEqualObjects(str, @"foo &amp; bar ¥", nil);

    [str = [NSMutableString stringWithString:@"foo & bar ¥"] encodeEntities];
    STAssertEqualObjects(str, @"foo &amp; bar &yen;", nil);
    
    [str = [NSMutableString stringWithString:@"foo & bar ¥"] encodeEntitiesForXML];
    STAssertEqualObjects(str, @"foo &amp; bar &#165;", nil);
}

@end
