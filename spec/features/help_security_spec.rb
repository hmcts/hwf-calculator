require 'rails_helper'
RSpec.describe 'help security feature', type: :feature, js: true do
  it 'redirects back to a valid path' do
    # Act - open the page with a valid return path
    total_income_include_exclude_page.load(query: { return_to_path: '/some/valid_path' })

    # Assert - make sure the url in the link does not contain javascript - dont really care what it has been changed to.
    expect(URI.parse(total_income_include_exclude_page.back_element[:href]).path).to eql('/some/valid_path')
  end

  it 'does not allow javascript: urls' do
    # Act - open the page with the javascript url embedded in the return path
    total_income_include_exclude_page.load(query: { return_to_path: 'javascript:window.location.replace(\'http://google.com\')' })

    # Assert - make sure the url in the link does not contain javascript - dont really care what it has been changed to.
    expect(total_income_include_exclude_page.back_element[:href]).not_to have_text('javascript')
  end
end
