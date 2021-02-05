require './spec/spec_helper'

describe Database do
  let!(:database) { Database.new('./data.json') }

  before do
    $database = database
  end

  it "will create new database with correct path_file" do
    expect(database.data.size).to eq(97)
    expect(database.authors.size).to eq(0)
    database.populate_database
    expect(database.authors.size).to eq(169)
  end
end
