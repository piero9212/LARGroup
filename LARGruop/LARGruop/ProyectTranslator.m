//
//  ProyectTranslator.m
//  LARGruop
//
//  Created by Piero on 15/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//

#import "ProyectTranslator.h"
#import "Flat.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation ProyectTranslator

+ (void)proyectDictionary:(NSDictionary *)proyectDictionary toProyectEntity:(Proyect *)proyect context:(NSManagedObjectContext *)context
{
    id uidObject = [proyectDictionary valueForKeyPath:@"id"];
    proyect.uid = ([uidObject isKindOfClass:[NSString class]])? uidObject: ((NSNumber*)uidObject).stringValue;
    
    id nameObject = [proyectDictionary valueForKeyPath:@"name"];
    proyect.name = ([nameObject isKindOfClass:[NSString class]])? nameObject: nil;
    
    id addressObject = [proyectDictionary valueForKeyPath:@"address"];
    proyect.address = ([addressObject isKindOfClass:[NSString class]])? addressObject: nil;
    
    id districtObject = [proyectDictionary valueForKeyPath:@"district"];
    proyect.district = ([districtObject isKindOfClass:[NSString class]])? districtObject: nil;
    
    id imageObject = [proyectDictionary valueForKeyPath:@"image"];
    proyect.imageURL = ([imageObject isKindOfClass:[NSString class]])? imageObject: nil;
    
    id dimageObject = [proyectDictionary valueForKeyPath:@"dimage"];
    proyect.mapImageURL = ([dimageObject isKindOfClass:[NSString class]])? dimageObject: nil;
    
    id descriptionObject = [proyectDictionary valueForKeyPath:@"description"];
    proyect.proyectDescription = ([descriptionObject isKindOfClass:[NSString class]])? descriptionObject: nil;
    
    id mapDescriptionObject = [proyectDictionary valueForKeyPath:@"summary"];
    proyect.mapDescription = ([mapDescriptionObject isKindOfClass:[NSString class]])? mapDescriptionObject: nil;
    
    id latObject = [proyectDictionary valueForKeyPath:@"lat"];
    proyect.latitud = ([latObject isKindOfClass:[NSString class]])? latObject: nil;
    
    id longObject = [proyectDictionary valueForKeyPath:@"lng"];
    proyect.longitude = ([longObject isKindOfClass:[NSString class]])? longObject: nil;
    
    id videoObject = [proyectDictionary valueForKeyPath:@"video"];
    proyect.videoURL = ([videoObject isKindOfClass:[NSString class]])? videoObject: nil;
    
    id departamentsObject = [proyectDictionary valueForKeyPath:@"deparments"];
    NSArray *departamentDictionaries = ([departamentsObject isKindOfClass:[NSArray class]])? departamentsObject : nil;
    NSDictionary* departamentDictionary = [departamentDictionaries objectAtIndex:0];
    Flat* flat = [Flat MR_createEntityInContext:context];
    [self departamentDictionary:departamentDictionary toFlatEntity:flat];
    [proyect addFlatsObject:flat];

    
}

+ (void)recipientDictionary:(NSDictionary *)userDictionary toProyectEntity:(Proyect *)proyect
{}

+ (void)departamentDictionary:(NSDictionary *)departamentDictionary toFlatEntity:(Flat *)flat
{
    id uidObject = [departamentDictionary valueForKeyPath:@"id"];
    flat.uid = ([uidObject isKindOfClass:[NSString class]])? uidObject: ((NSNumber*)uidObject).stringValue;
    
    id nameObject = [departamentDictionary valueForKeyPath:@"name"];
    flat.name = ([nameObject isKindOfClass:[NSString class]])? nameObject: nil;
    
    id sizeObject = [departamentDictionary valueForKeyPath:@"size"];
    flat.size = ([sizeObject isKindOfClass:[NSString class]])? sizeObject: nil;
    
    id imageObject = [departamentDictionary valueForKeyPath:@"image"];
    flat.flatImageURL = ([imageObject isKindOfClass:[NSString class]])? imageObject: nil;
    
    id descriptionObject = [departamentDictionary valueForKeyPath:@"description"];
    flat.flatDetail = ([descriptionObject isKindOfClass:[NSString class]])? descriptionObject: nil;
    
    id proyectIDObject = [departamentDictionary valueForKeyPath:@"project_id"];
    flat.projectUID = ([proyectIDObject isKindOfClass:[NSString class]])? proyectIDObject: ((NSNumber*)uidObject).stringValue;
    
    id posXObject = [departamentDictionary valueForKeyPath:@"posX"];
    flat.posX = ([posXObject isKindOfClass:[NSString class]])? posXObject: ((NSNumber*)uidObject).stringValue;
    id posYObject = [departamentDictionary valueForKeyPath:@"posY"];
    flat.posX = ([posYObject isKindOfClass:[NSString class]])? posYObject: ((NSNumber*)uidObject).stringValue;
}

@end
