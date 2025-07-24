package com.dastudios.dayang.schemas.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.dastudios.dayang.schemas.Preferences

@Dao
interface PreferencesDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(pref: Preferences): Long

    @Query("SELECT * FROM Preferences WHERE accountId = :accountId")
    suspend fun getByAccountId(accountId: Int): Preferences?
}
