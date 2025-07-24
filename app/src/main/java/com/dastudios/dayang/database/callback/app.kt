package com.dastudios.dayang.database.callback

import androidx.room.RoomDatabase
import androidx.sqlite.db.SupportSQLiteDatabase
import com.dastudios.dayang.database.AppDatabase
import com.dastudios.dayang.schemas.Category
import com.dastudios.dayang.schemas.Tag
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class AppDatabaseCallback(
    private val scope: CoroutineScope
) : RoomDatabase.Callback() {

    suspend fun prepopulateDatabase(db: AppDatabase) {
        val categoryDao = db.categoryDao()
        val tagDao = db.tagDao()

        val defaultCategories = listOf(
            Category(name = "Uncategorized"),
            Category(name = "Salary"),
            Category(name = "Rent"),
            Category(name = "Utilities"),
            Category(name = "Food & Groceries"),
            Category(name = "Transportation"),
            Category(name = "Entertainment"),
            Category(name = "Medical"),
            Category(name = "Savings"),
            Category(name = "Education"),
            Category(name = "Travel"),
            Category(name = "Donations"),
            Category(name = "Miscellaneous")
        )
        defaultCategories.forEach { categoryDao.insert(it) }

        val defaultTags = listOf(
            Tag(name = "Urgent"),
            Tag(name = "Work"),
            Tag(name = "Family"),
            Tag(name = "Leisure")
        )
        defaultTags.forEach { tagDao.insert(it) }
    }
}
