module ApplicationHelper
    def address(city, state, country)
        "#{city}, #{state}, #{country}"
    end
    def full_name(firstname, lastname)
        "#{firstname} #{lastname}"
    end
end


