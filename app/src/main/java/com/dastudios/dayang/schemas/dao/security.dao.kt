package com.dastudios.dayang.schemas.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.dastudios.dayang.schemas.Security

@Dao
interface SecurityDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(security: Security): Long

    @Query("SELECT * FROM Security WHERE accountId = :accountId")
    suspend fun getByAccountId(accountId: Int): Security?
}
