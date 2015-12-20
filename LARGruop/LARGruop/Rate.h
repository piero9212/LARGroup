//
//  Rate.h
//  LARGruop
//
//  Created by piero.sifuentes on 18/12/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Customer, Flat, Floor, Proyect;

@interface Rate : Entity

@property (nonatomic, retain) NSNumber * interestLevel;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Customer *customer;
@property (nonatomic, retain) Flat *flat;
@property (nonatomic, retain) Floor *floor;
@property (nonatomic, retain) Proyect *proyect;

@end
