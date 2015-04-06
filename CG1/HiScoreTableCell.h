//
//  HiScoreTableCell.h
//  CardGame1
//
//  Created by MEI C on 3/2/14.
//  Copyright (c) 2014 James Cremer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HiScoreTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;

@end
