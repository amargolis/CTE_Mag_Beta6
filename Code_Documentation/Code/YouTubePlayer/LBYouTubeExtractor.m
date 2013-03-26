
#import "LBYouTubeExtractor.h"
#import "JSONKit.h"

#define USE_NATIVE_JSON_PARSER  1
#define USE_NATIVE_UNESCAPE     1

static NSString const * kPhoneUserAgent = @"Mozilla/5.0 (iPhone; CPU iPhone OS 5_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B176 Safari/7534.48.3";
static NSString const * kPadUserAgent = @"Mozilla/5.0 (iPad; CPU OS 5_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B176 Safari/7534.48.3";
NSString const * LBYouTubeExtractorErrorDomain = @"LBYouTubeExtractorErrorDomain";

NSInteger const LBYouTubeExtractorErrorCodeInvalidHTML  =    1;
NSInteger const LBYouTubeExtractorErrorCodeNoStreamURL  =    2;
NSInteger const LBYouTubeExtractorErrorCodeNoJSONData   =    3;


@interface LBYouTubeExtractorOperation_ : NSOperation
// Input
@property (nonatomic, copy) NSData *data;
@property (nonatomic) BOOL highQuality;

// Output
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSURL *extractedURL;

// Methods
- (NSURL *)movieURLParsingHTML:(NSString *)html error:(NSError **)error;
- (NSString *)unescapeString:(NSString *)string;
@end

@implementation LBYouTubeExtractorOperation_
@synthesize data = data_;
@synthesize error = error_;
@synthesize highQuality = highQuality_;
@synthesize extractedURL = extractedURL_;

- (void)main {
    // Check for cancellation
    if ([self isCancelled]) {
        return;
    }

    NSString *html = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    
    // Check for cancellation
    if ([self isCancelled]) {
        return;
    }
    
    if ([html length] <= 0) {
        // HTML can not be opened
        NSDictionary *errorUserInfo = [[NSDictionary alloc] initWithObjectsAndKeys:@"Couldn't download the HTML source code. URL might be invalid.", NSLocalizedDescriptionKey, nil];
        self.error = [[NSError alloc] initWithDomain:(NSString *)LBYouTubeExtractorErrorDomain code:LBYouTubeExtractorErrorCodeInvalidHTML userInfo:errorUserInfo];
        
        return;
    }
    
    // Here's HTML source: parse it
    NSError *extractionError = nil;
    NSURL *extractedURL = [self movieURLParsingHTML:html error:&extractionError];
    
    // Check for cancellation
    if ([self isCancelled]) {
        return;
    }
    
    // Set output and return
    self.error = extractionError;
    self.extractedURL = extractedURL;
}
                   
- (NSURL *)movieURLParsingHTML:(NSString *)html error:(NSError **)error {
//    NSLog(@"\n\n\n\n\n%@\n\n\n\n\n\n", html);
    
    NSString *JSONStart = nil;
    NSString *JSONStartFull = @"ls.setItem('PIGGYBACK_DATA', \")]}'";
    NSString *JSONStartShrunk = [JSONStartFull stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if ([html rangeOfString:JSONStartFull].location != NSNotFound) {
        JSONStart = JSONStartFull;
    }
    else if ([html rangeOfString:JSONStartShrunk].location != NSNotFound) {
        JSONStart = JSONStartShrunk;
    }
    
    // Stop if cancellation is requested
    if ([self isCancelled]) return nil;
    
    if (JSONStart == nil) {
        // No JSON: return an error
        NSDictionary *errorUserInfo = [[NSDictionary alloc] initWithObjectsAndKeys:@"The JSON data could not be found.", NSLocalizedDescriptionKey, nil];
        NSError *theError = [[NSError alloc] initWithDomain:(NSString *)LBYouTubeExtractorErrorDomain code:LBYouTubeExtractorErrorCodeNoJSONData userInfo:errorUserInfo];
        
        if (error != NULL) {
            *error = theError;
        }
        
        return nil;
    }
    
    // There is JSON data
    NSScanner *scanner = [[NSScanner alloc] initWithString:html];
    [scanner scanUpToString:JSONStart intoString:nil];
    [scanner scanString:JSONStart intoString:nil];
    
    // Stop if cancellation is requested
    if ([self isCancelled]) return nil;
    
    NSString *JSON = nil;
    BOOL foundString;
    
    do {
        foundString = [scanner scanUpToString:@"\");" intoString:&JSON];
    } while (foundString);
    
    JSON = [self unescapeString:JSON];
    
    
    if (JSON == nil) {
        // No JSON: return an error
        NSDictionary *errorUserInfo = [[NSDictionary alloc] initWithObjectsAndKeys:@"The JSON data could not be found.", NSLocalizedDescriptionKey, nil];
        NSError *theError = [[NSError alloc] initWithDomain:(NSString *)LBYouTubeExtractorErrorDomain code:LBYouTubeExtractorErrorCodeNoJSONData userInfo:errorUserInfo];
        
        if (error != NULL) {
            *error = theError;
        }
        
        return nil;
    }
        
    // Stop if cancellation is requested
    if ([self isCancelled]) return nil;
    
    BOOL useNativeParser;
#if USE_NATIVE_JSON_PARSER
    useNativeParser = ([NSJSONSerialization class] != nil);
#else
    useNativeParser = NO;
#endif
    
    NSError *decodingError = nil;
    NSData *jsonData = [JSON dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict;
    
    if (useNativeParser) {
        jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&decodingError];
    }
    else {
        // Setup JSON decoder
        JSONDecoder *decoder = [[JSONDecoder alloc] initWithParseOptions:JKParseOptionNone];        
        
        // Guard against JSONKit exceptions
        @try {
            jsonDict = [decoder objectWithData:jsonData error:&decodingError];
        }
        @catch (NSException *exception) {
            jsonDict = nil;
        }
    }
    
    // Check errors
    if (jsonDict == nil || decodingError) {
        if (error != NULL) {
            *error = decodingError;
        }
        
        return nil;
    }
    
    // Stop if cancellation is requested
    if ([self isCancelled]) return nil;
    
    // Ok: JSON parsed
    NSDictionary *video = [[jsonDict objectForKey:@"content"] objectForKey:@"video"];
    NSArray *formats = [video objectForKey:@"fmt_stream_map"];
    NSArray *qualities = [formats valueForKey:@"quality"];
    NSInteger quality1080Index = [qualities indexOfObject:@"hd1080"];
    NSInteger quality720Index = [qualities indexOfObject:@"hd720"];
    NSInteger mediumIndex = [qualities indexOfObject:@"medium"];
    NSInteger indexToUse = -1;
    NSString *streamURL = nil;
    
    // Get stream URL
    if (self.highQuality) {
        if (quality1080Index != NSNotFound) {
            indexToUse = quality1080Index;
        } else if (quality720Index != NSNotFound) {
            indexToUse = quality720Index;
        } else if (mediumIndex != NSNotFound) {
            indexToUse = mediumIndex;
        }
    } else {
        // Assume the last item is the lowest-quality for now
        indexToUse = [qualities count] - 1;
    }
    
    if (indexToUse > -1) {
        streamURL = [[formats objectAtIndex:indexToUse] objectForKey:@"url"];
    }
    
    // Stop if cancellation is requested
    if ([self isCancelled]) return nil;
    
    // Create NSURL object
    if (streamURL) {
        return [[NSURL alloc] initWithString:streamURL];
    }
    
    // No stream URL: return an error
    NSDictionary *errorUserInfo = [[NSDictionary alloc] initWithObjectsAndKeys:@"Couldn't find the stream URL.", NSLocalizedDescriptionKey, nil];
    NSError *theError = [[NSError alloc] initWithDomain:(NSString *)LBYouTubeExtractorErrorDomain code:LBYouTubeExtractorErrorCodeNoStreamURL userInfo:errorUserInfo];
    
    if (error != NULL) {
        *error = theError;
    }
    
    return nil;
}


- (NSString *)unescapeString:(NSString *)string {
#if USE_NATIVE_UNESCAPE
    // will cause trouble if you have "abc\\\\uvw"
    // \u   --->    \U
    NSString *esc1 = [string stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    
    // "    --->    \"
    NSString *esc2 = [esc1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    
    // \\"  --->    \"
    NSString *esc3 = [esc2 stringByReplacingOccurrencesOfString:@"\\\\\"" withString:@"\\\""];

    NSString *quoted = [[@"\"" stringByAppendingString:esc3] stringByAppendingString:@"\""];
    NSData *data = [quoted dataUsingEncoding:NSUTF8StringEncoding];
    
//  NSPropertyListFormat format = 0;
//  NSString *errorDescr = nil;
    NSString *unesc = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:NULL errorDescription:NULL];
    
    if ([unesc isKindOfClass:[NSString class]]) {
        // \U   --->    \u
        return [unesc stringByReplacingOccurrencesOfString:@"\\U" withString:@"\\u"];
    }
    
    return nil;
#else
    // tokenize based on unicode escape char
    NSMutableString* tokenizedString = [NSMutableString string];
    NSScanner* scanner = [NSScanner scannerWithString:string];
    while ([scanner isAtEnd] == NO)
    {
        // read up to the first unicode marker
        // if a string has been scanned, it's a token
        // and should be appended to the tokenized string
        NSString* token = @"";
        [scanner scanUpToString:@"\\u" intoString:&token];
        if (token != nil && token.length > 0)
        {
            [tokenizedString appendString:token];
            continue;
        }
        
        NSUInteger location = [scanner scanLocation];
        NSInteger extra = scanner.string.length - location - 4 - 2;
        if (extra < 0)
        {
            NSRange range = {location, -extra};
            [tokenizedString appendString:[scanner.string substringWithRange:range]];
            [scanner setScanLocation:location - extra];
            continue;
        }
        
        // move the location pas the unicode marker
        // then read in the next 4 characters
        location += 2;
        NSRange range = {location, 4};
        token = [scanner.string substringWithRange:range];
        
        // we don't need non-ascii because it would break the json (only intrested in urls) 
        if (token.intValue) {
            unichar codeValue = (unichar) strtol([token UTF8String], NULL, 16);
            [tokenizedString appendString:[NSString stringWithFormat:@"%C", codeValue]];
        }
        
        // move the scanner past the 4 characters
        // then keep scanning
        location += 4;
        [scanner setScanLocation:location];
    }
    
    NSString* retString = [tokenizedString stringByReplacingOccurrencesOfString:@"\\\\\"" withString:@""];
    return [retString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
#endif
}

@end

#pragma mark - 

@interface LBYouTubeExtractor ()
@property (nonatomic) BOOL connectionStarted_;
@property (nonatomic, strong) NSURLConnection *connection_;
@property (nonatomic, strong) NSMutableData *buffer_;
@property (nonatomic, strong) NSOperationQueue *extractionQueue_;

- (void)tearDownConnection_;
@end

@implementation LBYouTubeExtractor
@synthesize youTubeURL = youTubeURL_;
@synthesize highQuality = highQuality_;
@synthesize extractedURL = extractedURL_;
@synthesize completionHandler = completionHandler_;

@synthesize connectionStarted_ = connectionStarted__;
@synthesize connection_ = connection__;
@synthesize buffer_ = buffer__;
@synthesize extractionQueue_ = extractionQueue__;

- (id)init {
    self = [super init];
    if (self) {
        highQuality_ = NO;
    }
    return self;
}

- (void)dealloc {
    [self cancel];
}

#pragma mark - Extraction

- (BOOL)isRunning {
    return self.connectionStarted_;
}

- (void)start {
    if ([self isRunning]) {
        return;
    }
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:self.youTubeURL];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [request setValue:(NSString *)kPadUserAgent forHTTPHeaderField:@"User-Agent"];
    } else {
        [request setValue:(NSString *)kPhoneUserAgent forHTTPHeaderField:@"User-Agent"];
    }
    
    self.connection_ = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [self.connection_ start];
}

- (void)cancel {
    [self.connection_ cancel];
    self.connection_ = nil;
    
    [self.extractionQueue_ cancelAllOperations];
}

#pragma mark - Callbacks

- (void)didFinishExtractingURL:(NSURL *)extractedURL {
    if (self.completionHandler) {
        self.completionHandler(extractedURL, nil);
    }
}

- (void)didFailExtractingURLWithError:(NSError *)error {
    if (self.completionHandler) {
        self.completionHandler(nil, error);
    }
}

#pragma mark - Private

- (void)tearDownConnection_ {
    self.buffer_ = nil;
    self.connection_ = nil;
    self.connectionStarted_ = NO;
}

#pragma mark - NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Create buffer of the right size (if possible)
    NSUInteger capacity;
    if (response.expectedContentLength != NSURLResponseUnknownLength) {
        capacity = response.expectedContentLength;
    }
    else {
        capacity = 0;
    }
    
    self.buffer_ = [[NSMutableData alloc] initWithCapacity:capacity];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
    [self.buffer_ appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // Tear down connection
    [self tearDownConnection_];
    
    // Notify failure
    [self didFailExtractingURLWithError:error];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // Create queue lazily
    if (self.extractionQueue_ == nil) {
        self.extractionQueue_ = [[NSOperationQueue alloc] init];
        [self.extractionQueue_ setMaxConcurrentOperationCount:1];
    }
    
    // Create extraction operation
    LBYouTubeExtractorOperation_ *op = [[LBYouTubeExtractorOperation_ alloc] init];
    op.data = self.buffer_;
    op.highQuality = self.highQuality;
    
    // Attach completion block
    LBYouTubeExtractorOperation_ *strongOp = op;
    op.completionBlock = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self tearDownConnection_];
            
            if (![strongOp isCancelled]) {
                if (strongOp.extractedURL) {
                    [self didFinishExtractingURL:strongOp.extractedURL];
                }
                else {
                    [self didFailExtractingURLWithError:strongOp.error];
                }
            }
            
            // Break cycle
            strongOp.completionBlock = nil;
        });
    };
    
    // Fire operation
    [self.extractionQueue_ addOperation:op];
}

@end
