//
//  ProyectFeature+CoreDataProperties.h
//  LARGruop
//
//  Created by piero.sifuentes on 16/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProyectFeature.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProyectFeature (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *featureDescription;
@property (nullable, nonatomic, retain) NSSet<Proyect *> *proyect;

@end

@interface ProyectFeature (CoreDataGeneratedAccessors)

- (void)addProyectObject:(Proyect *)value;
- (void)removeProyectObject:(Proyect *)value;
- (void)addProyect:(NSSet<Proyect *> *)values;
- (void)removeProyect:(NSSet<Proyect *> *)values;

@end

NS_ASSUME_NONNULL_END
