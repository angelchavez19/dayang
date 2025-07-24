package com.dastudios.dayang.schemas

import androidx.room.Embedded
import androidx.room.Entity
import androidx.room.Junction
import androidx.room.Relation

@Entity(primaryKeys = ["transactionId", "tagId"])
data class TransactionTagCrossRef(
    val transactionId: Int,
    val tagId: Int
)

data class TransactionWithTags(
    @Embedded val transaction: Transaction,
    @Relation(
        parentColumn = "id",
        entityColumn = "id",
        associateBy = Junction(
            value = TransactionTagCrossRef::class,
            parentColumn = "transactionId",
            entityColumn = "tagId"
        )
    )
    val tags: List<Tag>
)
