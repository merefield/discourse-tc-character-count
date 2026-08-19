# frozen_string_literal: true

module PageObjects
  module Components
    class CharacterCountComposer < Composer
      def has_title_count?(text, required: false)
        has_css?(count_selector(".title-input", required:), exact_text: text)
      end

      def has_body_count?(text, required: false)
        has_css?(count_selector(".d-editor", required:), exact_text: text)
      end

      def has_no_title_count?
        has_no_css?(count_selector(".title-input"))
      end

      def has_no_body_count?
        has_no_css?(count_selector(".d-editor"))
      end

      private

      def count_selector(parent_selector, required: false)
        required_selector = ".more-required" if required
        "#{@composer_id} #{parent_selector} .character-counts#{required_selector}"
      end
    end
  end
end
