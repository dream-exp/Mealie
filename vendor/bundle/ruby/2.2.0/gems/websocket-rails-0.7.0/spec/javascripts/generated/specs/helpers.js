(function() {
  window.helpers = {
    startConnection: function(dispatcher, connection_id) {
      var message;
      if (connection_id == null) {
        connection_id = 1;
      }
      message = {
        data: {
          connection_id: connection_id
        }
      };
      return dispatcher.new_message([['client_connected', message]]);
    }
  };

}).call(this);
