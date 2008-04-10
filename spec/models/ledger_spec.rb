#    3accounts - Accounts software for real people 
#    Copyright (C) 2008, Neil Wilson, Aldur Systems
#
#    This file is part of 3accounts
#
#    3accounts is free software: you can redistribute it and/or modify it
#    under the terms of the GNU Affero General Public License as published
#    by the Free Software Foundation, either version 3 of the License,
#    or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#    Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General
#    Public License along with this program.  If not, see
#    <http://www.gnu.org/licenses/>.
#

require File.dirname(__FILE__) + '/../spec_helper'

describe "A Ledger" do

  before(:each) do
    @ledger = Ledger.new
  end

  it "should validate presence of loaded_from" do
    @ledger.should validate_presence_of(:loaded_from)
  end

end

describe "Loading a Ledger" do
  before(:each) do
    @journal_file = [{
      :org_type => "Invoice",
      :org_id => 2555,
      :posted_at => "2008-02-29",
      :new_transactions => [{
        :account => "Receivable",
        :amount => 130},
        { :account => "Sales", :amount => -130 }]
    }]
    def @journal_file.name
      "fred"
    end
  end

  it "should create a record with correct settings" do
    lambda {
      Ledger.load_journals(@journal_file)
    }.should change(Ledger, :count).by(1)
  end

  it "should not create anything with incorrect settings" do
    lambda {
      @journal_file[0].delete(:org_type)
    }.should_not change(Journal, :count)
  end

end

describe "Quickbooks load class" do
  before(:each) do
    @qb_extract = StringIO.new <<DOC
Trans no	Type	Date	Num	Name	Memo	Account	Debit	Credit
2555	Deposit	01/11/2006			Interest	Abbey National	0.50	
					Interest	Interest Income		0.50
							0.50	0.50
2556	Credit Card Charge	03/11/2006	387565015	Fred		Directors Loan		1.56
				Fred	Mobiles	Mobile	1.33	
				Fred	Total VAT	VAT Control	0.23	
							1.56	1.56
2558	Bill	15/11/2006		Ebay International		Accounts Payable		4.48
				Ebay International	Ebay Charges	eBay Charges	4.48	
				Ebay International	Total VAT	VAT Control	0.00	
							4.48	4.48
DOC
    @test = Qb6JournalFile.new(@qb_extract)
  end
  
  it "should load an extract correctly" do
    @test.collect {|journal| journal}.should have(3).items
  end

  it "should have a nil name" do
    @test.name.should be_nil
  end

  it "should read a line correctly" do
    @test.read_entry.should have(8).items
  end


end
