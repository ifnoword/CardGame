//
//  CGViewController.m
//  CG1
//
//  Created by James Cremer on 1/30/14.
//  Copyright (c) 2014 James Cremer. All rights reserved.
//

#import "CGViewController.h"
#import "Card.h"
#import "FrenchPlayingCardDeck.h"
#import "MatchingGame.h"

@interface CGViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeControl;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel;

@property (nonatomic) int highScore;
@property (strong, nonatomic) MatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *decklabel;
@property (strong, nonatomic) Deck *playingDeck;

@end

@implementation CGViewController
- (Deck *) playingDeck {
    if (!_playingDeck) {
        _playingDeck = [self createDeck];
    }
    return _playingDeck;
}

- (MatchingGame *) game {
	if (!_game){
		_game = [[MatchingGame alloc] initWithNumCards:[self.cardButtons count]
											  fromDeck:self.playingDeck
										   andMatchType:[self gameType]
				 ];
        self.decklabel.text = [NSString stringWithFormat:@"%d cards left", [self.playingDeck numofCardLeft]];
    }
	return _game;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

}


- (Deck *) createDeck {
	return [[FrenchPlayingCardDeck alloc] init];
}
-(void)gameRestart{
    self.game = nil;
    self.playingDeck = nil;
	[self.gameTypeControl setEnabled:YES];
	[self updateUI];
}

- (IBAction)startNewGame:(id)sender {
    NSString *currentPlayer = [[NSUserDefaults standardUserDefaults] objectForKey:@"player"];
    [self updateHiScoreListFor:currentPlayer withScore:self.game.score];
    [self updatePlayerInfoFor:currentPlayer withScore:self.game.score];
    [self gameRestart];
}

- (void) updateUI {
	UIImage *cardImage;
	for (UIButton *button in self.cardButtons) {
		[button setEnabled:YES];
		NSUInteger buttonIndex = [self.cardButtons indexOfObject:button];
		Card *card = [self.game cardAtIndex:buttonIndex];
		if (card.isChosen) {
			cardImage = [UIImage imageNamed:@"cardfront"];
			[button setBackgroundImage:cardImage forState:UIControlStateNormal];
			[button setTitle:card.contents forState:UIControlStateNormal];
			if (card.isMatched)
				[button setEnabled:NO];				
		} else {
			cardImage = [UIImage imageNamed:@"cardback"];
			[button setBackgroundImage:cardImage forState:UIControlStateNormal];
			[button setTitle:@"" forState:UIControlStateNormal];
		}
	}
	[self.scoreLabel setText:[NSString stringWithFormat:@"Score: %d", self.game.score]];
	//[self.highScoreLabel setText:[NSString stringWithFormat:@"High Score: %d", self.highScore]];
}
- (IBAction)touchedCardButton:(UIButton *)sender {
	NSLog(@"card button pressed");
	[self.gameTypeControl setEnabled:NO];
	NSUInteger index = [self.cardButtons indexOfObject:sender];
	[self.game chooseCardAtIndex:index];
	//if (self.game.score > self.highScore)
	//	self.highScore = self.game.score;
	//[[NSUserDefaults standardUserDefaults] setInteger:self.highScore
	//										   forKey:@"highScore"];
	//[[NSUserDefaults standardUserDefaults] synchronize];
	[self updateUI];
	
	
	
}

- (IBAction)deckBtnPressed {
    if ([self.playingDeck numofCardLeft]) {
        for (UIButton *btn in self.cardButtons) {
            NSInteger index = [self.cardButtons indexOfObject:btn];
            Card *currentCard = [self.game cardAtIndex:index];
            if (!currentCard.isChosen && !currentCard.isMatched) {
                Card *newCard = [self.playingDeck drawRandomCard];
                [self.game replaceCardAtIndex:index with:newCard];
            }
            if (![self.playingDeck numofCardLeft]) break;
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Empty Deck" message:@"Press New Game to restart" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
        [alert show];
    }
    self.decklabel.text = [NSString stringWithFormat:@"%d cards left", self.playingDeck.numofCardLeft];
}

#define TWO_MATCH 2
#define THREE_MATCH 3

- (NSInteger) gameType {
	if (self.gameTypeControl.selectedSegmentIndex == 0)
		return TWO_MATCH;
	else
		return THREE_MATCH;
}

- (IBAction)changeGameType {
	self.game.gameType = [self gameType];
	NSLog(@"gt %d", self.game.gameType);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//int savedHighScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"highScore"];
    NSString *savedPlayer = [[NSUserDefaults standardUserDefaults] stringForKey:@"player"];
    NSData *savedDeck = [[NSUserDefaults standardUserDefaults] objectForKey:@"deck"];
    NSData *savedGame = [[NSUserDefaults standardUserDefaults] objectForKey:@"game"];
    //self.currentPlayer = savedPlayer;
	//self.highScore = savedHighScore;
    if (savedDeck) {
        self.game = (MatchingGame *)[NSKeyedUnarchiver unarchiveObjectWithData:savedGame];
        self.playingDeck = (Deck *)[NSKeyedUnarchiver unarchiveObjectWithData:savedDeck];
        self.decklabel.text = [NSString stringWithFormat:@"%d cards left", self.playingDeck.numofCardLeft];
        if (self.game.gameType==TWO_MATCH)
            self.gameTypeControl.selectedSegmentIndex = 0;
        else
            self.gameTypeControl.selectedSegmentIndex = 1;
        [self.gameTypeControl setEnabled:NO];
    }
    self.playerLabel.text = savedPlayer;
	[self updateUI];
}
-(void) viewWillDisappear:(BOOL)animated{
    NSData *encodedDeck = [NSKeyedArchiver archivedDataWithRootObject:self.playingDeck];
    NSData *encodedGame = [NSKeyedArchiver archivedDataWithRootObject:self.game];
    [[NSUserDefaults standardUserDefaults] setObject:encodedDeck forKey:@"deck"];
    [[NSUserDefaults standardUserDefaults] setObject:encodedGame forKey:@"game"];
    //player has been stored after choosing
    [[NSUserDefaults standardUserDefaults] synchronize];
    //save player info when main game board exits.
    NSString *currentPlayer =[[NSUserDefaults standardUserDefaults] objectForKey:@"player"];
    [self updatePlayerInfoFor:currentPlayer withScore:self.game.score];
    [self updateHiScoreListFor:currentPlayer withScore:self.game.score];
    
}
-(void) viewWillAppear:(BOOL)animated{
    NSString *currentPlayer =[[NSUserDefaults standardUserDefaults] objectForKey:@"player"];
    NSString *lastPlayer = self.playerLabel.text;
    //when player changes, save data for last player
    if (![lastPlayer isEqualToString:currentPlayer]){
        [self updatePlayerInfoFor:lastPlayer withScore:self.game.score];
        [self updateHiScoreListFor:lastPlayer withScore:self.game.score];
        [self gameRestart];
    }
    self.playerLabel.text = currentPlayer;
}

-(void)updatePlayerInfoFor:(NSString *)playerName withScore:(NSInteger)score{
    NSMutableArray *playerInfoList = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"playerlist"]];
    NSDate *now = [NSDate date];
    int length = [playerInfoList count];
    int i;
    for (i = 0;i<length;i++) {
        if ([[[playerInfoList objectAtIndex:i] objectForKey:@"name"] isEqualToString:playerName])
            break;
    }
    NSMutableDictionary *newinfo = [[NSMutableDictionary alloc] initWithDictionary:[playerInfoList objectAtIndex:i]];
    [newinfo setObject:[NSNumber numberWithInteger:score] forKey:@"lastscore"];
    [newinfo setObject:now forKey:@"lasttime"];
    if([[newinfo objectForKey:@"hiscore"] integerValue] < score){
        [newinfo setObject:[NSNumber numberWithInteger:score] forKey:@"hiscore"];
        [newinfo setObject:now forKey:@"hitime"];
    }
    [playerInfoList replaceObjectAtIndex:i withObject:newinfo];
    [[NSUserDefaults standardUserDefaults] setObject:playerInfoList forKey:@"playerlist"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)updateHiScoreListFor:(NSString *)playerName withScore:(NSInteger)score{
    NSMutableArray *hilist = [[NSMutableArray alloc] initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"topscores"]];
    int length = hilist.count;
    for(int i=0; i < length;i++){
        NSDictionary *hiscore = [hilist objectAtIndex:i];
        if([[hiscore objectForKey:@"score"] integerValue] < score){
            NSDictionary *newhiscore = [[NSDictionary alloc]initWithObjects:@[playerName, [NSNumber numberWithInteger:score]] forKeys:@[@"name", @"score"]];
            [hilist insertObject:newhiscore atIndex:i];
            break;
        }
    }
    if (hilist.count > length) {
        [hilist removeLastObject];
        [[NSUserDefaults standardUserDefaults] setObject:hilist forKey:@"topscores"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
