//
//  PlayingCard.h
//  Matchismo
//
//  Created by Alexander Krupnik on 21/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "Card.h"


@interface PlayingCard : Card

@property(nonatomic,strong) NSString *suit;
@property(nonatomic) NSUInteger rank;

+(NSArray *) validSuits;
+(NSUInteger) maxRank;




@end
