jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  if $('#messages').length > 0
    messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))

    messages_to_bottom()

    App.anonymous = App.cable.subscriptions.create {
        channel: "AnonymousChannel"
        anonymous_room_id: messages.data('anonymous-room-id')
      },
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        messages.append data['message']
        messages_to_bottom()

      send_message: (message, anonymous_room_id, user_id) ->
        @perform 'send_message', message: message, anonymous_room_id: anonymous_room_id, user_id: user_id


    $('#new_message').submit (e) ->
      $this = $(this)
      textarea = $this.find('#message_message')
      if $.trim(textarea.val()).length > 1
        App.anonymous.send_message textarea.val(), messages.data('anonymous-room-id')
        textarea.val('')
      e.preventDefault()
      return false