package app.kyushu.muusic.screens.search.viewModel

import androidx.compose.runtime.mutableStateOf
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import app.kyushu.muusic.data.remote.muusicBackend.responses.SearchResults
import app.kyushu.muusic.repository.muusicBackendRepo.MuusicBackendRepository
import app.kyushu.muusic.util.Resource
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class SearchViewModel @Inject constructor(
    private val repository: MuusicBackendRepository
) : ViewModel() {
    var searchQuery: String = ""
    var searchResults = mutableStateOf<SearchResults?>(null)

    fun search() {
        viewModelScope.launch {
            repository.getSearchResults(searchQuery).let { result ->
                if (searchQuery == "") {
                    searchResults.value = null
                    return@let
                }
                if (result is Resource.Success) {
                    searchResults.value = result.data
                }
            }
        }
    }
}