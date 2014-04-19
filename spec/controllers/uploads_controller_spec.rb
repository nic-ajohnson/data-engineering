require 'spec_helper'

describe UploadsController do
  it 'should get index' do
    get 'index'
    expect(response).to be_success
  end

  it 'should get show' do
    Upload.create(:gross_revenue => 50.0, :file_name => "test_file.tab")
    get 'show', {:id => 1}
    expect(response).to be_success
  end

  it 'should get upload' do
    expect(Upload.count).to eq 0
    file = ActionDispatch::Http::UploadedFile.new(
      :tempfile => File.new("#{Rails.root}/lib/assets/example_input.tab"),
      :file_name => "example_input.tab")
    post 'import', {:file => file}
    expect(Upload.count).to eq 1
    expect(response).to redirect_to root_url
  end
end
