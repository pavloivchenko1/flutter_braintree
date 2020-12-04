#import "BraintreeModulePlugin.h"
#import <braintree_module/braintree_module-Swift.h>

@implementation BraintreeModulePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBraintreeModulePlugin registerWithRegistrar:registrar];
}
@end
