package app.kyushu.muusic.di

import app.kyushu.muusic.data.remote.muusicBackend.MuusicBackendApi
import app.kyushu.muusic.repository.muusicBackendRepo.MuusicBackendRepository
import app.kyushu.muusic.repository.muusicBackendRepo.MuusicBackendRepositoryImpl
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import retrofit2.Retrofit
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object AppModule {
    @Singleton
    @Provides
    fun provideMuusicBackendRepository(
        muusicBackendApi: MuusicBackendApi
    ) = MuusicBackendRepositoryImpl(muusicBackendApi)

    @Singleton
    @Provides
    fun provideMuusicBackendApi(): MuusicBackendApi {
        return Retrofit.Builder()
            .baseUrl("http://192.168.1.157/api/v1/")
            .build()
            .create(MuusicBackendApi::class.java)
    }
}