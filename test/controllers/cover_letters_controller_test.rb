require "test_helper"

class CoverLettersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cover_letter = cover_letters(:one)
  end

  test "should get index" do
    get cover_letters_url
    assert_response :success
  end

  test "should get new" do
    get new_cover_letter_url
    assert_response :success
  end

  test "should create cover_letter" do
    assert_difference("CoverLetter.count") do
      post cover_letters_url, params: { cover_letter: { hunter_id: @cover_letter.hunter_id, latex_source: @cover_letter.latex_source, pdf_path: @cover_letter.pdf_path, subject: @cover_letter.subject } }
    end

    assert_redirected_to cover_letter_url(CoverLetter.last)
  end

  test "should show cover_letter" do
    get cover_letter_url(@cover_letter)
    assert_response :success
  end

  test "should get edit" do
    get edit_cover_letter_url(@cover_letter)
    assert_response :success
  end

  test "should update cover_letter" do
    patch cover_letter_url(@cover_letter), params: { cover_letter: { hunter_id: @cover_letter.hunter_id, latex_source: @cover_letter.latex_source, pdf_path: @cover_letter.pdf_path, subject: @cover_letter.subject } }
    assert_redirected_to cover_letter_url(@cover_letter)
  end

  test "should destroy cover_letter" do
    assert_difference("CoverLetter.count", -1) do
      delete cover_letter_url(@cover_letter)
    end

    assert_redirected_to cover_letters_url
  end
end
