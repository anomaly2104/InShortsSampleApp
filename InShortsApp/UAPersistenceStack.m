#import "UAPersistenceStack.h"
#import <TDTChocolate/TDTFoundationAdditions.h>

@implementation UAPersistenceStack

+ (instancetype)sharedInstance {
  static UAPersistenceStack *sharedInstance;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sharedInstance = [[UAPersistenceStack alloc] init];
  });
  return sharedInstance;
}

+ (NSURL *)storeURL {
  NSURL *documentsDirectory = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory
                                                                     inDomain:NSUserDomainMask
                                                            appropriateForURL:nil
                                                                       create:YES
                                                                        error:nil];
  return [documentsDirectory URLByAppendingPathComponent:@"db.sqlite"];
}

+ (NSURL *)modelURL {
  return [[NSBundle mainBundle] URLForResource:@"InShortsApp"
                                 withExtension:@"momd"];
}

#pragma mark

- (void)setupDataStore {
  NSPersistentStoreCoordinator *storeCoordinator =
  [self persistentCoordinatorForStoreURL:[[self class] storeURL]
                                modelURL:[[self class] modelURL]];
  
  _mainMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
  _mainMOC.persistentStoreCoordinator = storeCoordinator;
  
  _backgroundMOC = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
  _backgroundMOC.persistentStoreCoordinator = storeCoordinator;
  
  //We need to specify the exact moc to be observed otherwise we start
  //listening to google analytics' notifications and it will fail.
  //For more info check:
  //http://stackoverflow.com/questions/22102155/ios-google-analytics-memory-growing-out-of-control-fast
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(contextDidSaveNotification:)
                                               name:NSManagedObjectContextDidSaveNotification
                                             object:_backgroundMOC];
}

- (NSPersistentStoreCoordinator *)persistentCoordinatorForStoreURL:(NSURL *)storeURL
                                                          modelURL:(NSURL *)modelURL {
  NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  NSPersistentStoreCoordinator *storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
  NSError *error;
  if(![storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                 configuration:nil
                                           URL:storeURL
                                       options:nil
                                            error:&error]) {
    if ([error code] == NSPersistentStoreIncompatibleVersionHashError) {
      TDTLogWarn(@"Deleting incompatible sqlite file at: %@", storeURL);
      [[NSFileManager defaultManager] removeItemAtURL:storeURL error:NULL];
    } else {
      TDTLogError(@"Failed to open persistent store [description = %@, reason = %@]",
                  [error localizedDescription],
                  [error localizedFailureReason]);
      abort();
    }
  }
  
  return storeCoordinator;
}

#pragma mark - Managed Object Observer

- (void)contextDidSaveNotification:(NSNotification *)notification {
  TDTLog(@"Context saved");
  [self.mainMOC performBlock:^{
    [self.mainMOC mergeChangesFromContextDidSaveNotification:notification];
  }];
}


@end
