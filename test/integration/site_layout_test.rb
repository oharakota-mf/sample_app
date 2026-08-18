require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  # テスト用のユーザーを準備する
  def setup
    @user = users(:michael)
  end

  # ① ログイン【していない】ユーザー向けのテスト
  test "layout links for non-logged-in user" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", login_path
  end

  # ② ログイン【している】ユーザー向けのテスト
  test "layout links for logged-in user" do
    # まずテストユーザーでログインする（ヒントにあった log_in_as を使用）
    log_in_as(@user)
    
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    
    # ここから下がログイン後専用のリンクの確認
    assert_select "a[href=?]", login_path, count: 0 # ログインリンクが「無い(0個)」ことを確認
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
  end
end
