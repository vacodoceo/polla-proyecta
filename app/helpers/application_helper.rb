module ApplicationHelper
    def flash_class(level)
        case level
            when 'primary' then "alert alert-primary"
            when 'success' then "alert alert-success"
            when 'danger' then "alert alert-danger"
            when 'warning' then "alert alert-warning"
        end
    end
end
