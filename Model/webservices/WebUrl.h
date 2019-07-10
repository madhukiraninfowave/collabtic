//
//  WebUrl.h
//  Ahyush
//
//  Created by Jiyas on 29/11/17.
//  Copyright © 2017 mobile. All rights reserved.
//RiskUploadAPI


#define WebUrl_h



//Dev
//#define Header @"https://dev.awlm.ahyush.com"
//#define HeaderImage @"https://dev.awlm.ahyush.com"
//#define HeaderPath @"https://dev.awlm.ahyush.com/ahyush-services/"

//QA
//#define Header @"https://qa.awlm.ahyush.com:8443"
//#define HeaderImage @"https://qa.awlm.ahyush.com"
//#define HeaderPath @"https://qa.awlm.ahyush.com:8443/ahyush-services/"

//Live
//#define Header @"https://awlm.ahyush.com"
//#define HeaderImage @"https://awlm.ahyush.com"
 #define HeaderPath @"http://mobile-devapi.collabtic.com/"
//
//Splash Screen
#define Splash  (HeaderPath @"accounts/appsplashSlideshow?api_key=dG9wZml4MTIz")
#define loginvalidemail  (HeaderPath @"/accounts/Loginapi")
#define Login  (HeaderPath @"/accounts/login?")
#define signupValiedEmail (HeaderPath @"/accounts/checkvaliduser?")
#define forgotPassword (HeaderPath @"/accounts/resetpassword/accounts/resetpassword?")
#define uploadImage (HeaderPath @"/accounts/profilephoto?")
#define termscondition (HeaderPath @"/accounts/termsandconditions")
#define privacypolicy (HeaderPath @"/accounts/privacypolicy")

//threads page
#define Threads  (HeaderPath @"search/threadwithfilter?")



