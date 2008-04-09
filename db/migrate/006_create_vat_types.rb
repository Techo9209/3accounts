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

class CreateVatTypes < ActiveRecord::Migration
  def self.up
    create_table :vat_types do |t|
      t.string :name
      t.decimal :rate, :precision => 12, :scale => 3
      t.timestamps
    end

    say_with_time "Adding UK VAT types" do
      VatType.create(:name => "Standard", :rate => 0.175)
      VatType.create(:name => "Lower", :rate => 0.175)
      VatType.create(:name => "Zero", :rate => 0)
      VatType.create(:name => "Exempt", :rate => 0)
      VatType.create(:name => "Out of Scope", :rate => 0)
    end

  end

  def self.down
    drop_table :vat_types
  end
end
