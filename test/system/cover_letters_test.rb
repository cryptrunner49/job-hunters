require "application_system_test_case"

class CoverLettersTest < ApplicationSystemTestCase
  setup do
    @cover_letter = cover_letters(:one)
  end

  test "visiting the index" do
    visit cover_letters_url
    assert_selector "h1", text: "Cover letters"
  end

  test "should create cover letter" do
    visit cover_letters_url
    click_on "New cover letter"

    fill_in "Hunter", with: @cover_letter.hunter_id
    fill_in "Latex source", with: @cover_letter.latex_source
    fill_in "Pdf path", with: @cover_letter.pdf_path
    fill_in "Subject", with: @cover_letter.subject
    click_on "Create Cover letter"

    assert_text "Cover letter was successfully created"
    click_on "Back"
  end

  test "should update Cover letter" do
    visit cover_letter_url(@cover_letter)
    click_on "Edit this cover letter", match: :first

    fill_in "Hunter", with: @cover_letter.hunter_id
    fill_in "Latex source", with: @cover_letter.latex_source
    fill_in "Pdf path", with: @cover_letter.pdf_path
    fill_in "Subject", with: @cover_letter.subject
    click_on "Update Cover letter"

    assert_text "Cover letter was successfully updated"
    click_on "Back"
  end

  test "should destroy Cover letter" do
    visit cover_letter_url(@cover_letter)
    click_on "Destroy this cover letter", match: :first

    assert_text "Cover letter was successfully destroyed"
  end
end
