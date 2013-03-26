#import <Foundation/Foundation.h>
#import "SDWebImageDownloaderDelegate.h"

@interface SDWebImageDownloader : NSObject
{
    @private
    NSURL *url;
    id<SDWebImageDownloaderDelegate> __unsafe_unretained delegate;
    NSURLConnection *connection;
    NSMutableData *imageData;
}

@property (nonatomic, strong) NSURL *url;
@property (nonatomic, unsafe_unretained) id<SDWebImageDownloaderDelegate> delegate;

+ (id)downloaderWithURL:(NSURL *)url delegate:(id<SDWebImageDownloaderDelegate>)delegate;
- (void)start;
- (void)cancel;

// This method is now no-op and is deprecated
+ (void)setMaxConcurrentDownloads:(NSUInteger)max __attribute__((deprecated));

@end
