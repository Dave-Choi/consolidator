module ApplicationHelper
    def status_icon(status)
    # Using icons from Font-Awesome
        icon_map = {
            'pending' => 'icon-time',
            'approved' => 'icon-ok',
            'rejected' => 'icon-remove'
        }

        return ('<i class="' + icon_map[status] + '"></i>').html_safe
    end
end
