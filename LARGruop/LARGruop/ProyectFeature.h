//
//  ProyectFeature.h
//  LARGruop
//
//  Created by piero.sifuentes on 18/12/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Entity.h"

@class Proyect;

@interface ProyectFeature : Entity

@property (nonatomic, retain) NSString * featureDescription;
@property (nonatomic, retain) NSSet *proyect;
@end

@interface ProyectFeature (CoreDataGeneratedAccessors)

- (void)addProyectObject:(Proyect *)value;
- (void)removeProyectObject:(Proyect *)value;
- (void)addProyect:(NSSet *)values;
- (void)removeProyect:(NSSet *)values;

@end
