# テーブルスキーマ
| モデル名 | カラム名 | データ型 |
| -------- | -------- | -------- |
|   User　　|  id   |  intege   |
|          |  name  | string  |
|          |  email | string  |
|          |password-digest | string |


  
  

| モデル名 | カラム名 | データ型 |
| -------- | -------- | -------- |
| Task     | id       |   intege  |
|          | task_title| string |
|          | task_content| text |
|          |deadline |  date   |
|          | status |   string   |
|          | priority  |  string |
|          | user_id   |  references|



| モデル名 | カラム名 | データ型 |
| -------- | -------- | -------- |
| Label   | id | intege |
|      | label_name    |string   |



| モデル名 | カラム名 | データ型 |
| -------- | -------- | -------- |
| Labeling  | id |  intege  |
|           | label_id |references|
|           | task_id  |references|

# Herokuデプロイ方法
① ``heroku create``のコマンドを入力して、新しいアプリケーションを作成する。

②Heroku buildpackを追加する
```
% heroku buildpacks:set heroku/ruby
% heroku buildpacks:add --index 1 heroku/nodejs
```
をターミナルに入力して、buildpackを追加する。

③ ``git push heroku ブランチ名:master``でherokuにデプロイする。