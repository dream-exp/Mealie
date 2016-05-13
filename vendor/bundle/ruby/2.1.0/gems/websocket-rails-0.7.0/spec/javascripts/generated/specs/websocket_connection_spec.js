(function() {
  describe('WebsocketRails.WebSocketConnection:', function() {
    var SAMPLE_EVENT, SAMPLE_EVENT_DATA;
    SAMPLE_EVENT_DATA = ['event', 'message'];
    SAMPLE_EVENT = {
      data: JSON.stringify(SAMPLE_EVENT_DATA)
    };
    beforeEach(function() {
      var WebSocketStub;
      this.dispatcher = {
        new_message: function() {
          return true;
        },
        dispatch: function() {
          return true;
        },
        state: 'connected'
      };
      window.WebSocket = WebSocketStub = (function() {
        function WebSocketStub(url, dispatcher) {
          this.url = url;
          this.dispatcher = dispatcher;
        }

        WebSocketStub.prototype.send = function() {
          return true;
        };

        WebSocketStub.prototype.close = function() {
          return this.onclose(null);
        };

        return WebSocketStub;

      })();
      this.connection = new WebSocketRails.WebSocketConnection('localhost:3000/websocket', this.dispatcher);
      return this.dispatcher._conn = this.connection;
    });
    describe('constructor', function() {
      it('should redirect onmessage events\' data from the WebSocket object to this.on_message', function() {
        var mock_connection;
        mock_connection = sinon.mock(this.connection);
        mock_connection.expects('on_message').once().withArgs(SAMPLE_EVENT_DATA);
        this.connection._conn.onmessage(SAMPLE_EVENT);
        return mock_connection.verify();
      });
      it('should redirect onclose events from the WebSocket object to this.on_close', function() {
        var mock_connection;
        mock_connection = sinon.mock(this.connection);
        mock_connection.expects('on_close').once().withArgs(SAMPLE_EVENT);
        this.connection._conn.onclose(SAMPLE_EVENT);
        return mock_connection.verify();
      });
      describe('with ssl', function() {
        return it('should not add the ws:// prefix to the URL', function() {
          var connection;
          connection = new WebSocketRails.WebSocketConnection('wss://localhost.com');
          return expect(connection.url).toEqual('wss://localhost.com');
        });
      });
      return describe('without ssl', function() {
        return it('should add the ws:// prefix to the URL', function() {
          return expect(this.connection.url).toEqual('ws://localhost:3000/websocket');
        });
      });
    });
    describe('.close', function() {
      return it('should close the connection', function() {
        this.connection.close();
        return expect(this.dispatcher.state).toEqual('disconnected');
      });
    });
    describe('.trigger', function() {
      describe('before the connection has been fully established', function() {
        return it('should queue up the events', function() {
          var event, mock_queue;
          this.connection.dispatcher.state = 'connecting';
          event = new WebSocketRails.Event(['event', 'message']);
          mock_queue = sinon.mock(this.connection.message_queue);
          return mock_queue.expects('push').once().withArgs(event);
        });
      });
      return describe('after the connection has been fully established', function() {
        return it('should encode the data and send it through the WebSocket object', function() {
          var event, mock_connection;
          this.connection.dispatcher.state = 'connected';
          event = new WebSocketRails.Event(['event', 'message']);
          this.connection._conn = {
            send: function() {
              return true;
            }
          };
          mock_connection = sinon.mock(this.connection._conn);
          mock_connection.expects('send').once().withArgs(event.serialize());
          this.connection.trigger(event);
          return mock_connection.verify();
        });
      });
    });
    describe('.on_message', function() {
      return it('should decode the message and pass it to the dispatcher', function() {
        var mock_dispatcher;
        mock_dispatcher = sinon.mock(this.connection.dispatcher);
        mock_dispatcher.expects('new_message').once().withArgs(SAMPLE_EVENT_DATA);
        this.connection.on_message(SAMPLE_EVENT_DATA);
        return mock_dispatcher.verify();
      });
    });
    describe('.on_close', function() {
      it('should dispatch the connection_closed event and pass the original event', function() {
        var close_event, dispatcher, event, lastCall;
        event = new WebSocketRails.Event(['event', 'message']);
        close_event = new WebSocketRails.Event(['connection_closed', event]);
        sinon.spy(this.dispatcher, 'dispatch');
        this.connection.on_close(close_event);
        dispatcher = this.dispatcher.dispatch;
        lastCall = dispatcher.lastCall.args[0];
        expect(dispatcher.calledOnce).toBe(true);
        expect(lastCall.data).toEqual(event.data);
        return dispatcher.restore();
      });
      return it('sets the connection state on the dispatcher to disconnected', function() {
        var close_event;
        close_event = new WebSocketRails.Event(['connection_closed', {}]);
        this.connection.on_close(close_event);
        return expect(this.dispatcher.state).toEqual('disconnected');
      });
    });
    describe('.on_error', function() {
      it('should dispatch the connection_error event and pass the original event', function() {
        var dispatcher, error_event, event, lastCall;
        event = new WebSocketRails.Event(['event', 'message']);
        error_event = new WebSocketRails.Event(['connection_error', event]);
        sinon.spy(this.dispatcher, 'dispatch');
        this.connection.on_error(event);
        dispatcher = this.dispatcher.dispatch;
        lastCall = dispatcher.lastCall.args[0];
        expect(dispatcher.calledOnce).toBe(true);
        expect(lastCall.data).toEqual(event.data);
        return dispatcher.restore();
      });
      return it('sets the connection state on the dispatcher to disconnected', function() {
        var close_event;
        close_event = new WebSocketRails.Event(['connection_closed', {}]);
        this.connection.on_error(close_event);
        return expect(this.dispatcher.state).toEqual('disconnected');
      });
    });
    describe("it's no longer active connection", function() {
      beforeEach(function() {
        this.new_connection = new WebSocketRails.WebSocketConnection('localhost:3000/websocket', this.dispatcher);
        return this.dispatcher._conn = this.new_connection;
      });
      it(".on_error should not react to the event response", function() {
        var mock_dispatcher;
        mock_dispatcher = sinon.mock(this.connection.dispatcher);
        mock_dispatcher.expects('dispatch').never();
        this.connection.on_error(SAMPLE_EVENT_DATA);
        return mock_dispatcher.verify();
      });
      it(".on_close should not react to the event response", function() {
        var mock_dispatcher;
        mock_dispatcher = sinon.mock(this.connection.dispatcher);
        mock_dispatcher.expects('dispatch').never();
        this.connection.on_close(SAMPLE_EVENT_DATA);
        return mock_dispatcher.verify();
      });
      return it(".on_message should not react to the event response", function() {
        var mock_dispatcher;
        mock_dispatcher = sinon.mock(this.connection.dispatcher);
        mock_dispatcher.expects('new_message').never();
        this.connection.on_message(SAMPLE_EVENT_DATA);
        return mock_dispatcher.verify();
      });
    });
    return describe('.flush_queue', function() {
      beforeEach(function() {
        this.event = new WebSocketRails.Event(['event', 'message']);
        this.connection.message_queue.push(this.event);
        return this.connection._conn = {
          send: function() {
            return true;
          }
        };
      });
      it('should send out all of the messages in the queue', function() {
        var mock_connection;
        mock_connection = sinon.mock(this.connection._conn);
        mock_connection.expects('send').once().withArgs(this.event.serialize());
        this.connection.flush_queue();
        return mock_connection.verify();
      });
      return it('should empty the queue after sending', function() {
        expect(this.connection.message_queue.length).toEqual(1);
        this.connection.flush_queue();
        return expect(this.connection.message_queue.length).toEqual(0);
      });
    });
  });

}).call(this);
