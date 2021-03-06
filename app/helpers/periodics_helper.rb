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

module PeriodicsHelper

  def period_link(journal)
    Date::DATE_FORMATS[:uk] = "%d-%b-%y"
    period = journal.period
    if period
      link_to "Covers #{period.start_at.to_s(:uk)} to #{period.end_at.to_s(:uk)}", edit_periodic_period_path(journal)
    else
      link_to "Make Periodic", new_periodic_period_path(journal)
    end
  end

end
