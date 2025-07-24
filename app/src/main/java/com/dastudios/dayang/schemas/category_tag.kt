package com.dastudios.dayang.schemas

import androidx.room.Embedded
import androidx.room.Entity
import androidx.room.Junction
import androidx.room.Relation

@Entity(primaryKeys = ["categoryId", "tagId"])
data class CategoryTagCrossRef(
    val categoryId: Int,
    val tagId: Int
)

data class CategoryWithTags(
    @Embedded val category: Category,
    @Relation(
        parentColumn = "id",
        entityColumn = "id",
        associateBy = Junction(
            value = CategoryTagCrossRef::class,
            parentColumn = "categoryId",
            entityColumn = "tagId"
        )
    )
    val tags: List<Tag>
)

data class TagWithCategories(
    @Embedded val tag: Tag,
    @Relation(
        parentColumn = "id",
        entityColumn = "id",
        associateBy = Junction(
            value = CategoryTagCrossRef::class,
            parentColumn = "tagId",
            entityColumn = "categoryId"
        )
    )
    val categories: List<Category>
)
