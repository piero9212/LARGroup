//
//  Flat.h
//  LARGruop
//
//  Created by piero.sifuentes on 15/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Proyect;

@interface Flat : Entity

@property (nonatomic, retain) NSString * flatImageURL;
@property (nonatomic, retain) NSString * flatID;
@property (nonatomic, retain) NSString * range;
@property (nonatomic, retain) NSString * flatDescription;
@property (nonatomic, retain) Proyect *proyect;

@end
