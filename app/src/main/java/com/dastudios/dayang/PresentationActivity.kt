package com.dastudios.dayang

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.dastudios.dayang.databinding.ActivityPresentationBinding

class PresentationActivity : AppCompatActivity() {
    private lateinit var binding: ActivityPresentationBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        binding = ActivityPresentationBinding.inflate(layoutInflater)

        setContentView(binding.root)

        binding.btnGetStarted.setOnClickListener {
            startActivity(Intent(this, MainActivity::class.java))
        }
    }
}