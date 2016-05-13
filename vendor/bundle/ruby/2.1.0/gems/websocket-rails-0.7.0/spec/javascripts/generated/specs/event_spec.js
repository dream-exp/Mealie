(function() {
  describe('WebSocketRails.Event', function() {
    describe('standard events', function() {
      beforeEach(function() {
        this.data = [
          'event', {
            data: {
              message: 'test'
            }
          }, 12345
        ];
        return this.event = new WebSocketRails.Event(this.data);
      });
      it('should generate an ID', function() {
        return expect(this.event.id).not.toBeNull;
      });
      it('should have a connection ID', function() {
        return expect(this.event.connection_id).toEqual(12345);
      });
      it('should assign the correct properties when passed a data array', function() {
        expect(this.event.name).toEqual('event');
        return expect(this.event.data.message).toEqual('test');
      });
      describe('.serialize()', function() {
        return it('should serialize the event as JSON', function() {
          var serialized;
          this.event.id = 1;
          serialized = "[\"event\",{\"id\":1,\"data\":{\"message\":\"test\"}}]";
          return expect(this.event.serialize()).toEqual(serialized);
        });
      });
      return describe('.is_channel()', function() {
        return it('should be false', function() {
          return expect(this.event.is_channel()).toEqual(false);
        });
      });
    });
    describe('channel events', function() {
      beforeEach(function() {
        this.data = [
          'event', {
            channel: 'channel',
            data: {
              message: 'test'
            }
          }
        ];
        return this.event = new WebSocketRails.Event(this.data);
      });
      it('should assign the channel property', function() {
        expect(this.event.channel).toEqual('channel');
        expect(this.event.name).toEqual('event');
        return expect(this.event.data.message).toEqual('test');
      });
      describe('.is_channel()', function() {
        return it('should be true', function() {
          return expect(this.event.is_channel()).toEqual(true);
        });
      });
      return describe('.serialize()', function() {
        return it('should serialize the event as JSON', function() {
          var serialized;
          this.event.id = 1;
          serialized = "[\"event\",{\"id\":1,\"channel\":\"channel\",\"data\":{\"message\":\"test\"}}]";
          return expect(this.event.serialize()).toEqual(serialized);
        });
      });
    });
    return describe('.run_callbacks()', function() {
      beforeEach(function() {
        var failure_func, success_func;
        success_func = function(data) {
          return data;
        };
        failure_func = function(data) {
          return data;
        };
        this.data = [
          'event', {
            data: {
              message: 'test'
            }
          }, 12345
        ];
        return this.event = new WebSocketRails.Event(this.data, success_func, failure_func);
      });
      describe('when successful', function() {
        it('should run the success callback when passed true', function() {
          return expect(this.event.run_callbacks(true, 'success')).toEqual('success');
        });
        return it('should not run the failure callback', function() {
          return expect(this.event.run_callbacks(true, 'success')).toBeUndefined;
        });
      });
      return describe('when failure', function() {
        it('should run the failure callback when passed true', function() {
          return expect(this.event.run_callbacks(false, 'failure')).toEqual('failure');
        });
        return it('should not run the failure callback', function() {
          return expect(this.event.run_callbacks(false, 'failure')).toBeUndefined;
        });
      });
    });
  });

}).call(this);
