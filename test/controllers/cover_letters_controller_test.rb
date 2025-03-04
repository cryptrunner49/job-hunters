require "test_helper"

class CoverLettersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cover_letter = cover_letters(:one)
    @hunter = hunters(:one)
    sign_in_as(@hunter.email_address, "password") # Ensure this method authenticates correctly
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
      post cover_letters_url,
           params: { cover_letter: { subject: "New Subject", latex_source: "New LaTeX", pdf_path: "new.pdf" } },
           as: :json
    end
    assert_response :created # Expect 201, not 200
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
    patch cover_letter_url(@cover_letter),
          params: { cover_letter: { subject: "Updated Subject" } }
    assert_redirected_to cover_letter_url(@cover_letter)
  end

  test "should destroy cover_letter" do
    assert_no_difference("CoverLetter.count") do
      delete cover_letter_url(@cover_letter)
    end
    @cover_letter.reload
  end
end
