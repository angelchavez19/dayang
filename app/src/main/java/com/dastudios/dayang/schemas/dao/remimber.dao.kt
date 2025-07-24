package com.dastudios.dayang.schemas.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.dastudios.dayang.schemas.Reminder


@Dao
interface ReminderDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(reminder: Reminder): Long

    @Query("SELECT * FROM Reminder WHERE accountId = :accountId")
    suspend fun getByAccountId(accountId: Int): List<Reminder>
}
