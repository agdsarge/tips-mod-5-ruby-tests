require 'active_support'
require 'active_support/core_ext'

class RecurringMoment
    def initialize(start:, interval:, period:) # accepts a hash
        @start = start          # DateTime object
        @interval = interval    # integer
        @period = period        # string. one of  ['daily', 'weekly', 'monthly']
    end

    def month_helper(date, index)
        date.advance(months: @interval * index)
    end


    def match(date)
        # instance method. returns true or false.
        # the param date is a DateTime object
            # in the test, date is a DateTime of the form DateTime.advance(period: interval)
        # the advance method for DateTime is imported from active_support or active_support/core_ext
        # something is weird about months. i suspect it's february. i've partitioned it off.
        # when it was with the other periods, i had six failing tests

        current = @start

        unless @period == 'monthly'
            while current < date
                if @period == 'weekly'
                    current = current.advance(weeks: @interval)
                elsif @period == 'daily'
                    current = current.advance(days: @interval)
                end
            end
        else
            ind = 1
            while current < date
                current = month_helper(@start, ind)
                ind += 1
            end
        end

        current == date
    end
end
