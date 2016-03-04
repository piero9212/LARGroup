//
//  ProyectTranslator.h
//  LARGruop
//
//  Created by Piero on 15/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Proyect.h"
#import "Flat.h"
#import "Promo.h"
#import "Quote.h"

@interface ProyectTranslator : NSObject

+ (void)proyectDictionary:(NSDictionary *)proyectDictionary toProyectEntity:(Proyect *)proyect context:(NSManagedObjectContext *)context;

+(void)departamentDictionary:(NSDictionary *)departamentDictionary toFlatEntity:(Flat *)flat context:(NSManagedObjectContext *)context;

+(void)promoDictionary:(NSDictionary *)promoDictionary toPromoEntity:(Promo *)promo context:(NSManagedObjectContext *)context;

+(void)quoteDictionary:(NSDictionary *)quoteDictionary toQuoteEntity:(Quote *)quote context:(NSManagedObjectContext *)context;

@end
