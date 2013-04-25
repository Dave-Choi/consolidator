module BorrowRequestsHelper
    def status_message(request)
        # This is being used with raw, right now.
        thing = request.thing
        name = thing.name
        holder_name = thing.holder.name
        status = request.status

        messages = {
            'approved' => "You're approved to borrow #{link_to(name, thing)}.",
            'rejected' => "Your request for #{ link_to name, thing } was rejected."
        }

        return messages[status] || "You've requested to borrow #{ link_to name, thing }"
    end

    def status_actions(request)
        actions = {
            'approved' => link_to(
                'Received',
                transfers_path(
                    :transfer => {
                        :borrow_request_id => request.id
                    },
                    :source_path => ''
                ),
                :class => 'btn btn-info',
                :method => 'post'
            ),
            'rejected' => link_to(
                'Dismiss',
                request,
                :class => 'btn btn-danger',
                :method => 'delete'
            )
        }
        return actions[request.status]
    end
end
