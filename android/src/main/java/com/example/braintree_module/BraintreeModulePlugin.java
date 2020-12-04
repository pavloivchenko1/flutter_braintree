package com.example.braintree_module;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.braintreepayments.api.dropin.DropInActivity;
import com.braintreepayments.api.dropin.DropInRequest;
import com.braintreepayments.api.dropin.DropInResult;
import com.braintreepayments.api.models.PaymentMethodNonce;

/** BraintreeModulePlugin */
public class BraintreeModulePlugin implements MethodCallHandler, ActivityResultListener {

  private static final int REQUEST_CODE = 0x1337;

  private Activity activity;
  private Context context;
  private Result activeResult;

  private BraintreeModulePlugin(Registrar registrar) {
    activity = registrar.activity();
    context = registrar.context();
    registrar.addActivityResultListener(this);
  }

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "braintree_module");
    channel.setMethodCallHandler(new BraintreeModulePlugin(registrar));
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    Log.w("payment", call.method);
    switch (call.method) {
      case "getPlatformVersion":
        result.success("Android " + android.os.Build.VERSION.RELEASE);
        break;
      case "init":
        initBraintree(call, result);
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  private void initBraintree(MethodCall call, Result result) {
    Log.w("payment", "Init Braintree in plugin");
    String paymentToken = call.argument("paymentToken");
    Log.w("payment", paymentToken);
    DropInRequest dropInRequest = new DropInRequest()
            .clientToken(paymentToken);
    if (activeResult != null) {
      result.error("drop_in_already_running", "Cannot launch another Drop-in activity while one is already running.", null);
      return;
    }
    this.activeResult = result;
    Log.w("payment", "Starting activity");
    activity.startActivityForResult(dropInRequest.getIntent(context), REQUEST_CODE);
  }

  @Override
  public boolean onActivityResult(int requestCode, int resultCode, Intent data)  {
    switch (requestCode) {
      case REQUEST_CODE:
        if (resultCode == Activity.RESULT_OK) {
          DropInResult dropInResult = data.getParcelableExtra(DropInResult.EXTRA_DROP_IN_RESULT);
          PaymentMethodNonce paymentMethodNonce = dropInResult.getPaymentMethodNonce();
          activeResult.success(paymentMethodNonce.getNonce());
        } else if (resultCode == Activity.RESULT_CANCELED) {
          activeResult.success(null);
        } else {
          Exception error = (Exception) data.getSerializableExtra(DropInActivity.EXTRA_ERROR);
          activeResult.error("braintree_error", error.getMessage(), null);
        }
        activeResult = null;
        return true;
      default:
        return false;
    }
  }

}
