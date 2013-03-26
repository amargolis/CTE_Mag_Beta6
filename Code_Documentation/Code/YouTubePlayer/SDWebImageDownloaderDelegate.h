@class SDWebImageDownloader;

@protocol SDWebImageDownloaderDelegate <NSObject>

@optional

- (void)imageDownloader:(SDWebImageDownloader *)downloader didFinishWithImage:(UIImage *)image;
- (void)imageDownloader:(SDWebImageDownloader *)downloader didFailWithError:(NSError *)error;

@end
