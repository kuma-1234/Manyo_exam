require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) {FactoryBot.create(:task)}
  let!(:task2) {FactoryBot.create(:task2)}

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
    before do
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content task.task_title
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it 'タスクが一番上に表示される' do
        task_list = all('.task_table')
        expect(task_list[0]).to have_content 'test2'
      end
    end
    context '終了期限のソートを押した場合' do
      it '終了期限の降順にタスクが表示される' do
        click_on '終了期限でソートする'
        task_list = all('.task_table')
        expect(task_list[0]).to have_content 'test'
        expect(task_list[1]).to have_content 'test2'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(task)
        expect(page).to have_content task.task_title
        expect(page).to have_content task.task_content
      end
    end
  end

  describe '検索機能' do
    before do
      visit tasks_path
    end

    context 'タイトルであいまい検索をした場合' do
      it "検索ワードを含むタスクで絞り込まれる" do
        fill_in 'search_task_title', with: 't'
        click_on '検索'
        expect(page).to have_content 't'
      end
    end

    context 'ステータスで検索をした場合' do
      it "ステータスに完全一致したタスクが絞り込まれる" do
        select '未着手', from: 'search[status]'
        click_on '検索'
        expect(page).to have_content '未着手'
      end
    end

    context 'タイトルのあいまい検索＋ステータス検索をした場合' do
      it '検索キーワードを含み、かつステータスに完全一致するタスクが絞り込まれる' do
        fill_in 'search_task_title', with: 'test' 
        select '着手中', from: 'search[status]'
        click_on '検索'
        expect(page).to have_content 'test'
        expect(page).to have_content '着手中'
      end
    end
  end
end