package com.dastudios.dayang.schemas.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.dastudios.dayang.schemas.Balance

@Dao
interface BalanceDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(balance: Balance): Long

    @Query("SELECT * FROM Balance WHERE accountId = :accountId")
    suspend fun getByAccountId(accountId: Int): Balance?
}
