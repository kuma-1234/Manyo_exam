require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[task_title]', with: 'test1'
        fill_in 'task[task_content]', with: 'test1だよ'
        click_on '作成する'
        expect(page).to have_content 'test1'
        expect(page).to have_content 'test1だよ'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, task_title: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task)
        visit task_path(task)
        expect(page).to have_content task.task_title
        expect(page).to have_content task.task_content
      end
    end
  end
end