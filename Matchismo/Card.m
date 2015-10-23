//
//  Card.m
//  Matchismo
//
//  Created by Alexander Krupnik on 21/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//

#import "Card.h"

@interface Card()
@property(nonatomic,strong) NSMutableArray *history;
@end


@implementation Card

-(NSMutableArray *) history {
    if(!_history) {
        _history = [[NSMutableArray alloc] init];
    }
    return _history;
}

-(NSArray *) matchHistory {
    return self.history;
}

-(int) match:(NSArray *)otherCards {
    
    int score = 0;
    for (Card *card in otherCards) {
        if([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

@end
