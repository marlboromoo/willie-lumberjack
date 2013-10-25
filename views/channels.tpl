% least = 9

      <h2>#Channels <small>...</small></h3>
      % if channels:
        % for c in channels:
      <a class="img-thumbnail" href="/channel/{{c}}/"><img data-src="holder.js/200x200/text:#{{c}}" alt="#{{c}}"></a>
        % end
        % if len(channels) < least:
          % for i in xrange(least - len(channels)):
      <a class="img-thumbnail" href="#"><img data-src="holder.js/200x200/text:None" alt="None"></a>
          % end
        % end
      % else:
        % for i in xrange(least):
      <a class="img-thumbnail" href="#"><img data-src="holder.js/200x200/text:None" alt="None"></a>
        % end
      % end

      <p> </p>
      <p> </p>


% rebase layout title='channels', project=project, channels=channels
