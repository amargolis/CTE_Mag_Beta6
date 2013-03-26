#import <Foundation/Foundation.h>

@interface SDImageCache : NSObject
{
    NSMutableDictionary *memCache;
    NSString *diskCachePath;
    NSOperationQueue *cacheInQueue;
}

+ (SDImageCache *)sharedImageCache;
- (void)storeImage:(UIImage *)image forKey:(NSString *)key;
- (void)storeImage:(UIImage *)image forKey:(NSString *)key toDisk:(BOOL)toDisk;
- (UIImage *)imageFromKey:(NSString *)key;
- (UIImage *)imageFromKey:(NSString *)key fromDisk:(BOOL)fromDisk;
- (void)removeImageForKey:(NSString *)key;
- (void)clearMemory;
- (void)clearDisk;
- (void)cleanDisk;

@end
