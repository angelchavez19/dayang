package com.dastudios.dayang.schemas.dao

import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query
import androidx.room.Transaction
import com.dastudios.dayang.schemas.CategoryTagCrossRef
import com.dastudios.dayang.schemas.CategoryWithTags
import com.dastudios.dayang.schemas.TagWithCategories

@Dao
interface CategoryTagDao {
    @Insert(onConflict = OnConflictStrategy.REPLACE)
    suspend fun insertCrossRef(crossRef: CategoryTagCrossRef)

    @Transaction
    @Query("SELECT * FROM Category WHERE id = :categoryId")
    suspend fun getTagsForCategory(categoryId: Int): CategoryWithTags

    @Transaction
    @Query("SELECT * FROM Tag WHERE id = :tagId")
    suspend fun getCategoriesForTag(tagId: Int): TagWithCategories
}
