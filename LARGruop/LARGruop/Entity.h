//
//  Entity.h
//  LARGruop
//
//  Created by piero.sifuentes on 11/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Entity : NSManagedObject

@property (nonatomic, retain) NSNumber * changeState;
@property (nonatomic, retain) NSDate * lastModified;
@property (nonatomic, retain) NSString * uid;

@end
