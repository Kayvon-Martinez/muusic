package app.kyushu.muusic

import android.app.Application
import dagger.hilt.android.HiltAndroidApp
import timber.log.Timber

@HiltAndroidApp
class MuusicApplication : Application() {
    @Override
    override fun onCreate() {
        super.onCreate()
        Timber.plant(Timber.DebugTree())
    }
}