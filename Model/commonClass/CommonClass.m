//
//  CommonClass.m
//  Ahyush
//
//  Created by mobile on 11/10/18.
//  Copyright © 2018 mobile. All rights reserved.
//

#import "CommonClass.h"

@implementation CommonClass
static CommonClass* _sharedGeneric = nil;


+(CommonClass*)sharedMySingleton
{
    @synchronized([CommonClass class])
    {
        if (!_sharedGeneric){
            [[self alloc] init];
        }
        return _sharedGeneric;
    }
    return nil;
}


+(id)alloc
{
    @synchronized([CommonClass class])
    {
        NSAssert(_sharedGeneric == nil, @"Attempted to allocate a second instance of a singleton.");
        _sharedGeneric = [super alloc];
        
        return _sharedGeneric;
    }
    
    return nil;
}




-( NSString *)Check_For_Null:(NSString *)value
{
    if ([value isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else
    {
        return value;
    }
}
-(NSString *)checkForNumber:(id)value{
    
    if ([value isEqual:[NSNull null]]) {
        
        return @"";
    }
    
    else if (value == nil)
        
        return @"";
    return [NSString stringWithFormat:@"%@",value];
    
}


@end
