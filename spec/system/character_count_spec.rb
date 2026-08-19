# frozen_string_literal: true

require_relative "page_objects/components/character_count_composer"

RSpec.describe "Character count" do
  let!(:theme) { upload_theme_component }

  fab!(:user, :active_user)

  let(:composer) { PageObjects::Components::CharacterCountComposer.new }

  before do
    SiteSetting.min_post_length = 5
    SiteSetting.min_topic_title_length = 4
    sign_in(user)
  end

  it "shows the user title and body character counts while composing a topic" do
    visit("/new-topic")

    expect(composer).to have_title_count("0 / 4", required: true)
    expect(composer).to have_body_count("0 / 5", required: true)

    composer.fill_title("abcd")
    composer.fill_content("abcde")

    expect(composer).to have_title_count("4")
    expect(composer).to have_body_count("5")
  end

  it "hides sufficient counts when the user enables that setting" do
    theme.update_setting(:character_count_hide_count_when_sufficient, true)
    theme.save!

    visit("/new-topic")
    composer.fill_title("abcd")
    composer.fill_content("abcde")

    expect(composer).to have_no_title_count
    expect(composer).to have_no_body_count
  end
end
