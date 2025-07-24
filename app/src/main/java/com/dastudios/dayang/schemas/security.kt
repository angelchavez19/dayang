package com.dastudios.dayang.schemas

import androidx.room.Entity
import androidx.room.ForeignKey
import androidx.room.PrimaryKey

@Entity(
    foreignKeys = [ForeignKey(
        entity = Account::class,
        parentColumns = ["id"],
        childColumns = ["accountId"],
        onDelete = ForeignKey.CASCADE
    )]
)
data class Security(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val accountId: Int,
    val pin: String?,
    val biometricEnable: Boolean = false
)
