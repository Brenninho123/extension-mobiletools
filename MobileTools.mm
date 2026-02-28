#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

extern "C"
{
    // =========================
    // VIBRATE
    // =========================
    void ios_vibrate()
    {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }

    // =========================
    // OPEN URL
    // =========================
    void ios_open_url(const char* url)
    {
        NSString* nsUrl = [NSString stringWithUTF8String:url];
        NSURL* urlObj = [NSURL URLWithString:nsUrl];

        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] openURL:urlObj options:@{} completionHandler:nil];
        });
    }
}
