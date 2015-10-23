//
//  Card.h
//  Matchismo
//
//  Created by Alexander Krupnik on 21/10/15.
//  Copyright (c) 2015 Alexander Krupnik. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property(nonatomic,strong) NSString *contents;

@property(nonatomic, getter = isChosen) BOOL chosen;
@property(nonatomic, getter = isMatched) BOOL matched;

-(NSArray *) matchHistory;
-(int) match: (NSArray *) otherCards;

@end
