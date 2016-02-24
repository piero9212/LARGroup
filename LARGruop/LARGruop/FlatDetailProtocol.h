//
//  FlatDetailProtocol.h
//  LARGruop
//
//  Created by piero.sifuentes on 24/02/16.
//  Copyright © 2016 prsp.org. All rights reserved.
//

#ifndef FlatDetailProtocol_h
#define FlatDetailProtocol_h
#import "Flat.h"

@protocol FlatDetailProtocol <NSObject>

- (void)presentFlatModalDetailWithFlat:(Flat*)flat;
@end
#endif /* FlatDetailProtocol_h */
