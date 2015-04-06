//
//  CGViewController.h
//  CG1
//
//  Created by James Cremer on 1/30/14.
//  Copyright (c) 2014 James Cremer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGViewController : UIViewController <UIAlertViewDelegate>
- (void) updatePlayerInfoFor:(NSString*) playerName withScore:(NSInteger)score;
- (void) updateHiScoreListFor:(NSString*) playerName withScore:(NSInteger)score;

@end
