(function() {
  describe('WebSocketRails.Channel:', function() {
    beforeEach(function() {
      var WebSocketRailsStub;
      this.dispatcher = new (WebSocketRailsStub = (function() {
        function WebSocketRailsStub() {}

        WebSocketRailsStub.prototype.new_message = function() {
          return true;
        };

        WebSocketRailsStub.prototype.dispatch = function() {
          return true;
        };

        WebSocketRailsStub.prototype.trigger_event = function(event) {
          return true;
        };

        WebSocketRailsStub.prototype.state = 'connected';

        WebSocketRailsStub.prototype._conn = {
          connection_id: 12345
        };

        return WebSocketRailsStub;

      })());
      this.channel = new WebSocketRails.Channel('public', this.dispatcher);
      return sinon.spy(this.dispatcher, 'trigger_event');
    });
    afterEach(function() {
      return this.dispatcher.trigger_event.restore();
    });
    describe('.bind', function() {
      return it('should add a function to the callbacks collection', function() {
        var test_func;
        test_func = function() {};
        this.channel.bind('event_name', test_func);
        expect(this.channel._callbacks['event_name'].length).toBe(1);
        return expect(this.channel._callbacks['event_name']).toContain(test_func);
      });
    });
    describe('.trigger', function() {
      describe('before the channel token is set', function() {
        return it('queues the events', function() {
          var queue;
          this.channel.trigger('someEvent', 'someData');
          queue = this.channel._queue;
          expect(queue[0].name).toEqual('someEvent');
          return expect(queue[0].data).toEqual('someData');
        });
      });
      return describe('when channel token is set', function() {
        return it('adds token to event metadata and dispatches event', function() {
          this.channel._token = 'valid token';
          this.channel.trigger('someEvent', 'someData');
          return expect(this.dispatcher.trigger_event.calledWith([
            'someEvent', {
              token: 'valid token',
              data: 'someData'
            }
          ]));
        });
      });
    });
    describe('.destroy', function() {
      it('should destroy all callbacks', function() {
        var event_callback;
        event_callback = function() {
          return true;
        };
        this.channel.bind('new_message', this.event_callback);
        this.channel.destroy();
        return expect(this.channel._callbacks).toEqual({});
      });
      describe('when this channel\'s connection is still active', function() {
        return it('should send unsubscribe event', function() {
          this.channel.destroy();
          return expect(this.dispatcher.trigger_event.args[0][0].name).toEqual('websocket_rails.unsubscribe');
        });
      });
      return describe('when this channel\'s connection is no more active', function() {
        beforeEach(function() {
          return this.dispatcher._conn.connection_id++;
        });
        return it('should not send unsubscribe event', function() {
          this.channel.destroy();
          return expect(this.dispatcher.trigger_event.notCalled).toEqual(true);
        });
      });
    });
    describe('public channels', function() {
      beforeEach(function() {
        this.channel = new WebSocketRails.Channel('forchan', this.dispatcher, false);
        return this.event = this.dispatcher.trigger_event.lastCall.args[0];
      });
      it('should trigger an event containing the channel name', function() {
        return expect(this.event.data.channel).toEqual('forchan');
      });
      it('should trigger an event containing the correct connection_id', function() {
        return expect(this.event.connection_id).toEqual(12345);
      });
      it('should initialize an empty callbacks property', function() {
        expect(this.channel._callbacks).toBeDefined();
        return expect(this.channel._callbacks).toEqual({});
      });
      return it('should be public', function() {
        return expect(this.channel.is_private).toBeFalsy;
      });
    });
    describe('channel tokens', function() {
      it('should set token when event_name is websocket_rails.channel_token', function() {
        this.channel.dispatch('websocket_rails.channel_token', {
          token: 'abc123'
        });
        return expect(this.channel._token).toEqual('abc123');
      });
      it("should refresh channel's connection_id after channel_token has been received", function() {
        this.channel.connection_id = null;
        this.channel.dispatch('websocket_rails.channel_token', {
          token: 'abc123'
        });
        return expect(this.channel.connection_id).toEqual(this.dispatcher._conn.connection_id);
      });
      return it('should flush the event queue after setting token', function() {
        this.channel.trigger('someEvent', 'someData');
        this.channel.dispatch('websocket_rails.channel_token', {
          token: 'abc123'
        });
        return expect(this.channel._queue.length).toEqual(0);
      });
    });
    return describe('private channels', function() {
      beforeEach(function() {
        this.channel = new WebSocketRails.Channel('forchan', this.dispatcher, true);
        return this.event = this.dispatcher.trigger_event.lastCall.args[0];
      });
      it('should trigger a subscribe_private event when created', function() {
        return expect(this.event.name).toEqual('websocket_rails.subscribe_private');
      });
      return it('should be private', function() {
        return expect(this.channel.is_private).toBeTruthy;
      });
    });
  });

}).call(this);
