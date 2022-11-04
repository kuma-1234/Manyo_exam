require 'rails_helper'

RSpec.feature 'ユーザー管理機能',  type: :system do
  describe 'ユーザーの新規登録テスト' do
    context '新規登録ができる場合' do
      it 'ユーザーの新規登録ができて、マイページを表示する' do
        visit new_user_path
        fill_in 'user[name]', with: 'user3'
        fill_in 'user[email]', with: 'test3@test.com'
        fill_in 'user[password]', with: 'user03'
        fill_in 'user[password_confirmation]', with: 'user03'
        click_on '新規登録'
        expect(page).to have_content 'test3@test.com'
      end
    end
    context 'ユーザーがログインできない場合' do
      it 'ログインせずにタスク一覧に飛ぶと、ログインページへ戻ってくる' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'session機能のテスト' do
    before do
      @user = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user2)
    end

    context 'ログインしていない場合' do
      it 'ログインができる' do
        visit new_session_path
        fill_in :session_email, with: @user.email
        fill_in :session_password, with: @user.password
        click_on 'Log in'
        expect(current_path).to eq user_path(@user.id)
      end
    end

    context 'ログインしている場合' do
      before do
        visit new_session_path
        fill_in :session_email, with: @user.email
        fill_in :session_password, with: @user.password
        click_on 'Log in'
      end

      it 'マイページにリンクする' do
        visit user_path(@user.id)
        expect(current_path).to eq user_path(@user.id)
      end

      it '一般ユーザーが他人の詳細画面にリンクするとタスクの一覧画面に戻る' do
        visit user_path(@user2.id)
        expect(current_path).to eq tasks_path
      end

      it 'ログアウトができる' do
        click_on 'Logout'
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe '管理画面のテスト' do
    before do
      @admin_user = FactoryBot.create(:admin_user)
      @user = FactoryBot.create(:user)
    end
    context '管理ユーザーがログインしている場合' do
      before do
        visit new_session_path
        fill_in :session_email, with: @admin_user.email
        fill_in :session_password, with: @admin_user.password
        click_on 'Log in'
      end
      it '管理ユーザーは管理画面にアクセスできる' do
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end
      it 'ユーザーの新規登録ができる' do
        visit new_admin_user_path
        fill_in :user_name, with: 'kuma'
        fill_in :user_email, with: 'kuma@test.com'
        fill_in :user_password, with: 'test1234'
        fill_in :user_password_confirmation, with: 'test1234'
        select '一般ユーザー', from: 'Admin'
        click_on '新規作成'
        expect(page).to have_content 'kuma'
      end
      it 'ユーザーの詳細画面にアクセスできる' do
        user2 = FactoryBot.create(:user2)
        visit admin_user_path(user2.id)
        expect(page).to have_content 'user2'
      end
      it 'ユーザーの編集ができる' do
        user2 = FactoryBot.create(:user2)
        visit edit_admin_user_path(user2.id)
        fill_in :user_name, with: 'sample'
        fill_in :user_email, with: 'sample@test.com'
        fill_in :user_password, with: 'sample1234'
        fill_in :user_password_confirmation, with: 'sample1234'
        click_on 'ユーザー情報の更新'
        expect(page).to have_content 'sample'
      end
      it 'ユーザーの削除ができる' do
        visit admin_users_path
        accept_confirm do
          all('tbody tr')[1].click_link '削除'
        end
        expect(page).not_to have_content 'user1'
      end
    end
    context '一般ユーザーがログインしている場合' do
      before do
        visit new_session_path
        fill_in :session_email, with: @user.email
        fill_in :session_password, with: @user.password
        click_on 'Log in'
      end
      it '管理画面にアクセスできない' do
        visit admin_users_path
        expect(current_path).not_to eq admin_users_path
      end
    end
  end
end