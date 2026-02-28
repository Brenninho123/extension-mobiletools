package mobile;

#if android
import lime.system.JNI;
#end

#if ios
@:cppFileCode('#import <UIKit/UIKit.h>')
#end

class MobileTools
{
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
     * Abrir URL no navegador
     */
    public static function openURL(url:String):Void
    {
        #if android
        _androidOpenURL(url);
        #elseif ios
        lime.system.System.openURL(url);
        #else
        lime.system.System.openURL(url);
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
    #end

    // =========================
    // IOS NATIVE
    // =========================

    #if ios
    @:functionCode('
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    ')
    private static function _iosVibrate():Void {}
    #end
}
