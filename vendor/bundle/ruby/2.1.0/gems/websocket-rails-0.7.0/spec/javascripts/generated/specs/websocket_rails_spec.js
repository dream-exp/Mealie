(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  describe('WebSocketRails:', function() {
    beforeEach(function() {
      var HttpConnectionStub, WebSocketConnectionStub;
      this.url = 'localhost:3000/websocket';
      WebSocketRails.WebSocketConnection = WebSocketConnectionStub = (function(_super) {
        __extends(WebSocketConnectionStub, _super);

        function WebSocketConnectionStub() {
          return WebSocketConnectionStub.__super__.constructor.apply(this, arguments);
        }

        WebSocketConnectionStub.prototype.connection_type = 'websocket';

        return WebSocketConnectionStub;

      })(WebSocketRails.AbstractConnection);
      WebSocketRails.HttpConnection = HttpConnectionStub = (function(_super) {
        __extends(HttpConnectionStub, _super);

        function HttpConnectionStub() {
          return HttpConnectionStub.__super__.constructor.apply(this, arguments);
        }

        HttpConnectionStub.prototype.connection_type = 'http';

        return HttpConnectionStub;

      })(WebSocketRails.AbstractConnection);
      return this.dispatcher = new WebSocketRails(this.url);
    });
    describe('constructor', function() {
      return it('should start connection automatically', function() {
        return expect(this.dispatcher.state).toEqual('connecting');
      });
    });
    describe('.connect', function() {
      it('should set the new_message method on connection to this.new_message', function() {
        return expect(this.dispatcher._conn.new_message).toEqual(this.dispatcher.new_message);
      });
      it('should set the initial state to connecting', function() {
        return expect(this.dispatcher.state).toEqual('connecting');
      });
      describe('when use_websockets is true', function() {
        return it('should use the WebSocket Connection', function() {
          var dispatcher;
          dispatcher = new WebSocketRails(this.url, true);
          return expect(dispatcher._conn.connection_type).toEqual('websocket');
        });
      });
      describe('when use_websockets is false', function() {
        return it('should use the Http Connection', function() {
          var dispatcher;
          dispatcher = new WebSocketRails(this.url, false);
          return expect(dispatcher._conn.connection_type).toEqual('http');
        });
      });
      return describe('when the browser does not support WebSockets', function() {
        return it('should use the Http Connection', function() {
          var dispatcher;
          window.WebSocket = 'undefined';
          dispatcher = new WebSocketRails(this.url, true);
          return expect(dispatcher._conn.connection_type).toEqual('http');
        });
      });
    });
    describe('.disconnect', function() {
      beforeEach(function() {
        return this.dispatcher.disconnect();
      });
      it('should close the connection', function() {
        return expect(this.dispatcher.state).toEqual('disconnected');
      });
      return it('existing connection should be destroyed', function() {
        return expect(this.dispatcher._conn).toBeUndefined();
      });
    });
    describe('.reconnect', function() {
      var NEW_CONNECTION_ID, OLD_CONNECTION_ID;
      OLD_CONNECTION_ID = 1;
      NEW_CONNECTION_ID = 2;
      it('should connect, when disconnected', function() {
        var mock_dispatcher;
        mock_dispatcher = sinon.mock(this.dispatcher);
        mock_dispatcher.expects('connect').once();
        this.dispatcher.disconnect();
        this.dispatcher.reconnect();
        return mock_dispatcher.verify();
      });
      it('should recreate the connection', function() {
        helpers.startConnection(this.dispatcher, OLD_CONNECTION_ID);
        this.dispatcher.reconnect();
        helpers.startConnection(this.dispatcher, NEW_CONNECTION_ID);
        return expect(this.dispatcher._conn.connection_id).toEqual(NEW_CONNECTION_ID);
      });
      it('should resend all uncompleted events', function() {
        var event;
        event = this.dispatcher.trigger('create_post');
        helpers.startConnection(this.dispatcher, OLD_CONNECTION_ID);
        this.dispatcher.reconnect();
        helpers.startConnection(this.dispatcher, NEW_CONNECTION_ID);
        return expect(this.dispatcher.queue[event.id].connection_id).toEqual(NEW_CONNECTION_ID);
      });
      it('should not resend completed events', function() {
        var event;
        event = this.dispatcher.trigger('create_post');
        event.run_callbacks(true, {});
        helpers.startConnection(this.dispatcher, OLD_CONNECTION_ID);
        this.dispatcher.reconnect();
        helpers.startConnection(this.dispatcher, NEW_CONNECTION_ID);
        return expect(this.dispatcher.queue[event.id].connection_id).toEqual(OLD_CONNECTION_ID);
      });
      return it('should reconnect to all channels', function() {
        var mock_dispatcher;
        mock_dispatcher = sinon.mock(this.dispatcher);
        mock_dispatcher.expects('reconnect_channels').once();
        this.dispatcher.reconnect();
        return mock_dispatcher.verify();
      });
    });
    describe('.reconnect_channels', function() {
      beforeEach(function() {
        this.channel_callback = function() {
          return true;
        };
        helpers.startConnection(this.dispatcher, 1);
        this.dispatcher.subscribe('public 4chan');
        this.dispatcher.subscribe_private('private 4chan');
        return this.dispatcher.channels['public 4chan'].bind('new_post', this.channel_callback);
      });
      it('should recreate existing channels, keeping their private/public type', function() {
        this.dispatcher.reconnect_channels();
        expect(this.dispatcher.channels['public 4chan'].is_private).toEqual(false);
        return expect(this.dispatcher.channels['private 4chan'].is_private).toEqual(true);
      });
      return it('should move all existing callbacks from old channel objects to new ones', function() {
        var old_public_channel;
        old_public_channel = this.dispatcher.channels['public 4chan'];
        this.dispatcher.reconnect_channels();
        expect(old_public_channel._callbacks).toEqual({});
        return expect(this.dispatcher.channels['public 4chan']._callbacks).toEqual({
          new_post: [this.channel_callback]
        });
      });
    });
    describe('.new_message', function() {
      describe('when this.state is "connecting"', function() {
        beforeEach(function() {
          return this.connection_id = 123;
        });
        it('should call this.connection_established on the "client_connected" event', function() {
          var mock_dispatcher;
          mock_dispatcher = sinon.mock(this.dispatcher);
          mock_dispatcher.expects('connection_established').once().withArgs({
            connection_id: this.connection_id
          });
          helpers.startConnection(this.dispatcher, this.connection_id);
          return mock_dispatcher.verify();
        });
        it('should set the state to connected', function() {
          helpers.startConnection(this.dispatcher, this.connection_id);
          return expect(this.dispatcher.state).toEqual('connected');
        });
        it('should flush any messages queued before the connection was established', function() {
          var mock_con;
          mock_con = sinon.mock(this.dispatcher._conn);
          mock_con.expects('flush_queue').once();
          helpers.startConnection(this.dispatcher, this.connection_id);
          return mock_con.verify();
        });
        it('should set the correct connection_id', function() {
          helpers.startConnection(this.dispatcher, this.connection_id);
          return expect(this.dispatcher._conn.connection_id).toEqual(123);
        });
        return it('should call the user defined on_open callback', function() {
          var spy;
          spy = sinon.spy();
          this.dispatcher.on_open = spy;
          helpers.startConnection(this.dispatcher, this.connection_id);
          return expect(spy.calledOnce).toEqual(true);
        });
      });
      return describe('after the connection has been established', function() {
        beforeEach(function() {
          this.dispatcher.state = 'connected';
          return this.attributes = {
            data: 'message',
            channel: 'channel'
          };
        });
        it('should dispatch channel messages', function() {
          var data, mock_dispatcher;
          data = [['event', this.attributes]];
          mock_dispatcher = sinon.mock(this.dispatcher);
          mock_dispatcher.expects('dispatch_channel').once();
          this.dispatcher.new_message(data);
          return mock_dispatcher.verify();
        });
        it('should dispatch standard events', function() {
          var data, mock_dispatcher;
          data = [['event', 'message']];
          mock_dispatcher = sinon.mock(this.dispatcher);
          mock_dispatcher.expects('dispatch').once();
          this.dispatcher.new_message(data);
          return mock_dispatcher.verify();
        });
        return describe('result events', function() {
          beforeEach(function() {
            this.attributes['success'] = true;
            this.attributes['id'] = 1;
            this.event = {
              run_callbacks: function(data) {}
            };
            this.event_mock = sinon.mock(this.event);
            this.dispatcher.queue[1] = this.event;
            return this.event_data = [['event', this.attributes]];
          });
          it('should run callbacks for result events', function() {
            this.event_mock.expects('run_callbacks').once();
            this.dispatcher.new_message(this.event_data);
            return this.event_mock.verify();
          });
          return it('should remove the event from the queue', function() {
            this.dispatcher.new_message(this.event_data);
            return expect(this.dispatcher.queue[1]).toBeUndefined();
          });
        });
      });
    });
    describe('.bind', function() {
      return it('should store the callback on the correct event', function() {
        var callback;
        callback = function() {};
        this.dispatcher.bind('event', callback);
        return expect(this.dispatcher.callbacks['event']).toContain(callback);
      });
    });
    describe('.dispatch', function() {
      return it('should execute the callback for the correct event', function() {
        var callback, event;
        callback = sinon.spy();
        event = new WebSocketRails.Event([
          'event', {
            data: 'message'
          }
        ]);
        this.dispatcher.bind('event', callback);
        this.dispatcher.dispatch(event);
        return expect(callback.calledWith('message')).toEqual(true);
      });
    });
    describe('triggering events with', function() {
      beforeEach(function() {
        return this.dispatcher._conn = {
          connection_id: 123,
          trigger: function() {}
        };
      });
      return describe('.trigger', function() {
        it('should add the event to the queue', function() {
          var event;
          event = this.dispatcher.trigger('event', 'message');
          return expect(this.dispatcher.queue[event.id]).toEqual(event);
        });
        it('should delegate to the connection object', function() {
          var conn_trigger;
          conn_trigger = sinon.spy(this.dispatcher._conn, 'trigger');
          this.dispatcher.trigger('event', 'message');
          return expect(conn_trigger.called).toEqual(true);
        });
        return it("should not delegate to the connection object, if it's not available", function() {
          this.dispatcher._conn = null;
          return this.dispatcher.trigger('event', 'message');
        });
      });
    });
    describe('.connection_stale', function() {
      describe('when state is connected', function() {
        return it('should return false', function() {
          this.dispatcher.state = 'connected';
          return expect(this.dispatcher.connection_stale()).toEqual(false);
        });
      });
      return describe('when state is disconnected', function() {
        return it('should return true', function() {
          this.dispatcher.state = 'disconnected';
          return expect(this.dispatcher.connection_stale()).toEqual(true);
        });
      });
    });
    return describe('working with channels', function() {
      beforeEach(function() {
        return WebSocketRails.Channel = function(name, dispatcher, is_private) {
          this.name = name;
          this.dispatcher = dispatcher;
          this.is_private = is_private;
        };
      });
      describe('.subscribe', function() {
        describe('for new channels', function() {
          return it('should create and store a new Channel object', function() {
            var channel;
            channel = this.dispatcher.subscribe('test_channel');
            return expect(channel.name).toEqual('test_channel');
          });
        });
        return describe('for existing channels', function() {
          return it('should return the same Channel object', function() {
            var channel;
            channel = this.dispatcher.subscribe('test_channel');
            return expect(this.dispatcher.subscribe('test_channel')).toEqual(channel);
          });
        });
      });
      describe('.subscribe_private', function() {
        return it('should create private channels', function() {
          var private_channel;
          private_channel = this.dispatcher.subscribe_private('private_something');
          return expect(private_channel.is_private).toBe(true);
        });
      });
      describe('.unsubscribe', function() {
        return describe('for existing channels', function() {
          return it('should remove the Channel object', function() {
            this.dispatcher.unsubscribe('test_channel');
            return expect(this.dispatcher.channels['test_channel']).toBeUndefined;
          });
        });
      });
      return describe('.dispatch_channel', function() {
        return it('should delegate to the Channel object', function() {
          var channel, event, spy;
          channel = this.dispatcher.subscribe('test');
          channel.dispatch = function() {};
          spy = sinon.spy(channel, 'dispatch');
          event = new WebSocketRails.Event([
            'event', {
              channel: 'test',
              data: 'awesome'
            }
          ]);
          this.dispatcher.dispatch_channel(event);
          return expect(spy.calledWith('event', 'awesome')).toEqual(true);
        });
      });
    });
  });

}).call(this);
