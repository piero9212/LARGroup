//
//  ProyectAnnotationProtocol.h
//  LARGruop
//
//  Created by piero.sifuentes on 23/09/15.
//  Copyright (c) 2015 prsp.org. All rights reserved.
//

@protocol ProyectAnnotationDelegate <NSObject>

- (void)showProyectDetailControllerWithProyecUID:(NSString*)proyectUID;

@end