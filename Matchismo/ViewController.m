//
//  ViewController.m
//  Matchismo
//
//  Created by Alexander Krupnik on 20/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"


@interface ViewController ()
@property(strong,nonatomic) Deck *deck;
@property(strong, nonatomic) CardMatchingGame *game;


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISwitch *modeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *history;

- (IBAction)gameTypeChanged:(UISwitch *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.modeSwitch.on = NO;
}

-(CardMatchingGame *) game {
    if(!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
        _game.matchingCards = self.modeSwitch.isOn ? 3:2;
    }
    return _game;
}



-(Deck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}


- (IBAction)touchCardButton:(UIButton *)sender {
    self.modeSwitch.enabled = NO;
    NSUInteger cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}


-(void) updateUI {
    for (UIButton *cardButton  in self.cardButtons) {
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld",self.game.score];
    self.history.text = self.game.lastEvent;
    
}

-(NSString *) titleForCard:(Card *)card {
    
    return card.isChosen ? card.contents : @"";
}

-(UIImage *) backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront":@"cardback"];
}



- (IBAction)resetGame:(id)sender {
    self.game = nil;
    self.modeSwitch.enabled = YES;
    [self updateUI];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)gameTypeChanged:(UISwitch *)sender {
    self.modeSwitch.on = sender.isOn;
    if(sender.isOn) {
        NSLog(@"matching cards = 3");
        self.game.matchingCards = 3;
    }
    else {
        NSLog(@"matching cards = 2");
        self.game.matchingCards = 2;
    }

}
@end
