#import <UIKit/UIKit.h>
#import "SDWebImageDownloaderDelegate.h"
#import "SDWebImageManagerDelegate.h"

@interface SDWebImageManager : NSObject <SDWebImageDownloaderDelegate>
{
    NSMutableArray *delegates;
    NSMutableArray *downloaders;
    NSMutableDictionary *downloaderForURL;
    NSMutableArray *failedURLs;
}

+ (id)sharedManager;
- (UIImage *)imageWithURL:(NSURL *)url;
- (void)downloadWithURL:(NSURL *)url delegate:(id<SDWebImageManagerDelegate>)delegate;
- (void)cancelForDelegate:(id<SDWebImageManagerDelegate>)delegate;

@end
