//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Alexander Krupnik on 21/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//

#import "CardMatchingGame.h"

#define MISMATCH_PENALTY 2;
#define MATCH_BONUS 4
#define COST_TO_CHOOSE 1;

@interface CardMatchingGame ()
@property(nonatomic, readwrite) NSInteger score;
@property(nonatomic,strong) NSMutableArray *cards;
@property(nonatomic, readwrite) NSString *lastEvent;
@end


@implementation CardMatchingGame

-(NSMutableArray *) cards {
    if(!_cards) {
       _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

-(void) chooseCardAtIndex:(NSUInteger)index {
    
    Card *card = [self cardAtIndex:index];
    NSLog(@"game type= %d", self.matchingCards);
    [self addChosenCardsToLastEvent:card];
    //NSLog(@"Card: Content = %@ chosen=%d matched = %d",card.contents, card.chosen,card.matched);
    if(self.matchingCards == 2) {
        //[self addChosenCardsToLastEvent:card];
        if(!card.isMatched) {
            if(card.isChosen) {
                self.lastEvent = [NSString stringWithFormat:@"%@ flipped",card.contents];
                card.chosen = NO; //flip card if it is chosen but do not match
            }
            else {
                for (Card *otherCard in self.cards ){
                    NSLog(@"otherCard: Content = %@ is chosen=%d matched = %d",otherCard.contents, otherCard.chosen,otherCard.matched);
                    if( otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if(matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            card.matched = YES;
                            otherCard.matched = YES;
                            self.lastEvent = [NSString stringWithFormat:@"%@ %@ are matched",card.contents, otherCard.contents];
                            
                        }
                        else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                            self.lastEvent = [NSString stringWithFormat:@"%@ %@ do not match",card.contents, otherCard.contents];
                        }
                        break;
                    }
                }
                self.score -= COST_TO_CHOOSE;
                card.chosen = YES;
            }
        }
    }
    else if (self.matchingCards == 3) {
        //[self addChosenCardsToLastEvent:card];
        if(!card.isMatched) {
            if(card.isChosen) {
                card.chosen = NO;
                self.lastEvent = [NSString stringWithFormat:@"%@ flipped",card.contents];
            }
            else {
                NSArray *cardsToCompare = [self findTwoCardsToCompare];
                if ([cardsToCompare count] == 2) {
                    int matchScore = [card match:cardsToCompare];
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        for (Card *cardToCompare in cardsToCompare){
                            cardToCompare.matched = YES;
                        }
                        self.lastEvent = [NSString stringWithFormat:@"%@ %@ %@ are matched",card.contents,
                                          ((Card *) cardsToCompare[0]).contents,
                                          ((Card *) cardsToCompare[1]).contents];
                    }
                    else {
                        self.score -= MISMATCH_PENALTY;
                        for (Card *cardToCompare in cardsToCompare){
                            cardToCompare.chosen = NO;
                        }
                        self.lastEvent = [NSString stringWithFormat:@"%@ %@ %@ do not match",card.contents,
                                          ((Card *) cardsToCompare[0]).contents,
                                          ((Card *) cardsToCompare[1]).contents];
                    }
                    
                }
                card.chosen = YES;
                self.score -= COST_TO_CHOOSE;
            }
        
        } // if none is matched
   } // if matching cards == 3
}

-(void) addChosenCardsToLastEvent:(Card *)newCard {
    NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
    if(!newCard.isMatched)[chosenCards addObject:newCard];
    for (Card *card in self.cards) {
        if(card.isChosen && !card.matched) {
            [chosenCards addObject:card];
        }
    }
    if([chosenCards count] == 2) {
        self.lastEvent = [NSString stringWithFormat:@"%@ %@ are chosen", ((Card *)chosenCards[0]).contents,
                          ((Card *)chosenCards[1]).contents ];
    }
    else if ([chosenCards count] == 1){
        self.lastEvent = [NSString stringWithFormat:@"%@ is chosen", ((Card *)chosenCards[0]).contents];
    }
}
    


-(NSArray *) findTwoCardsToCompare {
    NSMutableArray *cardsToCompare = [[NSMutableArray alloc] init];
    for (Card *card in self.cards) {
        if(card.isChosen && !card.isMatched){
            [cardsToCompare addObject:card];
        }
    }
    return cardsToCompare;
}


-(instancetype) initWithCardCount:(NSUInteger) count usingDeck:(Deck *) deck {
    self = [super init];
    if(self) {
        for(int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if(card) {
                [self.cards addObject:card];            }
            else {
               self = nil;
               break;
            }
        }
        
    }
    return self;
}

-(Card *) cardAtIndex:(NSUInteger) index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
