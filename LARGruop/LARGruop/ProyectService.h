//
//  ProyectService.h
//  LARGruop
//
//  Created by piero.sifuentes on 16/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "GenericService.h"

@interface ProyectService : GenericService

@property (nonatomic, readonly) BOOL allClassesSelected;

+ (ProyectService *)sharedService;

+ (NSMutableArray *)filterProyects;
+ (void)setFilterProyects:(NSMutableArray *)filterProyects;

- (void)resetProyectsFilter;
- (NSArray *)getAllProyects;



- (Proyect *)getProyect:(Proyect *)proyect fromContext:(NSManagedObjectContext *)context;
- (Proyect *)newProyect;
- (NSCompoundPredicate *)getProyectFilterPredicate;
- (Proyect *)getProyectWithId:(NSString *)proyectId;

- (NSArray *)getFilteredProyectsWithoutNulls;


@end
