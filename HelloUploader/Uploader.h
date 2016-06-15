//
//  Uploader.h
//  HelloUploader
//
//  Created by Ricardo Nazario on 3/15/16.
//  Copyright © 2016 Ricardo Nazario. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CloudKit/CloudKit.h"

typedef void(^UploaderCompletionHandler)(CKRecord *savedRecord, NSError *error);

@interface Uploader : NSObject

+(void)createProfile:(NSString *)ID withName:(NSString *)name profileImage:(NSURL *)imageUrl andGender:(NSString *)gender;
//+(void)addSoundFiles:(NSString *)profileID forLevel:(NSString *)level;
+(void)saveLine:(NSString *)line profile:(NSString *)ownerProfile level:(NSString *)lineLevel url:(NSURL *)audioURL withCompletionHandler:(UploaderCompletionHandler)handler;

@end
