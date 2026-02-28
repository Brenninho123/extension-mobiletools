package com.mobiletools;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Vibrator;
import android.os.VibrationEffect;
import android.widget.Toast;

import org.haxe.lime.GameActivity;

public class MobileTools
{
    private static Activity getActivity()
    {
        return GameActivity.getInstance();
    }

    // =========================
    // VIBRATE
    // =========================
    public static void vibrate(int milliseconds)
    {
        Activity activity = getActivity();
        Vibrator vibrator = (Vibrator) activity.getSystemService(Context.VIBRATOR_SERVICE);

        if (vibrator != null)
        {
            if (android.os.Build.VERSION.SDK_INT >= 26)
            {
                vibrator.vibrate(VibrationEffect.createOneShot(milliseconds, VibrationEffect.DEFAULT_AMPLITUDE));
            }
            else
            {
                vibrator.vibrate(milliseconds);
            }
        }
    }

    // =========================
    // OPEN URL
    // =========================
    public static void openURL(String url)
    {
        Activity activity = getActivity();
        Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
        activity.startActivity(intent);
    }

    // =========================
    // TOAST (EXTRA)
    // =========================
    public static void showToast(String message)
    {
        Activity activity = getActivity();
        activity.runOnUiThread(() ->
            Toast.makeText(activity, message, Toast.LENGTH_SHORT).show()
        );
    }
}
