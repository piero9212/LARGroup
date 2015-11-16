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

@interface ProyectTranslator : NSObject

+ (void)proyectDictionary:(NSDictionary *)proyectDictionary toProyectEntity:(Proyect *)proyect;
+ (void)recipientDictionary:(NSDictionary *)proyectDictionary toProyectEntity:(Proyect *)proyect;

+ (void)departamentDictionary:(NSDictionary *)departamentDictionary toFlatEntity:(Flat *)flat;
@end
