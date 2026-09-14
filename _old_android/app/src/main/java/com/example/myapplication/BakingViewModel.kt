package com.example.myapplication

import android.graphics.Bitmap
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.google.firebase.Firebase
import com.google.firebase.ai.ai
import com.google.firebase.ai.type.content
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

class BakingViewModel : ViewModel() {
    private val _uiState: MutableStateFlow<UiState> =
        MutableStateFlow(UiState.Initial)
    val uiState: StateFlow<UiState> =
        _uiState.asStateFlow()

    private val generativeModel = Firebase.ai.generativeModel(
        modelName = "gemini-2.5-flash",
    )

    fun sendPrompt(bitmap: Bitmap, prompt: String) {
        viewModelScope.launch {
            _uiState.value = UiState.Loading
            try {
                val response = withContext(Dispatchers.IO) {
                    generativeModel.generateContent(
                        content {
                            image(bitmap)
                            text(prompt)
                        },
                    )
                }
                _uiState.value = response.text?.let { outputContent ->
                    UiState.Success(outputContent)
                } ?: UiState.Error("No response from model")
            } catch (e: Exception) {
                _uiState.value = UiState.Error(e.localizedMessage ?: "Unknown error occurred")
            }
        }
    }
}