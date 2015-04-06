//
//  DetailedPlayerController.m
//  CardGame1
//
//  Created by MEI C on 3/1/14.
//  Copyright (c) 2014 James Cremer. All rights reserved.
//

#import "DetailedPlayerController.h"

@interface DetailedPlayerController ()
@property (weak, nonatomic) IBOutlet UILabel *hiScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *hiTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastTimeLabel;
@property (weak, nonatomic) IBOutlet UINavigationItem *TitleItem;

@end

@implementation DetailedPlayerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *playerlist = [[NSUserDefaults standardUserDefaults] objectForKey:@"playerlist"];
    NSDictionary *currentplayer;
    for(int i=0;i<[playerlist count];i++){
        if ([[[playerlist objectAtIndex:i] objectForKey:@"name"]isEqualToString:self.playerName]){
            currentplayer = [playerlist objectAtIndex:i];
            break;
        }
    }
    NSLog(@"**********view appear%@",currentplayer);
    self.TitleItem.title = [currentplayer objectForKey:@"name"];
    self.hiScoreLabel.text = [NSString stringWithFormat:@"%d",[[currentplayer  objectForKey:@"hiscore"] intValue]];
    self.lastScoreLabel.text =[NSString stringWithFormat:@"%d",[[currentplayer  objectForKey:@"lastscore"] intValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSLog(@"%@",[NSTimeZone systemTimeZone]);
    self.hiTimeLabel.text = [formatter stringFromDate:[currentplayer objectForKey:@"hitime"]];//[NSString stringWithFormat:@"%@",[self.playerinfo objectForKey:@"hitime"]];
    self.lastTimeLabel.text = [formatter stringFromDate:[currentplayer objectForKey:@"lasttime"]];
	// Do any additional setup after loading the view.
}
-(void) viewDidAppear:(BOOL)animated{
    NSArray *playerlist = [[NSUserDefaults standardUserDefaults] objectForKey:@"playerlist"];
    NSDictionary *currentplayer;
    for(int i=0;i<[playerlist count];i++){
        if ([[[playerlist objectAtIndex:i] objectForKey:@"name"]isEqualToString:self.playerName]){
            currentplayer = [playerlist objectAtIndex:i];
            break;
        }
    }
    NSLog(@"**********view appear%@",currentplayer);
    self.TitleItem.title = [currentplayer objectForKey:@"name"];
    self.hiScoreLabel.text = [NSString stringWithFormat:@"%d",[[currentplayer  objectForKey:@"hiscore"] intValue]];
    self.lastScoreLabel.text =[NSString stringWithFormat:@"%d",[[currentplayer  objectForKey:@"lastscore"] intValue]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSLog(@"%@",[NSTimeZone systemTimeZone]);
    self.hiTimeLabel.text = [formatter stringFromDate:[currentplayer objectForKey:@"hitime"]];//[NSString stringWithFormat:@"%@",[self.playerinfo objectForKey:@"hitime"]];
    self.lastTimeLabel.text = [formatter stringFromDate:[currentplayer objectForKey:@"lasttime"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
