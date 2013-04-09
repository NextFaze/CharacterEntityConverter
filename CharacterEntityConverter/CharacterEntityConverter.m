//
//  CharacterEntityConverter.m
//
//  Created by Andrew Williams on 18/03/11.
//  Copyright 2013 NextFaze. All rights reserved.
//

#import "CharacterEntityConverter.h"
#import "CharacterEntity.h"


// from http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references
// Name	Character	Unicode code point (decimal)	Standard	DTD[1]	Old ISO subset[2]	Description[3]

static NSString *entityData[][7] = {
    { @"quot", @"\"", @"34", @"HTML 2.0", @"HTMLspecial", @"ISOnum", @"quotation mark (= APL quote)" },
    { @"amp", @"&", @"38", @"HTML 2.0", @"HTMLspecial", @"ISOnum", @"ampersand" },
    { @"apos", @"'", @"39", @"XHTML 1.0", @"HTMLspecial", @"ISOnum", @"apostrophe (= apostrophe-quote); see below" },
    { @"lt", @"<", @"60", @"HTML 2.0", @"HTMLspecial", @"ISOnum", @"less-than sign" },
    { @"gt", @">", @"62", @"HTML 2.0", @"HTMLspecial", @"ISOnum", @"greater-than sign" },
    { @"nbsp", @" ", @"160", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"no-break space (= non-breaking space)[4]" },
    { @"iexcl", @"¡", @"161", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"inverted exclamation mark" },
    { @"cent", @"¢", @"162", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"cent sign" },
    { @"pound", @"£", @"163", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"pound sign" },
    { @"curren", @"¤", @"164", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"currency sign" },
    { @"yen", @"¥", @"165", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"yen sign (= yuan sign)" },
    { @"brvbar", @"¦", @"166", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"broken bar (= broken vertical bar)" },
    { @"sect", @"§", @"167", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"section sign" },
    { @"uml", @"¨", @"168", @"HTML 3.2", @"HTMLlat1", @"ISOdia", @"diaeresis (= spacing diaeresis); see German umlaut" },
    { @"copy", @"©", @"169", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"copyright sign" },
    { @"ordf", @"ª", @"170", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"feminine ordinal indicator" },
    { @"laquo", @"«", @"171", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"left-pointing double angle quotation mark (= left pointing guillemet)" },
    { @"not", @"¬", @"172", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"not sign" },
    { @"shy", @" ", @"173", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"soft hyphen (= discretionary hyphen)" },
    { @"reg", @"®", @"174", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"registered sign ( = registered trade mark sign)" },
    { @"macr", @"¯", @"175", @"HTML 3.2", @"HTMLlat1", @"ISOdia", @"macron (= spacing macron = overline = APL overbar)" },
    { @"deg", @"°", @"176", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"degree sign" },
    { @"plusmn", @"±", @"177", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"plus-minus sign (= plus-or-minus sign)" },
    { @"sup2", @"²", @"178", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"superscript two (= superscript digit two = squared)" },
    { @"sup3", @"³", @"179", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"superscript three (= superscript digit three = cubed)" },
    { @"acute", @"´", @"180", @"HTML 3.2", @"HTMLlat1", @"ISOdia", @"acute accent (= spacing acute)" },
    { @"micro", @"µ", @"181", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"micro sign" },
    { @"para", @"¶", @"182", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"pilcrow sign ( = paragraph sign)" },
    { @"middot", @"·", @"183", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"middle dot (= Georgian comma = Greek middle dot)" },
    { @"cedil", @"¸", @"184", @"HTML 3.2", @"HTMLlat1", @"ISOdia", @"cedilla (= spacing cedilla)" },
    { @"sup1", @"¹", @"185", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"superscript one (= superscript digit one)" },
    { @"ordm", @"º", @"186", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"masculine ordinal indicator" },
    { @"raquo", @"»", @"187", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"right-pointing double angle quotation mark (= right pointing guillemet)" },
    { @"frac14", @"¼", @"188", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"vulgar fraction one quarter (= fraction one quarter)" },
    { @"frac12", @"½", @"189", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"vulgar fraction one half (= fraction one half)" },
    { @"frac34", @"¾", @"190", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"vulgar fraction three quarters (= fraction three quarters)" },
    { @"iquest", @"¿", @"191", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"inverted question mark (= turned question mark)" },
    { @"Agrave", @"À", @"192", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter A with grave (= Latin capital letter A grave)" },
    { @"Aacute", @"Á", @"193", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter A with acute" },
    { @"Acirc", @"Â", @"194", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter A with circumflex" },
    { @"Atilde", @"Ã", @"195", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter A with tilde" },
    { @"Auml", @"Ä", @"196", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter A with diaeresis" },
    { @"Aring", @"Å", @"197", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter A with ring above (= Latin capital letter A ring)" },
    { @"AElig", @"Æ", @"198", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter AE (= Latin capital ligature AE)" },
    { @"Ccedil", @"Ç", @"199", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter C with cedilla" },
    { @"Egrave", @"È", @"200", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter E with grave" },
    { @"Eacute", @"É", @"201", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter E with acute" },
    { @"Ecirc", @"Ê", @"202", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter E with circumflex" },
    { @"Euml", @"Ë", @"203", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter E with diaeresis" },
    { @"Igrave", @"Ì", @"204", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter I with grave" },
    { @"Iacute", @"Í", @"205", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter I with acute" },
    { @"Icirc", @"Î", @"206", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter I with circumflex" },
    { @"Iuml", @"Ï", @"207", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter I with diaeresis" },
    { @"ETH", @"Ð", @"208", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter ETH" },
    { @"Ntilde", @"Ñ", @"209", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter N with tilde" },
    { @"Ograve", @"Ò", @"210", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter O with grave" },
    { @"Oacute", @"Ó", @"211", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter O with acute" },
    { @"Ocirc", @"Ô", @"212", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter O with circumflex" },
    { @"Otilde", @"Õ", @"213", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter O with tilde" },
    { @"Ouml", @"Ö", @"214", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter O with diaeresis" },
    { @"times", @"×", @"215", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"multiplication sign" },
    { @"Oslash", @"Ø", @"216", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter O with stroke (= Latin capital letter O slash)" },
    { @"Ugrave", @"Ù", @"217", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter U with grave" },
    { @"Uacute", @"Ú", @"218", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter U with acute" },
    { @"Ucirc", @"Û", @"219", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter U with circumflex" },
    { @"Uuml", @"Ü", @"220", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter U with diaeresis" },
    { @"Yacute", @"Ý", @"221", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter Y with acute" },
    { @"THORN", @"Þ", @"222", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin capital letter THORN" },
    { @"szlig", @"ß", @"223", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter sharp s (= ess-zed); see German Eszett" },
    { @"agrave", @"à", @"224", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter a with grave" },
    { @"aacute", @"á", @"225", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter a with acute" },
    { @"acirc", @"â", @"226", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter a with circumflex" },
    { @"atilde", @"ã", @"227", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter a with tilde" },
    { @"auml", @"ä", @"228", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter a with diaeresis" },
    { @"aring", @"å", @"229", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter a with ring above" },
    { @"aelig", @"æ", @"230", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter ae (= Latin small ligature ae)" },
    { @"ccedil", @"ç", @"231", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter c with cedilla" },
    { @"egrave", @"è", @"232", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter e with grave" },
    { @"eacute", @"é", @"233", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter e with acute" },
    { @"ecirc", @"ê", @"234", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter e with circumflex" },
    { @"euml", @"ë", @"235", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter e with diaeresis" },
    { @"igrave", @"ì", @"236", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter i with grave" },
    { @"iacute", @"í", @"237", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter i with acute" },
    { @"icirc", @"î", @"238", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter i with circumflex" },
    { @"iuml", @"ï", @"239", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter i with diaeresis" },
    { @"eth", @"ð", @"240", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter eth" },
    { @"ntilde", @"ñ", @"241", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter n with tilde" },
    { @"ograve", @"ò", @"242", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter o with grave" },
    { @"oacute", @"ó", @"243", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter o with acute" },
    { @"ocirc", @"ô", @"244", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter o with circumflex" },
    { @"otilde", @"õ", @"245", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter o with tilde" },
    { @"ouml", @"ö", @"246", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter o with diaeresis" },
    { @"divide", @"÷", @"247", @"HTML 3.2", @"HTMLlat1", @"ISOnum", @"division sign" },
    { @"oslash", @"ø", @"248", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter o with stroke (= Latin small letter o slash)" },
    { @"ugrave", @"ù", @"249", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter u with grave" },
    { @"uacute", @"ú", @"250", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter u with acute" },
    { @"ucirc", @"û", @"251", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter u with circumflex" },
    { @"uuml", @"ü", @"252", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter u with diaeresis" },
    { @"yacute", @"ý", @"253", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter y with acute" },
    { @"thorn", @"þ", @"254", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter thorn" },
    { @"yuml", @"ÿ", @"255", @"HTML 2.0", @"HTMLlat1", @"ISOlat1", @"Latin small letter y with diaeresis" },
    { @"OElig", @"Œ", @"338", @"HTML 4.0", @"HTMLspecial", @"ISOlat2", @"Latin capital ligature oe[5]" },
    { @"oelig", @"œ", @"339", @"HTML 4.0", @"HTMLspecial", @"ISOlat2", @"Latin small ligature oe[6]" },
    { @"Scaron", @"Š", @"352", @"HTML 4.0", @"HTMLspecial", @"ISOlat2", @"Latin capital letter s with caron" },
    { @"scaron", @"š", @"353", @"HTML 4.0", @"HTMLspecial", @"ISOlat2", @"Latin small letter s with caron" },
    { @"Yuml", @"Ÿ", @"376", @"HTML 4.0", @"HTMLspecial", @"ISOlat2", @"Latin capital letter y with diaeresis" },
    { @"fnof", @"ƒ", @"402", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"Latin small letter f with hook (= function = florin)" },
    { @"circ", @"ˆ", @"710", @"HTML 4.0", @"HTMLspecial", @"ISOpub", @"modifier letter circumflex accent" },
    { @"tilde", @"˜", @"732", @"HTML 4.0", @"HTMLspecial", @"ISOdia", @"small tilde" },
    { @"Alpha", @"Α", @"913", @"HTML 4.0", @"HTMLsymbol", @"", @"Greek capital letter Alpha" },
    { @"Beta", @"Β", @"914", @"HTML 4.0", @"HTMLsymbol", @"", @"Greek capital letter Beta" },
    { @"Gamma", @"Γ", @"915", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek capital letter Gamma" },
    { @"Delta", @"Δ", @"916", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek capital letter Delta" },
    { @"Epsilon", @"Ε", @"917", @"HTML 4.0", @"HTMLsymbol", @"", @"Greek capital letter Epsilon" },
    { @"Zeta", @"Ζ", @"918", @"HTML 4.0", @"HTMLsymbol", @"", @"Greek capital letter Zeta" },
    { @"Eta", @"Η", @"919", @"HTML 4.0", @"HTMLsymbol", @"", @"Greek capital letter Eta" },
    { @"Theta", @"Θ", @"920", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek capital letter Theta" },
    { @"Iota", @"Ι", @"921", @"HTML 4.0", @"HTMLsymbol", @"", @"Greek capital letter Iota" },
    { @"Kappa", @"Κ", @"922", @"HTML 4.0", @"HTMLsymbol", @"", @"Greek capital letter Kappa" },
    { @"Lambda", @"Λ", @"923", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek capital letter Lambda" },
    { @"Mu", @"Μ", @"924", @"HTML 4.0", @"HTMLsymbol", @"", @"Greek capital letter Mu" },
    { @"Nu", @"Ν", @"925", @"HTML 4.0", @"HTMLsymbol", @"", @"Greek capital letter Nu" },
    { @"Xi", @"Ξ", @"926", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek capital letter Xi" },
    { @"Omicron", @"Ο", @"927", @"HTML 4.0", @"HTMLsymbol", @"", @"Greek capital letter Omicron" },
    { @"Pi", @"Π", @"928", @"HTML 4.0", @"HTMLsymbol", @"", @"Greek capital letter Pi" },
    { @"Rho", @"Ρ", @"929", @"HTML 4.0", @"HTMLsymbol", @"", @"Greek capital letter Rho" },
    { @"Sigma", @"Σ", @"931", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek capital letter Sigma" },
    { @"Tau", @"Τ", @"932", @"HTML 4.0", @"HTMLsymbol", @"", @"Greek capital letter Tau" },
    { @"Upsilon", @"Υ", @"933", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek capital letter Upsilon" },
    { @"Phi", @"Φ", @"934", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek capital letter Phi" },
    { @"Chi", @"Χ", @"935", @"HTML 4.0", @"HTMLsymbol", @"", @"Greek capital letter Chi" },
    { @"Psi", @"Ψ", @"936", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek capital letter Psi" },
    { @"Omega", @"Ω", @"937", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek capital letter Omega" },
    { @"alpha", @"α", @"945", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter alpha" },
    { @"beta", @"β", @"946", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter beta" },
    { @"gamma", @"γ", @"947", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter gamma" },
    { @"delta", @"δ", @"948", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter delta" },
    { @"epsilon", @"ε", @"949", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter epsilon" },
    { @"zeta", @"ζ", @"950", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter zeta" },
    { @"eta", @"η", @"951", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter eta" },
    { @"theta", @"θ", @"952", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter theta" },
    { @"iota", @"ι", @"953", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter iota" },
    { @"kappa", @"κ", @"954", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter kappa" },
    { @"lambda", @"λ", @"955", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter lambda" },
    { @"mu", @"μ", @"956", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter mu" },
    { @"nu", @"ν", @"957", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter nu" },
    { @"xi", @"ξ", @"958", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter xi" },
    { @"omicron", @"ο", @"959", @"HTML 4.0", @"HTMLsymbol", @"NEW", @"Greek small letter omicron" },
    { @"pi", @"π", @"960", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter pi" },
    { @"rho", @"ρ", @"961", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter rho" },
    { @"sigmaf", @"ς", @"962", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter final sigma" },
    { @"sigma", @"σ", @"963", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter sigma" },
    { @"tau", @"τ", @"964", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter tau" },
    { @"upsilon", @"υ", @"965", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter upsilon" },
    { @"phi", @"φ", @"966", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter phi" },
    { @"chi", @"χ", @"967", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter chi" },
    { @"psi", @"ψ", @"968", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter psi" },
    { @"omega", @"ω", @"969", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek small letter omega" },
    { @"thetasym", @"ϑ", @"977", @"HTML 4.0", @"HTMLsymbol", @"NEW", @"Greek theta symbol" },
    { @"upsih", @"ϒ", @"978", @"HTML 4.0", @"HTMLsymbol", @"NEW", @"Greek Upsilon with hook symbol" },
    { @"piv", @"ϖ", @"982", @"HTML 4.0", @"HTMLsymbol", @"ISOgrk3", @"Greek pi symbol" },
    { @"ensp", @" ", @"8194", @"HTML 4.0", @"HTMLspecial", @"ISOpub", @"en space[7]" },
    { @"emsp", @" ", @"8195", @"HTML 4.0", @"HTMLspecial", @"ISOpub", @"em space[8]" },
    { @"thinsp", @" ", @"8201", @"HTML 4.0", @"HTMLspecial", @"ISOpub", @"thin space[9]" },
    { @"zwnj", @" ", @"8204", @"HTML 4.0", @"HTMLspecial", @"NEW RFC 2070", @"zero-width non-joiner" },
    { @"zwj", @" ", @"8205", @"HTML 4.0", @"HTMLspecial", @"NEW RFC 2070", @"zero-width joiner" },
    { @"lrm", @" ", @"8206", @"HTML 4.0", @"HTMLspecial", @"NEW RFC 2070", @"left-to-right mark" },
    { @"rlm", @" ", @"8207", @"HTML 4.0", @"HTMLspecial", @"NEW RFC 2070", @"right-to-left mark" },
    { @"ndash", @"–", @"8211", @"HTML 4.0", @"HTMLspecial", @"ISOpub", @"en dash" },
    { @"mdash", @"—", @"8212", @"HTML 4.0", @"HTMLspecial", @"ISOpub", @"em dash" },
    { @"lsquo", @"‘", @"8216", @"HTML 4.0", @"HTMLspecial", @"ISOnum", @"left single quotation mark" },
    { @"rsquo", @"’", @"8217", @"HTML 4.0", @"HTMLspecial", @"ISOnum", @"right single quotation mark" },
    { @"sbquo", @"‚", @"8218", @"HTML 4.0", @"HTMLspecial", @"NEW", @"single low-9 quotation mark" },
    { @"ldquo", @"“", @"8220", @"HTML 4.0", @"HTMLspecial", @"ISOnum", @"left double quotation mark" },
    { @"rdquo", @"”", @"8221", @"HTML 4.0", @"HTMLspecial", @"ISOnum", @"right double quotation mark" },
    { @"bdquo", @"„", @"8222", @"HTML 4.0", @"HTMLspecial", @"NEW", @"double low-9 quotation mark" },
    { @"dagger", @"†", @"8224", @"HTML 4.0", @"HTMLspecial", @"ISOpub", @"dagger, obelisk" },
    { @"Dagger", @"‡", @"8225", @"HTML 4.0", @"HTMLspecial", @"ISOpub", @"double dagger, double obelisk" },
    { @"bull", @"•", @"8226", @"HTML 4.0", @"HTMLspecial", @"ISOpub", @"bullet (= black small circle)[10]" },
    { @"hellip", @"…", @"8230", @"HTML 4.0", @"HTMLsymbol", @"ISOpub", @"horizontal ellipsis (= three dot leader)" },
    { @"permil", @"‰", @"8240", @"HTML 4.0", @"HTMLspecial", @"ISOtech", @"per mille sign" },
    { @"prime", @"′", @"8242", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"prime (= minutes = feet)" },
    { @"Prime", @"″", @"8243", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"double prime (= seconds = inches)" },
    { @"lsaquo", @"‹", @"8249", @"HTML 4.0", @"HTMLspecial", @"ISO proposed", @"single left-pointing angle quotation mark[11]" },
    { @"rsaquo", @"›", @"8250", @"HTML 4.0", @"HTMLspecial", @"ISO proposed", @"single right-pointing angle quotation mark[12]" },
    { @"oline", @"‾", @"8254", @"HTML 4.0", @"HTMLsymbol", @"NEW", @"overline (= spacing overscore)" },
    { @"frasl", @"⁄", @"8260", @"HTML 4.0", @"HTMLsymbol", @"NEW", @"fraction slash (= solidus)" },
    { @"euro", @"€", @"8364", @"HTML 4.0", @"HTMLspecial", @"NEW", @"euro sign" },
    { @"image", @"ℑ", @"8465", @"HTML 4.0", @"HTMLsymbol", @"ISOamso", @"black-letter capital I (= imaginary part)" },
    { @"weierp", @"℘", @"8472", @"HTML 4.0", @"HTMLsymbol", @"ISOamso", @"script capital P (= power set = Weierstrass p)" },
    { @"real", @"ℜ", @"8476", @"HTML 4.0", @"HTMLsymbol", @"ISOamso", @"black-letter capital R (= real part symbol)" },
    { @"trade", @"™", @"8482", @"HTML 4.0", @"HTMLsymbol", @"ISOnum", @"trademark sign" },
    { @"alefsym", @"ℵ", @"8501", @"HTML 4.0", @"HTMLsymbol", @"NEW", @"alef symbol (= first transfinite cardinal)[13]" },
    { @"larr", @"←", @"8592", @"HTML 4.0", @"HTMLsymbol", @"ISOnum", @"leftwards arrow" },
    { @"uarr", @"↑", @"8593", @"HTML 4.0", @"HTMLsymbol", @"ISOnum", @"upwards arrow" },
    { @"rarr", @"→", @"8594", @"HTML 4.0", @"HTMLsymbol", @"ISOnum", @"rightwards arrow" },
    { @"darr", @"↓", @"8595", @"HTML 4.0", @"HTMLsymbol", @"ISOnum", @"downwards arrow" },
    { @"harr", @"↔", @"8596", @"HTML 4.0", @"HTMLsymbol", @"ISOamsa", @"left right arrow" },
    { @"crarr", @"↵", @"8629", @"HTML 4.0", @"HTMLsymbol", @"NEW", @"downwards arrow with corner leftwards (= carriage return)" },
    { @"lArr", @"⇐", @"8656", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"leftwards double arrow[14]" },
    { @"uArr", @"⇑", @"8657", @"HTML 4.0", @"HTMLsymbol", @"ISOamsa", @"upwards double arrow" },
    { @"rArr", @"⇒", @"8658", @"HTML 4.0", @"HTMLsymbol", @"ISOnum", @"rightwards double arrow[15]" },
    { @"dArr", @"⇓", @"8659", @"HTML 4.0", @"HTMLsymbol", @"ISOamsa", @"downwards double arrow" },
    { @"hArr", @"⇔", @"8660", @"HTML 4.0", @"HTMLsymbol", @"ISOamsa", @"left right double arrow" },
    { @"forall", @"∀", @"8704", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"for all" },
    { @"part", @"∂", @"8706", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"partial differential" },
    { @"exist", @"∃", @"8707", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"there exists" },
    { @"empty", @"∅", @"8709", @"HTML 4.0", @"HTMLsymbol", @"ISOamso", @"empty set (= null set = diameter)" },
    { @"nabla", @"∇", @"8711", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"nabla (= backward difference)" },
    { @"isin", @"∈", @"8712", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"element of" },
    { @"notin", @"∉", @"8713", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"not an element of" },
    { @"ni", @"∋", @"8715", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"contains as member" },
    { @"prod", @"∏", @"8719", @"HTML 4.0", @"HTMLsymbol", @"ISOamsb", @"n-ary product (= product sign)[16]" },
    { @"sum", @"∑", @"8721", @"HTML 4.0", @"HTMLsymbol", @"ISOasmb", @"n-ary summation[17]" },
    { @"minus", @"−", @"8722", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"minus sign" },
    { @"lowast", @"∗", @"8727", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"asterisk operator" },
    { @"radic", @"√", @"8730", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"square root (= radical sign)" },
    { @"prop", @"∝", @"8733", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"proportional to" },
    { @"infin", @"∞", @"8734", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"infinity" },
    { @"ang", @"∠", @"8736", @"HTML 4.0", @"HTMLsymbol", @"ISOamso", @"angle" },
    { @"and", @"∧", @"8743", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"logical and (= wedge)" },
    { @"or", @"∨", @"8744", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"logical or (= vee)" },
    { @"cap", @"∩", @"8745", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"intersection (= cap)" },
    { @"cup", @"∪", @"8746", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"union (= cup)" },
    { @"int", @"∫", @"8747", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"integral" },
    { @"there4", @"∴", @"8756", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"therefore" },
    { @"sim", @"∼", @"8764", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"tilde operator (= varies with = similar to)[18]" },
    { @"cong", @"≅", @"8773", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"congruent to" },
    { @"asymp", @"≈", @"8776", @"HTML 4.0", @"HTMLsymbol", @"ISOamsr", @"almost equal to (= asymptotic to)" },
    { @"ne", @"≠", @"8800", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"not equal to" },
    { @"equiv", @"≡", @"8801", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"identical to; sometimes used for 'equivalent to'" },
    { @"le", @"≤", @"8804", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"less-than or equal to" },
    { @"ge", @"≥", @"8805", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"greater-than or equal to" },
    { @"sub", @"⊂", @"8834", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"subset of" },
    { @"sup", @"⊃", @"8835", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"superset of[19]" },
    { @"nsub", @"⊄", @"8836", @"HTML 4.0", @"HTMLsymbol", @"ISOamsn", @"not a subset of" },
    { @"sube", @"⊆", @"8838", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"subset of or equal to" },
    { @"supe", @"⊇", @"8839", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"superset of or equal to" },
    { @"oplus", @"⊕", @"8853", @"HTML 4.0", @"HTMLsymbol", @"ISOamsb", @"circled plus (= direct sum)" },
    { @"otimes", @"⊗", @"8855", @"HTML 4.0", @"HTMLsymbol", @"ISOamsb", @"circled times (= vector product)" },
    { @"perp", @"⊥", @"8869", @"HTML 4.0", @"HTMLsymbol", @"ISOtech", @"up tack (= orthogonal to = perpendicular)[20]" },
    { @"sdot", @"⋅", @"8901", @"HTML 4.0", @"HTMLsymbol", @"ISOamsb", @"dot operator[21]" },
    { @"lceil", @"⌈", @"8968", @"HTML 4.0", @"HTMLsymbol", @"ISOamsc", @"left ceiling (= APL upstile)" },
    { @"rceil", @"⌉", @"8969", @"HTML 4.0", @"HTMLsymbol", @"ISOamsc", @"right ceiling" },
    { @"lfloor", @"⌊", @"8970", @"HTML 4.0", @"HTMLsymbol", @"ISOamsc", @"left floor (= APL downstile)" },
    { @"rfloor", @"⌋", @"8971", @"HTML 4.0", @"HTMLsymbol", @"ISOamsc", @"right floor" },
    { @"lang", @"〈", @"10216", @"HTML 5.0", @"HTMLsymbol", @"ISOtech", @"mathematical left angle bracket (= bra)[22]" },
    { @"rang", @"〉", @"10217", @"HTML 5.0", @"HTMLsymbol", @"ISOtech", @"mathematical right angle bracket (= ket)[23]" },
    { @"loz", @"◊", @"9674", @"HTML 4.0", @"HTMLsymbol", @"ISOpub", @"lozenge" },
    { @"spades", @"♠", @"9824", @"HTML 4.0", @"HTMLsymbol", @"ISOpub", @"black spade suit[24]" },
    { @"clubs", @"♣", @"9827", @"HTML 4.0", @"HTMLsymbol", @"ISOpub", @"black club suit (= shamrock)[25]" },
    { @"hearts", @"♥", @"9829", @"HTML 4.0", @"HTMLsymbol", @"ISOpub", @"black heart suit (= valentine)[26]" },
    { @"diams", @"♦", @"9830", @"HTML 4.0", @"HTMLsymbol", @"ISOpub", @"black diamond suit" },
    { nil }
  };

static NSDictionary *entityByName = nil;
static NSDictionary *entityByCode = nil;

@implementation CharacterEntityConverter

+ (void)initialize {
    NSMutableDictionary *byName = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *byCode = [[NSMutableDictionary alloc] init];
    
    for(int i = 0; entityData[i][0]; i++) {
        NSString **entDat = entityData[i];   
        
        CharacterEntity *ent = [[CharacterEntity alloc] init];
        ent.name = entDat[0];
        ent.character = entDat[1];
        ent.codePoint = [entDat[2] intValue];
        ent.standard = entDat[3];
        ent.dtd = entDat[4];
        ent.oldISO = entDat[5];
        ent.desc = entDat[6];

        [byName setValue:ent forKey:[ent.name lowercaseString]];
        [byCode setValue:ent forKey:[NSString stringWithFormat:@"%d", ent.codePoint]];
        
        [ent release];
    }
    
    entityByName = byName;
    entityByCode = byCode;
    
    //LOG(@"entityByName: %@", entityByName);
}

+ (int)hexToInt:(NSString *)hex {
    int value = 0;
    const char *hexStr = [[hex lowercaseString] UTF8String];
    int len = strlen(hexStr);

    for(int i = 0; i < len; i++) {
        char ch = hexStr[len - i - 1];
        int val = ch >= 'a' ? ch - 'a' : ch - '0';
        value += val << (4 * i);
    }
    //LOG(@"%@ = %d", hex, value);
    return value;
}

// convert all character entities to characters
+ (NSString *)decodeEntities:(NSString *)string {
    NSMutableString *str = [NSMutableString stringWithString:string];
    
    // &#nnnn; (decimal), &#xhhhh; (hex), &name; (entity name)
    for(;;) {
        NSRange rangeEntity;
        CharacterEntity *ent = nil;
        
        if((rangeEntity = [str rangeOfString:@"&[a-z]+;" options:NSCaseInsensitiveSearch|NSRegularExpressionSearch]).location != NSNotFound) {
            // found entity name
            NSRange rangeEntityValue = rangeEntity;
            rangeEntityValue.location += 1;
            rangeEntityValue.length -= 2;
            NSString *entity = [str substringWithRange:rangeEntityValue];
            ent = [entityByName valueForKey:[entity lowercaseString]];
        }
        else if((rangeEntity = [str rangeOfString:@"&#[0-9]+;" options:NSCaseInsensitiveSearch|NSRegularExpressionSearch]).location != NSNotFound) {
            // found decimal entity
            NSRange rangeEntityValue = rangeEntity;
            rangeEntityValue.location += 2;
            rangeEntityValue.length -= 3;
            NSString *entity = [str substringWithRange:rangeEntityValue];
            int code = [entity intValue];
            ent = [entityByCode valueForKey:[NSString stringWithFormat:@"%d", code]];
        }
        else if((rangeEntity = [str rangeOfString:@"&#x[a-z0-9]+;" options:NSCaseInsensitiveSearch|NSRegularExpressionSearch]).location != NSNotFound) {
            // found hex entity
            NSRange rangeEntityValue = rangeEntity;
            rangeEntityValue.location += 3;
            rangeEntityValue.length -= 4;
            NSString *entity = [str substringWithRange:rangeEntityValue];
            int code = [self hexToInt:entity];
            ent = [entityByCode valueForKey:[NSString stringWithFormat:@"%d", code]];
        }
        
        if(rangeEntity.location == NSNotFound) break; // no entities found
        
        // replace unknown entities with ""
        NSString *replacement = ent ? ent.character : @"";
        LOG(@"%@ -> %@", [str substringWithRange:rangeEntity], replacement);
        [str replaceCharactersInRange:rangeEntity withString:replacement];
    }
    
    return str;
}

// decode entities that aren't valid in XML
+ (NSString *)decodeEntitiesForXML:(NSString *)string {
    NSArray *xmlEntities = [NSArray arrayWithObjects:@"quot", @"amp", @"apos", @"lt", @"gt", nil];  // acceptable xml entities
    NSRange rangeSearch = NSMakeRange(0, [string length]);
    NSMutableString *str = [NSMutableString stringWithString:string];
    
    for(;;) {
        NSRange rangeEntity;
        CharacterEntity *ent = nil;
        
        //LOG(@"search range: (%d, %d)", rangeSearch.location, rangeSearch.length);

        if((rangeEntity = [str rangeOfString:@"&[a-z]+;" options:NSCaseInsensitiveSearch|NSRegularExpressionSearch range:rangeSearch]).location != NSNotFound) {
            // found entity name
            NSRange rangeEntityValue = rangeEntity;
            rangeEntityValue.location += 1;
            rangeEntityValue.length -= 2;
            NSString *entity = [str substringWithRange:rangeEntityValue];
            ent = [entityByName valueForKey:[entity lowercaseString]];
        }
        if(rangeEntity.location == NSNotFound) break; // no entities found
        
        rangeSearch.location = rangeEntity.location + rangeEntity.length;
        rangeSearch.length = [str length] - rangeSearch.location;
        
        if([xmlEntities containsObject:ent.name]) continue;  // this named entity is ok in xml
        
        // replace unknown entities with ""
        NSString *replacement = ent ? ent.character : @"";
        LOG(@"%@ -> %@", [str substringWithRange:rangeEntity], replacement);
        [str replaceCharactersInRange:rangeEntity withString:replacement];

        int lengthdiff = [replacement length] - rangeEntity.length;
        if(lengthdiff + (int)rangeSearch.length <= 0) break; // string finished
        
        rangeSearch.length += lengthdiff;
    }
    
    return str;
}

+ (NSString *)encodeEntities:(NSString *)string {
    return [self encodeEntities:string fromCodePoint:128 html:YES];
}

+ (NSString *)encodeEntitiesForXML:(NSString *)string {
    return [self encodeEntities:string fromCodePoint:128 html:NO];
}

+ (NSString *)encodeEntities:(NSString *)string fromCodePoint:(unsigned int)fromCodePoint html:(BOOL)html {
    NSMutableString *str = [NSMutableString stringWithString:string];

    // encode ampersands first
    // (ignore ampersands that begin already-encoded entities)
    for(;;) {
        NSRange rangeAmp = [str rangeOfString:@"&(?!(#x?)?[\\d\\w]+;)" options:NSLiteralSearch|NSCaseInsensitiveSearch|NSRegularExpressionSearch];
        if(rangeAmp.location == NSNotFound) break;
        //LOG(@"found unescaped ampersand at index %d", rangeAmp.location);
        [str replaceCharactersInRange:rangeAmp withString:@"&amp;"];
    }
    
    const unsigned char *cstr = (const unsigned char *)[str cStringUsingEncoding:NSUTF16BigEndianStringEncoding];
    NSMutableString *new = [NSMutableString string];
    
    // encode other characters
    NSRange rangeAppend;
    int i = 0;
    rangeAppend.location = 0;
    
    for(i = 0; i < [str length]; i++, cstr += 2) {
        unsigned int codePoint = ((*cstr) << 8) + *(cstr + 1);
        //LOG(@"char: %d, code point: %ld", i, codePoint);

        if(codePoint >= fromCodePoint ||
           codePoint == 34 || codePoint == 39 || codePoint == 60 || codePoint == 62) {
            // convert to entity
            
            // append uncoverted characters since last conversion
            rangeAppend.length = i - rangeAppend.location;
            NSString *append = [str substringWithRange:rangeAppend];
            [new appendString:append];
            rangeAppend.location = i + 1;
            
            NSString *entity = nil;
            if(html || codePoint < 128) {
                // find entity name by code point
                CharacterEntity *ent = [entityByCode valueForKey:[NSString stringWithFormat:@"%d", codePoint]];
                if(ent)
                    entity = [NSString stringWithFormat:@"&%@;", ent.name];
            }
            if(entity == nil)
                entity = [NSString stringWithFormat:@"&#%d;", codePoint];
            
            [new appendString:entity];
        }
    }
    
    // append uncoverted characters since last conversion
    rangeAppend.length = i - rangeAppend.location;
    NSString *append = [str substringWithRange:rangeAppend];
    [new appendString:append];
    
    return new;
}


@end
