//
//  AppDelegate.m
//  LARGruop
//
//  Created by piero.sifuentes on 7/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import "AppDelegate.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Entities.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupApp];
    [self firstRunApp];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

-(void)firstRunApp
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (![defaults objectForKey:@"firstRun"])
    {
        
        [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
            
            Outside* testOutside1 = [Outside MR_createEntityInContext:localContext];
            testOutside1.imageURL = @"http://www.duplo.com.pe/images/multimedia_foto_01_c.jpg";
            testOutside1.outsideDescription = @"Una descripcion";
            
            Outside* testOutside2 = [Outside MR_createEntityInContext:localContext];
            testOutside2.imageURL = @"http://www.duplo.com.pe/images/multimedia_foto_01_d.jpg";
            testOutside2.outsideDescription = @"Otra descripcion";
            
            Outside* testOutside3 = [Outside MR_createEntityInContext:localContext];
            testOutside3.imageURL = @"http://www.duplo.com.pe/images/multimedia_foto_01_e.jpg";
            testOutside3.outsideDescription = @"Otra descripcion mas";
            
            
            Outside* testOutside4 = [Outside MR_createEntityInContext:localContext];
            testOutside4.imageURL = @"http://www.duplo.com.pe/images/multimedia_foto_01_f.jpg";
            testOutside4.outsideDescription = @"Nueva descripcion";
            
            Outside* testOutside5 = [Outside MR_createEntityInContext:localContext];
            testOutside5.imageURL = @"http://www.duplo.com.pe/images/multimedia_foto_01_g.jpg";
            testOutside5.outsideDescription = @"Nueva descripcion 2";
            
            Outside* testOutside6 = [Outside MR_createEntityInContext:localContext];
            testOutside6.imageURL = @"http://www.duplo.com.pe/images/multimedia_foto_01_h.jpg";
            testOutside6.outsideDescription = @"Una descripcion alterna";
            
            Outside* testOutside7 = [Outside MR_createEntityInContext:localContext];
            testOutside7.imageURL = @"http://www.duplo.com.pe/images/multimedia_foto_01_c.jpg";
            testOutside7.outsideDescription = @"Otra descripcion alterna";
            
            Outside* testOutside8 = [Outside MR_createEntityInContext:localContext];
            testOutside8.imageURL = @"http://www.duplo.com.pe/images/multimedia_foto_01_g.jpg";
            testOutside8.outsideDescription = @"Algo mas";
            
            ProyectFeature* testFeature1 = [ProyectFeature MR_createEntityInContext:localContext];
            testFeature1.featureDescription = @"Área de juegos infantiles (techado y al aire libre).";
            ProyectFeature* testFeature2 = [ProyectFeature MR_createEntityInContext:localContext];
            testFeature2.featureDescription = @"Gimnasio al aire libre";
            ProyectFeature* testFeature3 = [ProyectFeature MR_createEntityInContext:localContext];
            testFeature3.featureDescription = @"2 terrazas panorámicas";
            ProyectFeature* testFeature4 = [ProyectFeature MR_createEntityInContext:localContext];
            testFeature4.featureDescription = @"Asadores familiares.";
            ProyectFeature* testFeature5 = [ProyectFeature MR_createEntityInContext:localContext];
            testFeature5.featureDescription= @"2 Piscinas.";
            ProyectFeature* testFeature6 = [ProyectFeature MR_createEntityInContext:localContext];
            testFeature6.featureDescription = @"Áreas verdes.";
            ProyectFeature* testFeature7 = [ProyectFeature MR_createEntityInContext:localContext];
            testFeature7.featureDescription =@"Baños de servicio para empleados.";
            ProyectFeature* testFeature8 = [ProyectFeature MR_createEntityInContext:localContext];
            testFeature8.featureDescription=@"Lavandería.";
            
            
            Proyect* testProyect = [Proyect MR_createEntityInContext:localContext];
            testProyect.uid = @"12345";
            testProyect.address = @"Avenida Brasil 840";
            testProyect.district = @"Jesus Maria";
            testProyect.imageURL = @"http://www.duplo.com.pe/images/multimedia_foto_01_a.jpg";
            testProyect.leftDepartaments=@3;
            testProyect.listImageURL = @"http://www.duplo.com.pe/images/multimedia_foto_01_d.jpg";
            testProyect.mapDescription = @"El proyecto cuenta con departamentos de 1, 2 y 3 dormitorios disenados para satisfacer las necesidades de nuestros clientes";
            testProyect.mapImageURL = @"http://www.duplo.com.pe/images/multimedia_foto_01.jpg";
            testProyect.maxPrice = @"150000";
            testProyect.minPrice = @"100000";
            testProyect.name = @"Duplo";
            testProyect.proyectDescription = @"Ahora tu espacio interior te impulsa a crecer. Duplo esta ubicado en la avenida Brasil, un espacio privilegiado, cerca de los principales centros culturales, de esparcimiento y comercio de Lima";
            testProyect.longitude = @-77.0195246;
            testProyect.latitud = @-12.1016933;
            [testProyect addFeaturesObject:testFeature1];
            [testProyect addFeaturesObject:testFeature3];
            [testProyect addFeaturesObject:testFeature4];
            [testProyect addFeaturesObject:testFeature6];
            [testProyect addFeaturesObject:testFeature7];
            
            [testProyect addOutsideImagesObject:testOutside1];
            [testProyect addOutsideImagesObject:testOutside2];
            [testProyect addOutsideImagesObject:testOutside3];
            
            Plant* testPlant1 = [Plant MR_createEntityInContext:localContext];
            testPlant1.name = @"Planta Tipica 1";
            testPlant1.plainURL = @"https://github.com";
            testPlant1.proyect = testProyect;
            
            Flat* testFlat1 = [Flat MR_createEntityInContext:localContext];
            testFlat1.name = @"Modelo 01";
            testFlat1.size = @"75m2";
            testFlat1.status = @"disponible";
            testFlat1.flatImageURL = @"http://images6.postadsuk.com/2015/04/30/postadsuk.com-1-femaie-london-house-flat-share-3-double-size-room-at-single-price-mint-pie.JPG";
            testFlat1.plant = testPlant1;
            
            Floor* testFloor1 = [Floor MR_createEntityInContext:localContext];
            testFloor1.number = @1;
            testFloor1.name =@"Piso 01";
            testFloor1.flat = testFlat1;
            
            Floor* testFloor2 = [Floor MR_createEntityInContext:localContext];
            testFloor2.number = @5;
            testFloor2.name =@"Piso 05";
            testFloor2.flat = testFlat1;
            
            Floor* testFloor3 = [Floor MR_createEntityInContext:localContext];
            testFloor3.number = @6;
            testFloor3.name =@"Piso 06";
            testFloor3.flat = testFlat1;
            
            Plant* testPlant2 = [Plant MR_createEntityInContext:localContext];
            testPlant2.name = @"Planta Tipica 2";
            testPlant2.plainURL = @"https://bitbucket.org";
            testPlant2.proyect = testProyect;
            
            Flat* testFlat2 = [Flat MR_createEntityInContext:localContext];
            testFlat2.name = @"Modelo 02";
            testFlat2.size = @"90m2";
            testFlat2.status = @"disponible";
            testFlat2.flatImageURL = @"http://images6.postadsuk.com/2015/04/30/postadsuk.com-1-femaie-london-house-flat-share-3-double-size-room-at-single-price-mint-pie.JPG";
            testFlat2.plant = testPlant2;
            
            Floor* testFloor4 = [Floor MR_createEntityInContext:localContext];
            testFloor4.number = @15;
            testFloor4.name =@"Piso 14";
            testFloor4.flat = testFlat2;
            
            Floor* testFloor5 = [Floor MR_createEntityInContext:localContext];
            testFloor5.number = @15;
            testFloor5.name =@"Piso 15";
            testFloor5.flat = testFlat2;
            
            Plant* testPlant3 = [Plant MR_createEntityInContext:localContext];
            testPlant3.name = @"Planta Tipica 3";
            testPlant3.plainURL = @"https://www.google.com.pe";
            testPlant3.proyect = testProyect;
            
            Flat* testFlat3 = [Flat MR_createEntityInContext:localContext];
            testFlat3.name = @"Modelo 03";
            testFlat3.size = @"90m2";
            testFlat3.status = @"disponible";
            testFlat3.flatImageURL = @"http://images6.postadsuk.com/2015/04/30/postadsuk.com-1-femaie-london-house-flat-share-3-double-size-room-at-single-price-mint-pie.JPG";
            testFlat3.plant = testPlant3;
            
            Floor* testFloor6 = [Floor MR_createEntityInContext:localContext];
            testFloor6.number = @21;
            testFloor6.name =@"Piso 21";
            testFloor6.flat = testFlat3;
            
            Floor* testFloor7 = [Floor MR_createEntityInContext:localContext];
            testFloor7.number = @20;
            testFloor7.name =@"Piso 20";
            testFloor7.flat = testFlat3;
            
            Floor* testFloor8 = [Floor MR_createEntityInContext:localContext];
            testFloor8.number = @24;
            testFloor8.name =@"Piso 24";
            testFloor8.flat = testFlat3;
            
            Plant* testPlant4 = [Plant MR_createEntityInContext:localContext];
            testPlant4.name = @"Planta Tipica 4";
            testPlant4.plainURL = @"http://www.apple.com";
            testPlant4.proyect = testProyect;
            
            Flat* testFlat4 = [Flat MR_createEntityInContext:localContext];
            testFlat4.name = @"Modelo 02";
            testFlat4.size = @"90m2";
            testFlat4.status = @"disponible";
            testFlat4.flatImageURL = @"http://images6.postadsuk.com/2015/04/30/postadsuk.com-1-femaie-london-house-flat-share-3-double-size-room-at-single-price-mint-pie.JPG";
            testFlat4.plant = testPlant4;
            
            Floor* testFloor9 = [Floor MR_createEntityInContext:localContext];
            testFloor9.number = @30;
            testFloor9.name =@"Piso 30";
            testFloor9.flat = testFlat4;

            
            Proyect* testProyect2 = [Proyect MR_createEntityInContext:localContext];
            testProyect2.uid = @"23456";
            testProyect2.address = @"Avenida Salaverry 475";
            testProyect2.district = @"San Isidro";
            testProyect2.imageURL = @"http://www.nesta.com.pe/images/departamentos/departamento-fachada-zoom.jpg";
            testProyect2.leftDepartaments=@0;
            testProyect2.listImageURL = @"http://www.duplo.com.pe/images/multimedia_foto_01_g.jpg";
            testProyect2.mapDescription = @"El proyecto cuenta con departamentos de 1, 2 y 3, ademas de habitaciones con jacuzi y sauna";
            testProyect2.mapImageURL = @"http://www.nesta.com.pe/images/departamentos/departamento-fachada.jpg";
            testProyect2.maxPrice = @"165000";
            testProyect2.minPrice = @"40000";
            testProyect2.name = @"Nesta";
            testProyect2.proyectDescription = @"Todo lo que quieres en un departamento, mas las comodidad de tener el real plaza salaverry a un par de cuadras de tu casa, eso y mas aqui";
            testProyect2.longitude = @-77.0199669;
            testProyect2.latitud =@-12.116381;
            
            [testProyect2 addFeaturesObject:testFeature1];
            [testProyect2 addFeaturesObject:testFeature2];
            [testProyect2 addFeaturesObject:testFeature4];
            [testProyect2 addFeaturesObject:testFeature6];
            [testProyect2 addFeaturesObject:testFeature8];
            
            [testProyect2 addOutsideImagesObject:testOutside4];
            [testProyect2 addOutsideImagesObject:testOutside5];
            
            Proyect* testProyect3 = [Proyect MR_createEntityInContext:localContext];
            testProyect3.uid = @"34567";
            testProyect3.address = @"Avenida Sanchez Cerro 365";
            testProyect3.district = @"Jesus Maria";
            testProyect3.imageURL = @"http://www.duplo.com.pe/images/multimedia_foto_01_b.jpg";
            testProyect3.leftDepartaments=@8;
            testProyect3.listImageURL = @"http://www.duplo.com.pe/images/multimedia_foto_01_h.jpg";
            testProyect3.mapDescription = @"El proyecto cuenta con departamentos de 1, 2 y 3 dormitorios creados con marmol y cal";
            testProyect3.mapImageURL = @"http://www.duplo.com.pe/images/multimedia_foto_02.jpg";
            testProyect3.maxPrice = @"190000";
            testProyect3.minPrice = @"70000";
            testProyect3.name = @"Velia";
            testProyect3.proyectDescription = @"Ahora intentamos parafrasear otra descripcion bonita para que puedas comprar este departamento y lleves a tu familia al siguiente nivel de confort";
            testProyect3.longitude = @-76.9630458;
            testProyect3.latitud = @-12.1041621;
            
            [testProyect3 addFeaturesObject:testFeature1];
            [testProyect3 addFeaturesObject:testFeature5];
            [testProyect3 addFeaturesObject:testFeature6];
            [testProyect3 addFeaturesObject:testFeature7];
            [testProyect3 addFeaturesObject:testFeature8];
        
            [testProyect3 addOutsideImagesObject:testOutside6];
            [testProyect3 addOutsideImagesObject:testOutside7];
            [testProyect3 addOutsideImagesObject:testOutside8];
            
            MarketRates* testRate1 = [MarketRates MR_createEntityInContext:localContext];
            testRate1.interestLevel = @3;
            testRate1.name = @"Cotizacion 1";
            testRate1.marketRateID = @"XASD31";
            testRate1.proyect = testProyect;
            
            MarketRates* testRate2 = [MarketRates MR_createEntityInContext:localContext];
            testRate2.interestLevel = @2;
            testRate2.name = @"Cotizacion 2";
            testRate2.marketRateID = @"XASD12";
            testRate2.proyect = testProyect2;
            
            MarketRates* testRate3 = [MarketRates MR_createEntityInContext:localContext];
            testRate3.interestLevel = @1;
            testRate3.name = @"Cotizacion 3";
            testRate3.marketRateID = @"XASD77";
            testRate3.proyect = testProyect3;
            
            MarketRates* testRate4 = [MarketRates MR_createEntityInContext:localContext];
            testRate4.interestLevel = @2;
            testRate4.name = @"Cotizacion 1";
            testRate4.marketRateID = @"XASD00";
            testRate4.proyect = testProyect;
            
            Customer *testCust1 =[Customer MR_createEntityInContext:localContext];
            testCust1.firstName = @"Jose";
            testCust1.lastName = @"Perez";
            testCust1.email = @"user@testCust1.com";
            testCust1.interestLevel = @3;
            testRate1.customer = testCust1;
            testRate2.customer = testCust1;
            testRate4.customer = testCust1;
            
            Customer *testCust2 =[Customer MR_createEntityInContext:localContext];
            testCust2.firstName = @"Sofia";
            testCust2.lastName = @"Vergara";
            testCust2.email = @"user@testCust2.com";
            testCust2.interestLevel = @1;
            
            Customer *testCust3 =[Customer MR_createEntityInContext:localContext];
            testCust3.firstName = @"Fredy";
            testCust3.lastName = @"Juarez";
            testCust3.email = @"user@testCust3.com";
            testCust3.interestLevel = @3;
            
            Customer *testCust4 =[Customer MR_createEntityInContext:localContext];
            testCust4.firstName = @"Laura";
            testCust4.lastName = @"Paez";
            testCust4.email = @"user@testCust4.com";
            testCust4.interestLevel = @1;
            
            Customer *testCust5 =[Customer MR_createEntityInContext:localContext];
            testCust5.firstName = @"Rosa";
            testCust5.lastName = @"Orto";
            testCust5.email = @"user@testCust5.com";
            testCust5.interestLevel = @2;
            
            Customer *testCust6 =[Customer MR_createEntityInContext:localContext];
            testCust6.firstName = @"Ana";
            testCust6.lastName = @"Solano";
            testCust6.email = @"user@testCust6.com";
            testCust6.interestLevel = @3;
            
            Customer *testCust7 =[Customer MR_createEntityInContext:localContext];
            testCust7.firstName = @"Miguel";
            testCust7.lastName = @"Vionee";
            testCust7.email = @"user@testCust7.com";
            testCust7.interestLevel = @1;
            
            Customer *testCust8 =[Customer MR_createEntityInContext:localContext];
            testCust8.firstName = @"Lucas";
            testCust8.lastName = @"Volucas";
            testCust8.email = @"user@testCust8.com";
            testCust8.interestLevel = @1;
            
            Customer *testCust9 =[Customer MR_createEntityInContext:localContext];
            testCust9.firstName = @"Andre";
            testCust9.lastName = @"Torres";
            testCust9.email = @"user@testCust9.com";
            testCust9.interestLevel = @3;
            
            Customer *testCust10 =[Customer MR_createEntityInContext:localContext];
            testCust10.firstName = @"Cristiano";
            testCust10.lastName = @"Ronaldo";
            testCust10.email = @"user@testCust10.com";
            testCust10.interestLevel = @2;
            testRate3.customer = testCust10;
            
            Customer *testCust11 =[Customer MR_createEntityInContext:localContext];
            testCust11.firstName = @"Andre";
            testCust11.lastName = @"Cevillano";
            testCust11.email = @"user@testCust11.com";
            testCust11.interestLevel = @2;
            
            Customer *testCust12 =[Customer MR_createEntityInContext:localContext];
            testCust12.firstName = @"Carmen";
            testCust12.lastName = @"Electra";
            testCust12.email = @"user@testCust12.com";
            testCust12.interestLevel = @2;
            
        } completion:nil];
        [defaults setObject:[NSDate date] forKey:@"firstRun"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)setupApp
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self MR_SetupDatabase];
    //[[GenericService sharedService] MR_SetupDatabase];
    //[[AFNetworkReachabilityManager sharedManager] startMonitoring];
    //AFNetworkActivityIndicatorManager.sharedManager.enabled = YES;
    
    // Preloads keyboard so there's no lag on initial keyboard appearance.
    UITextField *lagFreeField = [[UITextField alloc] init];
    [self.window addSubview:lagFreeField];
    [lagFreeField becomeFirstResponder];
    [lagFreeField resignFirstResponder];
    [lagFreeField removeFromSuperview];
}

- (void)registerDefaultsFromSettingsBundle {
    // this function writes default settings as settings
    NSString *settingsBundle = [[NSBundle mainBundle] pathForResource:@"Settings" ofType:@"bundle"];
    if(!settingsBundle) {
        NSLog(@"Could not find Settings.bundle");
        return;
    }
    
    NSDictionary *settings = [NSDictionary dictionaryWithContentsOfFile:[settingsBundle stringByAppendingPathComponent:@"Root.plist"]];
    NSArray *preferences = [settings objectForKey:@"PreferenceSpecifiers"];
    
    NSMutableDictionary *defaultsToRegister = [[NSMutableDictionary alloc] initWithCapacity:[preferences count]];
    for(NSDictionary *prefSpecification in preferences) {
        NSString *key = [prefSpecification objectForKey:@"Key"];
        if(key) {
            [defaultsToRegister setObject:[prefSpecification objectForKey:@"DefaultValue"] forKey:key];
            NSLog(@"writing as default %@ to the key %@",[prefSpecification objectForKey:@"DefaultValue"],key);
        }
    }
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultsToRegister];
    
}

- (void)MR_SetupDatabase
{
    [MagicalRecord setShouldDeleteStoreOnModelMismatch:YES];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"LARGruop"];
    
    if ([[[NSPersistentStoreCoordinator MR_defaultStoreCoordinator] persistentStores] count] == 0){
        [MagicalRecord cleanUp];
        NSError *error;
        NSURL *fileURL = [NSPersistentStore MR_urlForStoreName:@"LARGruop"];
        [[NSFileManager defaultManager] removeItemAtURL:fileURL error:&error];
        [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"LARGruop"];
        [MagicalRecord setupCoreDataStackWithStoreNamed:@"LARGruop"];
    }
}

#pragma mark -
#pragma mark - Core Data stack
#pragma mark - 

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "prsp.LARGruop" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"LARGruop" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LARGruop.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark -
#pragma mark - Core Data Saving support
#pragma mark -

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
