//
//  ProyectTranslator.m
//  LARGruop
//
//  Created by Piero on 15/11/15.
//  Copyright © 2015 prsp.org. All rights reserved.
//

#import "ProyectTranslator.h"
#import "Flat.h"
#import "Outside.h"
#import "ProyectFeature.h"
#import "Floor.h"
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
    proyect.mapImageURL = ([dimageObject isKindOfClass:[NSString class]])? imageObject: nil;
    
    id descriptionObject = [proyectDictionary valueForKeyPath:@"description"];
    proyect.proyectDescription = ([descriptionObject isKindOfClass:[NSString class]])? descriptionObject: nil;
    
    id mapDescriptionObject = [proyectDictionary valueForKeyPath:@"summary"];
    proyect.mapDescription = ([mapDescriptionObject isKindOfClass:[NSString class]])? mapDescriptionObject: nil;
    
    id featuresObject = [proyectDictionary valueForKeyPath:@"features"];
    NSArray *featuresArray = ([featuresObject isKindOfClass:[NSArray class]])? featuresObject : nil;
    for(NSString* feature in featuresArray)
    {
        ProyectFeature* proyectFeature = [ProyectFeature MR_createEntityInContext:context];
        proyectFeature.featureDescription = feature;
        [proyect addFeaturesObject:proyectFeature];
    }
    
    id latObject = [proyectDictionary valueForKeyPath:@"lat"];
    proyect.latitud = ([latObject isKindOfClass:[NSNumber class]])? latObject: nil;
    
    id longObject = [proyectDictionary valueForKeyPath:@"lng"];
    proyect.longitude = ([longObject isKindOfClass:[NSNumber class]])? longObject: nil;
    
    id videoObject = [proyectDictionary valueForKeyPath:@"video"];
    proyect.videoURL = ([videoObject isKindOfClass:[NSString class]])? videoObject: nil;
    
    id exteriorsObject = [proyectDictionary valueForKeyPath:@"exteriors"];
    NSArray *exteriorsArray = ([exteriorsObject isKindOfClass:[NSArray class]])? exteriorsObject : nil;
    for(NSString* exterior in exteriorsArray)
    {
        Outside* outside = [Outside MR_createEntityInContext:context];
        outside.imageURL = exterior;
        outside.outsideDescription = @"";
        [proyect addOutsideImagesObject:outside];
    }
    
    id floorsObject = [proyectDictionary valueForKeyPath:@"floors"];
    NSArray *floorsDictionaries = ([floorsObject isKindOfClass:[NSArray class]])? floorsObject : nil;
    if(floorsDictionaries)
    {
        int i =1;
        for(NSDictionary* floorDictionary in floorsDictionaries)
        {
            Floor* floor = [Floor MR_createEntityInContext:context];
            [self floorDictionary:floorDictionary toFloorEntity:floor andFloorNumber:i];
            id departamentsObject = [floorDictionary valueForKeyPath:@"deparments"];
            NSArray *departamentDictionaries = ([departamentsObject isKindOfClass:[NSArray class]])? departamentsObject : nil;
            for(NSDictionary* departamentDictionary in departamentDictionaries)
            {
                Flat* flat = [Flat MR_createEntityInContext:context];
                [self departamentDictionary:departamentDictionary toFlatEntity:flat];
                flat.floor = floor;
                [proyect addFlatsObject:flat];
            }
        }
    }
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
    flat.projectUID = ([proyectIDObject isKindOfClass:[NSString class]])? proyectIDObject: ((NSNumber*)proyectIDObject).stringValue;
    
    id posXObject = [departamentDictionary valueForKeyPath:@"posX"];
    flat.posX = ([posXObject isKindOfClass:[NSString class]])? posXObject: ((NSNumber*)posXObject).stringValue;
    id posYObject = [departamentDictionary valueForKeyPath:@"posY"];
    flat.posX = ([posYObject isKindOfClass:[NSString class]])? posYObject: ((NSNumber*)posYObject).stringValue;
}

+ (void)floorDictionary:(NSDictionary *)floorDictionary toFloorEntity:(Floor *)floor andFloorNumber:(int)number
{
    id uidObject = [floorDictionary valueForKeyPath:@"id"];
    floor.uid = ([uidObject isKindOfClass:[NSString class]])? uidObject: ((NSNumber*)uidObject).stringValue;
    floor.number = [NSNumber numberWithInt:number];
}

@end
