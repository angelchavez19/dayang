package com.dastudios.dayang.database.callback

import androidx.lifecycle.ViewModelProvider
import androidx.room.RoomDatabase
import androidx.sqlite.db.SupportSQLiteDatabase
import com.dastudios.dayang.schemas.Category
import com.dastudios.dayang.schemas.Tag
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class AppDatabaseCallback(
    private val scope: CoroutineScope
) : RoomDatabase.Callback() {

    override fun onCreate(db: SupportSQLiteDatabase) {
        super.onCreate(db)
    }

    override fun onOpen(db: SupportSQLiteDatabase) {
        super.onOpen(db)
    }

    fun populateDatabase(database: ViewModelProvider.NewInstanceFactory) {
        scope.launch {
            val categoryDao = database.categoryDao()
            val tagDao = database.tagDao()

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
}
