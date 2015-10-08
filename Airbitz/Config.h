//
//  Config.h
//  AirBitz
//
//  Compile-time configurations.  Should all be zero for deployment

#ifndef AirBitz_Config_h
#define AirBitz_Config_h

#define AUTH_TOKEN                      @"bae1c3d6e3dc3357b71ad998151b985d93b6ab56"
//android token? b24805c59bf8ded704c659de3aa1be966f3065bc

#define HOCKEY_MANAGER_ID               @"d7ae6b60c6725fbb3cb4cf1e5362f1a0"

#define PRIVATE_KEY                     @"5Kb8kLf9zgWQnogidDA76MzPL6TsZZY36hWXMssSzNydYXYB9KF"
#define PUBLIC_ADDRESS                  @"1CC3X2gu58d6wXUWMffpuzN9JAfTUWu4Kj"

/* These should be 0 for deployment */
#define AIRBITZ_IOS_DEBUG               0   /* set to 1 while debugging */
#define DIRECTORY_ONLY                  0   /* set to 0 for wallet and directory, set to 1 for just directory */
#define HARD_CODED_LOGIN                0   /* set to 1 to auto login with credientials below (used for testing) */

#define HARD_CODED_LOGIN_NAME           @""
#define HARD_CODED_LOGIN_PASSWORD       @""

#define GLIDERA_API_KEY                 @"39b3bbae7152eb06"
#define GLIDERA_API_SANDBOX_KEY         @"ad75fb75b8877f30"

#endif
