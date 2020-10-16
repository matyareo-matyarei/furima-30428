# Furimaテーブル設計

## users テーブル

| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| name       | string | null: false |
| email      | string | null: false |
| password   | string | null: false |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column     | Type       | Options                        |
| ---------- | ---------- | ------------------------------ |
| item       | string     | null: false                    |
| category   | string     | null: false                    |
| price      | integer    | null: false                    |
| user       | references | null: false, foreign_key: true |
| order      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :order

## orders テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| order     | integer    | null: false                    |
| user      | references | null: false, foreign_key: true |
| item      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item