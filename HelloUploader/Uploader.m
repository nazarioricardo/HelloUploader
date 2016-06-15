//
//  Uploader.m
//  HelloUploader
//
//  Created by Ricardo Nazario on 3/15/16.
//  Copyright © 2016 Ricardo Nazario. All rights reserved.
//

#import "Uploader.h"

@implementation Uploader

+(void)createProfile:(NSString *)ID withName:(NSString *)name profileImage:(NSURL *)imageUrl andGender:(NSString *)gender{
    // Get CloudKit container and public database
    CKContainer *myContainer = [CKContainer containerWithIdentifier:@"iCloud.com.RicardoDev.helloU"];
    CKDatabase *publicDatabase = [myContainer publicCloudDatabase];
    
    // Create CloudKit record
    
    CKRecordID *uProfileRecordID = [[CKRecordID alloc] initWithRecordName:ID];
    CKRecord *uProfileRecord = [[CKRecord alloc] initWithRecordType:@"uProfile" recordID:uProfileRecordID];
    
    if (imageUrl) {

        NSLog(@"We have a URL %@", imageUrl);
        
        CKAsset *imageAsset = [[CKAsset alloc] initWithFileURL:imageUrl];
        uProfileRecord[@"image"] = imageAsset;
    }
    
    
    // Fill the new CKRecord with key/value pairs
    [uProfileRecord setObject:name forKey:@"name"];
    [uProfileRecord setObject:gender forKey:@"gender"];
    
    // Save into CloudKit
    [publicDatabase saveRecord:uProfileRecord
             completionHandler: ^(CKRecord *savedRecord, NSError *error){
                 if (!error) {
                     NSLog(@"%@ saved succesfully", savedRecord);
                 }else {
                     NSLog(@"%@", error);
                 }
             }];
    
}

//+(void)addSoundFiles:(NSString *)profileID forLevel:(NSString *)level {
//
//    unsigned short lineNumber = 1;
//    
//    NSString *lineID = [NSString stringWithFormat:@"%@%@%u", profileID, level, lineNumber];
//    
//    NSURL *audioURL = [[NSBundle mainBundle] URLForResource:lineID withExtension:@"mp3"];
//    
//    if (audioURL) {
//        NSLog(@"URL is valid");
//    
//        while (audioURL) {
//            // Upload file
//            
//            NSLog(@"%@", lineID);
//            
//            [self saveLine:lineID profile:profileID level:level url:audioURL];
//            
//            lineNumber++;
//            lineID = [NSString stringWithFormat:@"%@%@%u", profileID, level, lineNumber];
//            audioURL = [[NSBundle mainBundle] URLForResource:lineID withExtension:@"mp3"];
//        }
//    } else {
//        NSLog(@"File not found");
//    }
//}

+(void)saveLine:(NSString *)line profile:(NSString *)ownerProfile level:(NSString *)lineLevel url:(NSURL *)audioURL withCompletionHandler:(UploaderCompletionHandler)handler {
    
    CKContainer *myContainer = [CKContainer containerWithIdentifier:@"iCloud.com.RicardoDev.helloU"];
    CKDatabase *publicDatabase = [myContainer publicCloudDatabase];
    
    CKRecordID *uLineRecordID = [[CKRecordID alloc] initWithRecordName:line];
    CKRecord *uLineRecord = [[CKRecord alloc] initWithRecordType:@"uLine" recordID:uLineRecordID];
    
    CKAsset *audioAsset = [[CKAsset alloc] initWithFileURL:audioURL];
    uLineRecord[@"line"] = audioAsset;
    
    [uLineRecord setObject:ownerProfile forKey:@"name"];
    [uLineRecord setObject:lineLevel forKey:@"level"];
    
    // Save into CloudKit
    [publicDatabase saveRecord:uLineRecord
             completionHandler: ^(CKRecord *savedRecord, NSError *error) {
                 
                 if (!handler) return;
                 
                 dispatch_async(dispatch_get_main_queue(), ^{
                     handler (savedRecord, error);
                 });
             }];
}

@end
