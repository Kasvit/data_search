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

  it "will not create new database without correct path_file" do
    expect{ Database.new('./test.json') }.to raise_error(FileMissingError)
  end

  it "will not create new database without correct format" do
    expect{ Database.new('./new_data.json') }.to raise_error(FileParsingError)
  end
end
