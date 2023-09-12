package app.kyushu.muusic.repository.muusicBackendRepo

import dagger.Binds
import dagger.Module
import dagger.hilt.InstallIn
import dagger.hilt.android.components.ViewModelComponent

@Module
@InstallIn(ViewModelComponent::class)
abstract class MuusicBackendRepositoryModule {
    @Binds
    abstract fun bindMuusicBackendRepository(
        muusicBackendRepositoryImpl: MuusicBackendRepositoryImpl
    ): MuusicBackendRepository
}