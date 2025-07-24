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
data class Preferences(
    @PrimaryKey(autoGenerate = true) val id: Int = 0,
    val accountId: Int,
    val lang: String?,
    val currency: String?,
    val dateFormat: String?
)