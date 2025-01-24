require 'test_helper'

class HdiHelperTest < ActionView::TestCase
  include HdiHelper

  # test 'assistant_image_tag' do
  #   @output_buffer = ActionView::OutputBuffer.new(assistant_image_tag(assistant))
  #   TODO: Add assertions

  #   # Big
  #   @output_buffer = ActionView::OutputBuffer.new(assistant_image_tag(assistant, true))
  #   TODO: Add assertions
  # end

  # test 'current_user_image_tag' do
  #   @output_buffer = ActionView::OutputBuffer.new(current_user_image_tag)
  #   TODO: Add assertions

  #   # Big
  #   @output_buffer = ActionView::OutputBuffer.new(current_user_image_tag(true))
  #   TODO: Add assertions
  # end

  # test 'render_code_block' do
  #   @output_buffer = ActionView::OutputBuffer.new(render_code_block(code, language))
  #   TODO: Add assertions
  # end

  # test 'render_markdown' do
  #   @output_buffer = ActionView::OutputBuffer.new(render_markdown(markdown_text))
  #   TODO: Add assertions
  # end

  test 'sidebar_navigation_svg' do
    @output_buffer = ActionView::OutputBuffer.new(
      hdi_sidebar_navigation_svg('Home', root_path, true, data: { test: 'foo' }) do
        content_tag(:path, 'stroke-linecap' => 'round', 'stroke-linejoin' => 'round')
      end
    )
    assert_select 'a[data-test="foo"].flex.text-indigo-600', /Home\z/ do
      assert_select 'svg' do
        assert_select 'path'
      end
    end

    @output_buffer = ActionView::OutputBuffer.new(
      hdi_sidebar_navigation_svg('Home', root_path, false, data: { test: 'foo' }) do
        content_tag(:path, 'stroke-linecap' => 'round', 'stroke-linejoin' => 'round')
      end
    )
    assert_select 'a[data-test="foo"].flex.text-gray-700', /Home\z/ do
      assert_select 'svg' do
        assert_select 'path'
      end
    end
  end

  # test 'unknown_user_image_tag' do
  #   @output_buffer = ActionView::OutputBuffer.new(unknown_user_image_tag)
  #   TODO: Add assertions

  #   # Big
  #   @output_buffer = ActionView::OutputBuffer.new(unknown_user_image_tag(true))
  #   TODO: Add assertions
  # end
end
