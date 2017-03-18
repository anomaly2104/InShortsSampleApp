#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface UAPersistenceStack : NSObject

@property (nonatomic) NSManagedObjectContext *backgroundMOC;
@property (nonatomic) NSManagedObjectContext *mainMOC;

+ (instancetype)sharedInstance;
- (void)setupDataStore;

@end
