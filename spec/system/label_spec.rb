require 'rails_helper'

RSpec.describe 'ラベル管理機能', type: :system do
  let!(:admin_user){ FactoryBot.create(:admin_user) }
  def login
    visit new_session_path
    fill_in "session[email]", with: 'admin_user@test.com'
    fill_in "session[password]", with: 'test123456'
    click_on 'Log in'
  end

  describe 'ラベル新規作成' do
    context 'ラベルを新規作成した場合' do
      it '作成したラベルが表示される' do
        login
        visit new_label_path
        fill_in 'label[label_name]', with: 'test_label'
        click_on '作成する'
        expect(page).to have_content 'test_label'
      end
    end
  end
  describe 'ラベルの付与機能' do
    let!(:label){ FactoryBot.create(:label, user: admin_user ) }
    context 'タスク作成と同時にラベルを選択した場合' do
      it '作成したタスクにラベルが表示される' do
        login
        visit new_task_path
        fill_in 'task[task_title]', with: 'test_labelだよ'
        fill_in 'task[task_content]', with: 'testtesttest'
        check 'Ruby'
        click_on '作成する'
        expect(page).to have_content 'test_labelだよ'
        expect(page).to have_content 'Ruby'
      end
    end
  end
  describe 'ラベルの検索機能' do
    let!(:label){ FactoryBot.create(:label, user: admin_user ) }
    let!(:task){ FactoryBot.create(:task, user: admin_user ) }
    let!(:labeling){ FactoryBot.create(:labeling, task: task, label: label) }
    context 'タスク検索でラベルを検索した場合' do
      it '検索されたラベルが付いているタスクを表示する' do
        login
        visit tasks_path
        select 'Ruby', from: 'search[label_id]'
        click_on '検索'
        task_list = all('.task_table')
        expect(task_list[0]).to have_content 'test'
        expect(task_list[0]).to have_content 'Ruby'
      end
    end
  end
end