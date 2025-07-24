package com.dastudios.dayang.schemas.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.dastudios.dayang.schemas.Account

@Dao
interface AccountDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(account: Account): Long

    @Query("SELECT * FROM Account")
    suspend fun getAll(): List<Account>

    @Query("SELECT * FROM Account WHERE id = :id")
    suspend fun getById(id: Int): Account?
}
