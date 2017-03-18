//
//  UANewsFetchManager.m
//  InShortsApp
//
//  Created by Udit Agarwal on 18/03/17.
//  Copyright © 2017 Udit Agarwal. All rights reserved.
//

#import "UANewsFetchManager.h"
#import <AFNetworking/AFNetworking.h>
#import <TDTChocolate/TDTFoundationAdditions.h>
#import "NSString+UAAdditions.h"
#import "UANewsItem+JSONDecoding.h"
#import "UAPersistenceStack.h"
#import <TDTChocolate/TDTCoreDataAdditions.h>

static NSString * const APIURL = @"https://read-api.newsinshorts.com/v1/news/";

@interface UANewsFetchManager ()

@property (nonatomic) AFURLSessionManager *sessionManager;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation UANewsFetchManager

- (instancetype)init {
  self = [super init];
  if (self) {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    _managedObjectContext = [UAPersistenceStack sharedInstance].backgroundMOC;
  }
  return self;
}

- (void)fetchNewsListWithNewsOffset:(NSString *)newsOffset
                          ascending:(BOOL)isAscending {
  NSMutableDictionary *parameters = [@{@"ascending_order": [NSString JSONStringForBoolValue:isAscending]} mutableCopy];
  if (newsOffset != nil) {
    parameters[@"news_offset"] = newsOffset;
  }
  NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                        URLString:APIURL
                                                                       parameters:parameters
                                                                            error:nil];
  NSURLSessionDataTask *dataTask = [self.sessionManager dataTaskWithRequest:request
                                                          completionHandler:^(NSURLResponse *response,
                                                                              NSDictionary *responseObject,
                                                                              NSError *error) {
                                                            if (responseObject == nil) {
                                                              TDTLogError(@"Error occurred while fetching news list: %@", error);
                                                            } else {
                                                              [self handleNewsListFetchResponse:responseObject];
                                                            }
                                                          }];
  [dataTask resume];
}

- (void)handleNewsListFetchResponse:(NSDictionary *)newsListResponse {
  [self.managedObjectContext performBlock:^{
    NSArray *newsList = newsListResponse[@"news_list"];
    [newsList tdt_applyBlock:^(NSDictionary *newsJSON) {
      NSError *error;
      UANewsItem *newsItem = [UANewsItem newsItemFromJSON:newsJSON
                                   inManagedObjectContext:self.managedObjectContext
                                                    error:&error];
      if (newsItem == nil) {
        TDTLogError(@"Error occurred while parsing news JSON: %@", error);
      }
    }];
    [self.managedObjectContext tdt_save];
  }];
}

@end
