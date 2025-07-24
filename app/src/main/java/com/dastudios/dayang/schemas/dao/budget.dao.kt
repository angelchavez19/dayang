package com.dastudios.dayang.schemas.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import com.dastudios.dayang.schemas.Budget

@Dao
interface BudgetDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insert(budget: Budget): Long

    @Query("SELECT * FROM Budget WHERE accountId = :accountId")
    suspend fun getByAccountId(accountId: Int): List<Budget>
}
