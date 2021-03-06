#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"

@implementation UIImageView (WebCache)

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:nil];
}

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder
{
    SDWebImageManager *manager = [SDWebImageManager sharedManager];

    // Remove in progress downloader from queue
    [manager cancelForDelegate:self];

    UIImage *cachedImage = nil;
    if (url)
    {
        cachedImage = [manager imageWithURL:url];
    }

    if (cachedImage)
    {
        self.image = cachedImage;
    }
    else
    {
        if (placeholder)
        {
            self.image = placeholder;
        }

        if (url)
        {
            [manager downloadWithURL:url delegate:self];
        }
    }
}

- (void)cancelCurrentImageLoad
{
    [[SDWebImageManager sharedManager] cancelForDelegate:self];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image
{
    self.image = image;
}

@end
