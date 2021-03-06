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

class Journal < ActiveRecord::Base
  has_many :transactions, :dependent => :delete_all
  has_one :period, :dependent => :delete
  has_one :fixed_asset, :dependent => :delete
  belongs_to :ledger

  validates_presence_of(:org_id)
  validates_presence_of(:org_type)
  validates_presence_of(:posted_at)
  validates_presence_of(:transactions)
  validates_uniqueness_of(:org_id)
  validates_existence_of(:ledger, :allow_nil => true)

  def new_transactions=(transaction_list)
    transaction_list.each do |transaction|
      transactions.build transaction
    end
  end

  def original_cost
    transactions.inject(0) do |sum,transaction|
      if transaction.amount < 0 || transaction.account =~ /Vat/
        sum
      else
        sum + transaction.amount
      end
    end
  end

end
