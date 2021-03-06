module ApplicationHelper
    def status_icon(status)
    # Using icons from Font-Awesome
        icon_map = {
            'pending' => 'icon-time',
            'approved' => 'icon-thumbs-up',
            'rejected' => 'icon-thumbs-down',
            'transferred' => 'icon-exchange'
        }

        return ('<i class="' + icon_map[status] + '"></i>').html_safe
    end

    def badge(type, content)
        if(content == 0)
            content = ''
        end
        return ("<span class=\"badge #{type}\">#{content}</span>").html_safe
    end
end
