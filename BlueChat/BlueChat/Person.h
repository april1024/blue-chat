//
//  Person.h
//  BlueChat
//
//  Created by Lee TaeHwan on 8/8/12.
//  Copyright (c) 2012 NHN Map FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject{
    NSString *id;
    NSString *name;
}

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;

@end
