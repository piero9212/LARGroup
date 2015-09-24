//
//  Flat.h
//  LARGruop
//
//  Created by piero.sifuentes on 24/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Floor, Plant;

@interface Flat : Entity

@property (nonatomic, retain) NSString * flatImageURL;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * size;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) Floor *floors;
@property (nonatomic, retain) Plant *plant;

@end
