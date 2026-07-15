ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # 指定のワーカー数でテストを並列実行する
  parallelize(workers: :number_of_processors)
  
  # test/fixtures/*.yml にあるすべての fixture をセットアップする
  fixtures :all

  # テストユーザーがログイン中の場合に true を返す
  def is_logged_in?
    !session[:user_id].nil?
  end
  include ApplicationHelper

end
