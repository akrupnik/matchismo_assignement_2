//
//  Deck.h
//  Matchismo
//
//  Created by Alexander Krupnik on 21/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
-(void) addCard:(Card*) card atTop:(BOOL) atTop;
-(void) addCard:(Card *)card;
-(Card *) drawRandomCard;


@end
