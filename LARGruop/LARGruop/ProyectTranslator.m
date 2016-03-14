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
#import "StatusCode.h"
#import "FlatFeature.h"
#import "Customer.h"

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
    
    id minRoomsObject = [proyectDictionary valueForKeyPath:@"min_rooms"];
    proyect.minRooms = ([minRoomsObject isKindOfClass:[NSNumber class]])? minRoomsObject: nil;
    
    id maxRoomsObject = [proyectDictionary valueForKeyPath:@"max_rooms"];
    proyect.maxRooms = ([maxRoomsObject isKindOfClass:[NSNumber class]])? maxRoomsObject: nil;
    
    id minPriceObject = [proyectDictionary valueForKeyPath:@"min_price"];
    proyect.minPrice = ([minPriceObject isKindOfClass:[NSString class]])? minPriceObject : nil;
    
    id maxPriceObject = [proyectDictionary valueForKeyPath:@"max_price"];
    proyect.maxPrice = ([maxPriceObject isKindOfClass:[NSString class]])? maxPriceObject : nil;
    
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
            id departamentsObject = [floorDictionary valueForKeyPath:@"departments"];
            NSArray *departamentDictionaries = ([departamentsObject isKindOfClass:[NSArray class]])? departamentsObject : nil;
            for(NSDictionary* departamentDictionary in departamentDictionaries)
            {
                Flat* flat = [Flat MR_createEntityInContext:context];
                [self departamentDictionary:departamentDictionary toFlatEntity:flat context:context];
                flat.floor = floor;
                [floor addFlatsObject:flat];
            }
            i++;
            [proyect addFloorsObject:floor];
        }
        proyect.floorsCount = [NSNumber numberWithInteger:floorsDictionaries.count];
        NSPredicate* flatStatusPredicate = [NSPredicate predicateWithFormat:@"SELF.status == %@",[NSString stringWithFormat:@"%d",StatusCodeFree]];
        NSArray* floors = [proyect.floors allObjects];
        NSMutableArray* flats = [[NSMutableArray alloc]init];
        for (Floor* proyectFloor in floors) {
            NSArray* flatsPerFloor = [proyectFloor.flats allObjects];
            [flats addObjectsFromArray:flatsPerFloor];
        }

        proyect.state = [NSNumber numberWithInteger:[flats filteredArrayUsingPredicate:flatStatusPredicate].count];
    }
}

+ (void)recipientDictionary:(NSDictionary *)userDictionary toProyectEntity:(Proyect *)proyect
{}

+ (void)departamentDictionary:(NSDictionary *)departamentDictionary toFlatEntity:(Flat *)flat context:(NSManagedObjectContext *)context

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
    
    id posXObject = [departamentDictionary valueForKeyPath:@"pos_x"];
    flat.posX = ([posXObject isKindOfClass:[NSString class]])? posXObject: ((NSNumber*)posXObject).stringValue;
    id posYObject = [departamentDictionary valueForKeyPath:@"pos_y"];
    flat.posY = ([posYObject isKindOfClass:[NSString class]])? posYObject: ((NSNumber*)posYObject).stringValue;

    
    id priceObject = [departamentDictionary valueForKeyPath:@"price"];
    flat.price = ([priceObject isKindOfClass:[NSString class]])? priceObject:((NSNumber*)priceObject).stringValue;
    
    id statusObject = [departamentDictionary valueForKey:@"state"];
    flat.status = ([statusObject isKindOfClass:[NSNumber class]]) ? ((NSNumber*)statusObject).stringValue : nil;
    
    id featuresObject = [departamentDictionary valueForKeyPath:@"features"];
    NSArray *featuresArray = ([featuresObject isKindOfClass:[NSArray class]])? featuresObject : nil;
    for(NSString* feature in featuresArray)
    {
        FlatFeature* flatFeature = [FlatFeature MR_createEntityInContext:context];
        flatFeature.featureDescription = feature;
        [flat addFeaturesObject:flatFeature];
    }

}

+ (void)floorDictionary:(NSDictionary *)floorDictionary toFloorEntity:(Floor *)floor andFloorNumber:(int)number
{
    id uidObject = [floorDictionary valueForKeyPath:@"id"];
    floor.uid = ([uidObject isKindOfClass:[NSString class]])? uidObject: ((NSNumber*)uidObject).stringValue;
    floor.number = [NSNumber numberWithInt:number];
    
    id nameObject = [floorDictionary valueForKeyPath:@"name"];
    floor.name = ([nameObject isKindOfClass:[NSString class]])? nameObject: nil;
    
    id imageObject = [floorDictionary valueForKeyPath:@"image"];
    floor.image = ([imageObject isKindOfClass:[NSString class]])? imageObject: nil;
    
    NSString* imageWidthObject = [floorDictionary valueForKeyPath:@"image_width"];
    floor.imageWidth = [NSNumber numberWithFloat:imageWidthObject.floatValue];
    
    NSString* imageHeightObject = [floorDictionary valueForKeyPath:@"image_height"];
    floor.imageHeight = [NSNumber numberWithFloat:imageHeightObject.floatValue];
    
    id proyectidObject = [floorDictionary valueForKeyPath:@"project_id"];
    floor.proyectID = ([uidObject isKindOfClass:[NSString class]])? proyectidObject: ((NSNumber*)proyectidObject).stringValue;
}

+(void)promoDictionary:(NSDictionary *)promoDictionary toPromoEntity:(Promo *)promo context:(NSManagedObjectContext *)context
{
    id uidObject = [promoDictionary valueForKeyPath:@"id"];
    promo.uid = ([uidObject isKindOfClass:[NSString class]])? uidObject: ((NSNumber*)uidObject).stringValue;
    
    id nameObject = [promoDictionary valueForKeyPath:@"name"];
    promo.name = ([nameObject isKindOfClass:[NSString class]])? nameObject: nil;
    
    id descObject = [promoDictionary valueForKeyPath:@"description"];
    promo.promoDescription = ([descObject isKindOfClass:[NSString class]])? descObject: nil;
    
    NSNumber* timeObject = [promoDictionary valueForKeyPath:@"wait_time"];
    promo.time = timeObject;
    
    NSNumber* discpuntValObject = [promoDictionary valueForKeyPath:@"discount_rate"];
    promo.discountValue = discpuntValObject;
    
    NSString* discountWidthObject = [promoDictionary valueForKeyPath:@"discount_rate"];
    promo.discount = ([discountWidthObject isKindOfClass:[NSString class]])? discountWidthObject: nil;
}

+(void)quoteDictionary:(NSDictionary *)quoteDictionary toQuoteEntity:(Quote *)quote context:(NSManagedObjectContext *)context
{
    id uidObject = [quoteDictionary valueForKeyPath:@"id"];
    quote.uid = ([uidObject isKindOfClass:[NSString class]])? uidObject: ((NSNumber*)uidObject).stringValue;
    
    id clientObject = [quoteDictionary valueForKeyPath:@"client_id"];
    quote.clientID = ([clientObject isKindOfClass:[NSString class]])? clientObject: ((NSNumber*)clientObject).stringValue;
    
    id flatObject = [quoteDictionary valueForKeyPath:@"department_id"];
    quote.flatID = ([flatObject isKindOfClass:[NSString class]])? flatObject: ((NSNumber*)flatObject).stringValue;
    
    id interestObject = [quoteDictionary valueForKeyPath:@"interest"];
    NSNumber* interest = ([interestObject isKindOfClass:[NSNumber class]])? interestObject: nil;
    if(interest.integerValue<=0)
        interest = @1;
    quote.interestLevel = interest;
    
    Customer* customer = [Customer MR_findByAttribute:@"uid" withValue:quote.clientID inContext:context].firstObject;
    [customer addQuotesObject:quote];
    
    //Flat* flat = [Flat MR_findByAttribute:@"uid" withValue:quote.flatID inContext:context].firstObject;
    //quote.flat = flat ;
    
    id promoIdObject = [quoteDictionary valueForKeyPath:@"promotion_id"];
    NSString* promoID = ([promoIdObject isKindOfClass:[NSString class]])? promoIdObject: ((NSNumber*)promoIdObject).stringValue;
    quote.promoID = promoID;
    //Promo* promo = [Promo MR_findByAttribute:@"uid" withValue:promoID inContext:context].firstObject;
    
    //quote.promo = promo;
}

@end
