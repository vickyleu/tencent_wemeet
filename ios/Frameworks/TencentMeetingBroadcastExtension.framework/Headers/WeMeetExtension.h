//
//  WeMeetExtension.h
//  WeMeetExtensionSDK
//
//  Created by rogerlin on 07/03/2018.
//  Copyright 2018 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface WeMeetExtension : NSObject

typedef void (^WeMeetCompletionHandler)(NSError *error);

+ (instancetype)sharedInstance;

- (void) startWithMainBundleID:(NSString *)mainBundleId errorCompletion:(WeMeetCompletionHandler)completion;
/**
 * abstract      Process the video data of Replaykit2 and send it to the peer.
 * discussion    The calling timing is in the case of RPSampleBufferTypeVideo of processSampleBuffer:withType: in SampleHandler
 * param         sampleBuffer              replaykit2 raw video data
 */
- (void)handleVideoSampleBuffer:(CMSampleBufferRef)sampleBuffer;

/**
 * abstract      After opening replaykit2, it will automatically jump to the corresponding application of bundleID
 * discussion    The call timing is in the broadcastStartedWithSetupInfo: in the SampleHandler
 * param         bundleID                  The bundle ID of the main app
 */
- (void)jumpToMainAppWithBundleID:(NSString *)bundleID;

/**
 * abstract     Add notifications for cross-process communication to monitor the survival of the main process and the Extension process.
 * discussion    The call timing is in the broadcastStartedWithSetupInfo: in the SampleHandler
 * param         completion                      The extension terminates the processing, you need to call [super finishBroadcastWithError:error] in the block.
 */
- (void)addReplayKitWithGroupId:(NSString *)groupId withErrorCompletion:(WeMeetCompletionHandler)completion;

/**
 * abstract      When the Extension is stopped, the main process is notified to monitor the survival of the main process and the Extension process.
 * discussion    The call timing is in broadcastFinished in the SampleHandler
 */
- (void)postExtensionFinish;

- (void)finishWithError:(NSError *)error;

- (void)handleSystemAudioSampleBuffer:(CMSampleBufferRef)sampleBuffer;

- (void)addSystemAudioWithErrorCompletion:(WeMeetCompletionHandler)completion;
@end
