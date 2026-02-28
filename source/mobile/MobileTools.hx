package mobile;

import lime.system.System;

#if android
import lime.system.JNI;
#end

#if ios
@:cppFileCode('#include "MobileTools.mm"')
#end

class MobileTools
{
    // =========================
    // PUBLIC API
    // =========================

    /**
     * Vibrar o dispositivo
     */
    public static function vibrate(milliseconds:Int = 200):Void
    {
        #if android
        _androidVibrate(milliseconds);
        #elseif ios
        _iosVibrate();
        #else
        trace("Vibration not supported on this platform.");
        #end
    }

    /**
     * Abrir URL
     */
    public static function openURL(url:String):Void
    {
        #if android
        _androidOpenURL(url);
        #elseif ios
        _iosOpenURL(url);
        #else
        System.openURL(url);
        #end
    }

    /**
     * Mostrar Toast (Android only)
     */
    public static function showToast(message:String):Void
    {
        #if android
        _androidShowToast(message);
        #else
        trace("Toast only available on Android.");
        #end
    }

    // =========================
    // ANDROID JNI
    // =========================

    #if android

    private static var _androidVibrate = JNI.createStaticMethod(
        "com/mobiletools/MobileTools",
        "vibrate",
        "(I)V"
    );

    private static var _androidOpenURL = JNI.createStaticMethod(
        "com/mobiletools/MobileTools",
        "openURL",
        "(Ljava/lang/String;)V"
    );

    private static var _androidShowToast = JNI.createStaticMethod(
        "com/mobiletools/MobileTools",
        "showToast",
        "(Ljava/lang/String;)V"
    );

    #end

    // =========================
    // IOS BRIDGE
    // =========================

    #if ios

    @:native("ios_vibrate")
    private static function _iosVibrate():Void;

    @:native("ios_open_url")
    private static function _iosOpenURL(url:String):Void;

    #end
}