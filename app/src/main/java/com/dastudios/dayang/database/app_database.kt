package com.dastudios.dayang.database

import android.annotation.SuppressLint
import android.content.Context
import androidx.annotation.NonNull
import androidx.lifecycle.ViewModelProvider.NewInstanceFactory.Companion.instance
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import androidx.sqlite.db.SupportSQLiteDatabase
import com.dastudios.dayang.database.callback.AppDatabaseCallback
import com.dastudios.dayang.schemas.Account
import com.dastudios.dayang.schemas.Balance
import com.dastudios.dayang.schemas.Budget
import com.dastudios.dayang.schemas.Category
import com.dastudios.dayang.schemas.Preferences
import com.dastudios.dayang.schemas.Reminder
import com.dastudios.dayang.schemas.Security
import com.dastudios.dayang.schemas.Tag
import com.dastudios.dayang.schemas.Transaction
import com.dastudios.dayang.schemas.TransactionTagCrossRef
import com.dastudios.dayang.schemas.dao.AccountDao
import com.dastudios.dayang.schemas.dao.BalanceDao
import com.dastudios.dayang.schemas.dao.BudgetDao
import com.dastudios.dayang.schemas.dao.CategoryDao
import com.dastudios.dayang.schemas.dao.PreferencesDao
import com.dastudios.dayang.schemas.dao.ReminderDao
import com.dastudios.dayang.schemas.dao.SecurityDao
import com.dastudios.dayang.schemas.dao.TagDao
import com.dastudios.dayang.schemas.dao.TransactionDao
import com.dastudios.dayang.schemas.dao.TransactionWithTagsDao
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

@Database(
    entities = [
        Account::class,
        Preferences::class,
        Security::class,
        Reminder::class,
        Balance::class,
        Budget::class,
        Category::class,
        Tag::class,
        Transaction::class,
        TransactionTagCrossRef::class
    ],
    version = 1
)
abstract class AppDatabase : RoomDatabase() {
    abstract fun accountDao(): AccountDao
    abstract fun preferencesDao(): PreferencesDao
    abstract fun securityDao(): SecurityDao
    abstract fun reminderDao(): ReminderDao
    abstract fun balanceDao(): BalanceDao
    abstract fun budgetDao(): BudgetDao
    abstract fun categoryDao(): CategoryDao
    abstract fun tagDao(): TagDao
    abstract fun transactionDao(): TransactionDao
    abstract fun transactionWithTagsDao(): TransactionWithTagsDao

    companion object {
        @Volatile
        private var INSTANCE: AppDatabase? = null

        fun getInstance(context: Context, scope: CoroutineScope): AppDatabase {
            return INSTANCE ?: synchronized(this) {
                val instance = Room.databaseBuilder(
                    context,
                    AppDatabase::class.java,
                    "finance_db"
                )
                    .addCallback(object : RoomDatabase.Callback() {
                        override fun onCreate(db: SupportSQLiteDatabase) {
                            super.onCreate(db)

                            CoroutineScope(Dispatchers.IO).launch {
                                val appCallback = AppDatabaseCallback(scope)
                                appCallback.prepopulateDatabase(db as AppDatabase)
                            }
                        }
                    })
                    .build()
                INSTANCE = instance
                instance
            }
        }
    }
}
