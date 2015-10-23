//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Alexander Krupnik on 21/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

-(instancetype) initWithCardCount:(NSUInteger) count usingDeck:(Deck *) deck;
-(void) chooseCardAtIndex: (NSUInteger) index;
-(Card *) cardAtIndex:(NSUInteger) index;
@property(nonatomic,readonly) NSInteger score;
@property(nonatomic) int matchingCards;
@property(nonatomic,readonly) NSString *lastEvent;
@end
