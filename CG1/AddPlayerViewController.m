//
//  AddPlayerViewController.m
//  CardGame1
//
//  Created by MEI C on 2/26/14.
//  Copyright (c) 2014 James Cremer. All rights reserved.
//

#import "AddPlayerViewController.h"

@interface AddPlayerViewController () <UIAlertViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameInputField;

@end

@implementation AddPlayerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)startEditing:(id)sender {
    self.nameInputField.text = @"";
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return NO;

}
-(void)updatePlayerList:(NSString *)name{
    NSMutableArray *newlist = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"playerlist"]];
    if ([[name stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length] ==0 || [name isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Name cannot be blank" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        name = nil;
        [alert show];
    }
    for (NSDictionary *playerinfo in newlist) {
        if([[playerinfo objectForKey:@"name"] isEqualToString:name]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Opps!" message:@"This name has been taken" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            name = nil;
            [alert show];
            break;
        }
    }
    if (name) {
        NSDate *now = [NSDate date];
        NSDictionary *newplayer = [NSDictionary dictionaryWithObjects:@[name, @0, @0, now, now] forKeys:@[@"name",@"hiscore",@"lastscore",@"hitime",@"lasttime"]];
        [newlist addObject:newplayer];
        [[NSUserDefaults standardUserDefaults] setObject:newlist forKey:@"playerlist"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome!" message:@"New Player Added" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }


}
- (IBAction)editingEnd:(id)sender {
    
    [self updatePlayerList:self.nameInputField.text];
}
- (IBAction)addPressed {
    
    [self.nameInputField resignFirstResponder];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
