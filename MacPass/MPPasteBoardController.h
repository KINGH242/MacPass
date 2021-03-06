//
//  MPPastBoardController.h
//  MacPass
//
//  Created by Michael Starke on 02.03.13.
//  Copyright (c) 2013 HicknHack Software GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPPasteBoardController : NSObject

/**
 *  The PasteBoardController did copy new items to the pasteboard
 *  The userInfo dictionary is empty. You can optain the timeout via the clearTimeout property
 */
FOUNDATION_EXPORT NSString *const MPPasteBoardControllerDidCopyObjects;
/**
 *  The PasteBoardController did clear the clipboard.
 *  The userInfo dictionary is empty
 */
FOUNDATION_EXPORT NSString *const MPPasteBoardControllerDidClearClipboard;

/*
 This time sets the time interval after which a copied entry shoudl be purged from the pasteboard
 */
@property (assign, nonatomic) NSTimeInterval clearTimeout;
@property (assign, nonatomic) BOOL clearPasteboardOnShutdown;

+ (MPPasteBoardController *)defaultController;

- (void)copyObjects:(NSArray *)objects;

@end
