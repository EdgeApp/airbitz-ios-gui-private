//
//  Plugin.m
//  AirBitz
//

#import "Plugin.h"
#import "Config.h"
#import "ABC.h"

@interface Plugin ()
@end

@implementation Plugin

static BOOL bInitialized = NO;
static NSMutableArray *plugins;

+ (void)initAll
{
    if (NO == bInitialized)
    {
        tABC_Error error;
        bool isTestnet = false;
        ABC_IsTestNet(&isTestnet, &error);

        plugins = [[NSMutableArray alloc] init];

        Plugin *plugin;
        if (isTestnet) {
            plugin = [[Plugin alloc] init];
            plugin.pluginId = @"com.glidera.us";
            plugin.provider = @"glidera";
            plugin.country = @"US";
            plugin.sourceFile = @"glidera";
            plugin.sourceExtension = @"html";
            plugin.name = @"Glidera USA";
            plugin.env = @{
                @"COUNTRY_CODE": @"US",
                @"COUNTRY_NAME": @"United States",
                @"CURRENCY_CODE": @"840",
                @"CURRENCY_ABBREV": @"USD",
                @"SANDBOX": (isTestnet ? @"true" : @"false"),
                @"GLIDERA_CLIENT_ID": GLIDERA_CLIENT_ID,
                @"GLIDERA_CLIENT_SECRET": GLIDERA_CLIENT_SECRET,
                @"REDIRECT_URI": @"airbitz://plugin/glidera/US/"
            };
            [plugins addObject:plugin];
        }
        bInitialized = YES;
    }
}

+ (void)freeAll
{
}

+ (Plugin *)getPlugins
{
    return plugins;
}

+ (NSArray *)getPlugin:(NSString *)pluginId
{
    return nil;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.pluginId = @"";
        self.name = @"";
        self.sourceFile = @"";
        self.sourceExtension = @"html";
    }
    return self;
}

- (void)dealloc 
{
}

@end
