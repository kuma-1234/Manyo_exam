require 'rails_helper'

RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクタイトルが空の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(task_title: '', task_content:'失敗')
        expect(task).not_to be_valid
      end
    end

    context 'タスクコンテントが空の場合' do
      it 'バリデーションに引っかかる' do
        task = Task.new(task_title: '失敗', task_content: '')
        expect(task).not_to be_valid
      end
    end

    context 'タイトル・内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(task_title: '成功', task_content: '成功')
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, task_title: 'task', status: "着手中") }
    let!(:task2) { FactoryBot.create(:task2, task_title: 'sample', status: "完了") }
    context 'scopeメソッドであいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.search_title('task')).to include(task)
        expect(Task.search_title('task')).not_to include(task2)
        expect(Task.search_title('task').count).to eq 1
      end
    end

    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search_status('着手中')).to include(task)
        expect(Task.search_status('着手中')).not_to include(task2)
        expect(Task.search_status('着手中').count).to eq 1
      end
    end

    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search_title('task').search_status('着手中')).to include(task)
        expect(Task.search_title('task').search_status('着手中')).not_to include(task2)
        expect(Task.search_title('sample').search_status('完了').count).to eq 1
      end
    end
  end

end
