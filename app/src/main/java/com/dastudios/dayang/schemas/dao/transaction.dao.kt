package com.dastudios.dayang.schemas.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.dastudios.dayang.schemas.Transaction

@Dao
interface TransactionDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(transaction: Transaction): Long

    @Query("SELECT * FROM `Transaction` WHERE accountId = :accountId")
    suspend fun getByAccountId(accountId: Int): List<Transaction>

    @Query("SELECT * FROM `Transaction` WHERE id = :id")
    suspend fun getById(id: Int): Transaction?
}
