# README
| モデル名 | カラム名 | データ型 |
| -------- | -------- | -------- |
|   User　　|  id      |          |
|          |    name  |     string     |
|          |    email |     string     |
|          |password-digest |  string   |


  
  

| モデル名 | カラム名 | データ型 |
| -------- | -------- | -------- |
| Task     | id       |          |
|          | task_title| string |
|          | task_content| text |
|          |deadline |  date   |
|          | status |   string   |
|          | priority  |  string |
|          | user_id   |  references|



| モデル名 | カラム名 | データ型 |
| -------- | -------- | -------- |
| Label   | id |          |
|      | label_name    |string   |



| モデル名 | カラム名 | データ型 |
| -------- | -------- | -------- |
| Labeling  | id |          |
|           | label_id |references|
|           | task_id  |references|