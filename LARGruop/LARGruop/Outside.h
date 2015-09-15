//
//  Outside.h
//  LARGruop
//
//  Created by piero.sifuentes on 15/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Proyect;

@interface Outside : Entity

@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * outsideDescription;
@property (nonatomic, retain) Proyect *proyect;

@end