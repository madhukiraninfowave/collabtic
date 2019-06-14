//
//  CommonClass.h
//  Ahyush
//
//  Created by mobile on 11/10/18.
//  Copyright © 2018 mobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CommonClass : NSObject{
    
}
@property (strong, nonatomic) UIWindow *window;


+(CommonClass*)sharedMySingleton;
-( NSString *)Check_For_Null:(id)value;
-(NSString *)checkForNumber:(id)value;
-(void)animationLeft;

@end
