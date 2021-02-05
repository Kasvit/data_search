require './spec/spec_helper'

describe Search do
  let!(:database) { Database.new('./data.json') }
  let!(:search) { Search.new(database) }

  before do
    $database = database
    $database.populate_database
  end

  it "will find 'Common Lisp'" do
    expect(search.find(query: 'Lisp Common').pluck(:name)).to eq(["Common Lisp"])
  end

  it "will find 'C#'" do
    expect(search.find(query: 'C#').pluck(:name)).to eq(["C#"])
  end

  it "will find 'C++'" do
    expect(search.find(query: 'C++').pluck(:name)).to eq(["C++"])
  end

  it "will find 'Microsoft' from 'Designed by'" do
    expect(search.find(query: 'Microsoft').pluck(:name)).to eq(["C#", "F#", "JScript", "VBScript", "Visual Basic", "Visual FoxPro", "Windows PowerShell", "X++"])
  end

  it "will find 'Command line interface' from 'Type'" do
    expect(search.find(query: 'Command line interface').pluck(:name)).to eq(["bash", "csh", "Expect", "Hamilton C shell", "ksh", "REXX", "Windows PowerShell", "zsh"])
  end

  it "will find 'Scripting Microsoft'" do
    expect(search.find(query: 'Scripting Microsoft').pluck(:name)).to eq(["C#", "F#", "JScript", "VBScript", "Visual Basic", "Visual FoxPro", "Windows PowerShell", "X++"])
  end

  it 'will find `Interpreted "Thomas Eugene"`' do
    expect(search.find(query: 'Interpreted "Thomas Eugene"').pluck(:name)).to eq(["BASIC"])
  end

  it "will find `john --array`" do
    expect(search.find(query: 'john --array --test').pluck(:name)).to eq(["BASIC", "Haskell", "Lisp", "S-Lang"])
  end

  it "will find `ruby`" do
    expect(search.find(query: 'ruby').pluck(:name)).to eq(["Ruby"])
  end

  it "will not find `ruby --reflective`" do
    expect(search.find(query: 'ruby --reflective').pluck(:name)).to eq([])
  end

  it "will find `microsoft --compiled`" do
    expect(search.find(query: 'microsoft --compiled').pluck(:name)).to eq(["F#", "JScript", "VBScript", "Windows PowerShell"])
  end

  it "will find `microsoft --compiled --reflective`" do
    expect(search.find(query: 'microsoft --compiled --reflective').pluck(:name)).to eq(["F#", "VBScript", "Windows PowerShell"])
  end
end
