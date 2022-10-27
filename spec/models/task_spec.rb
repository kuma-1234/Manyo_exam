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

end
