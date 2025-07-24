package com.dastudios.dayang.schemas.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Transaction
import com.dastudios.dayang.schemas.TransactionTagCrossRef
import com.dastudios.dayang.schemas.TransactionWithTags

@Dao
interface TransactionWithTagsDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertCrossRef(ref: TransactionTagCrossRef)

    @Transaction
    @Query("SELECT * FROM `Transaction` WHERE id = :transactionId")
    suspend fun getTransactionWithTags(transactionId: Int): TransactionWithTags

}
