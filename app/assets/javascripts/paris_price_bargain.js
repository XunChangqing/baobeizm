// Generated by CoffeeScript 1.9.3
(function() {
  var bagnums, personnums, progressbar_width, refresh, totalpeople, worker;

  totalpeople = 1000;

  progressbar_width = 950;

  bagnums = [50, 100, 150, 200, 250, 300];

  personnums = [0, 100, 300, 500, 800, 1000];

  worker = function() {
    return $.post('/paris_price_bargain/vote.json', {
      update: 1
    }, function(data) {
      refresh(data['count']);
      return setTimeout(worker, 5000);
    });
  };

  refresh = function(progress) {
    var bagimgs, i, j, k, l, left, len, len1, len2, num, p, personimgs, ratio, results;
    $('#count').text(progress.toString());
    ratio = progress / totalpeople;
    p = Math.floor(ratio * 100) + '%';
    $('#progressbar').css('width', p);
    left = (ratio * progressbar_width - 80 / 2) + 'px';
    $('#shield').css('left', left);
    for (j = 0, len = bagnums.length; j < len; j++) {
      num = bagnums[j];
      bagimgs = $('#bag-' + num);
    }
    for (k = 0, len1 = personnums.length; k < len1; k++) {
      num = personnums[k];
      personimgs = $('#person-' + num);
    }
    results = [];
    for (i = l = 0, len2 = bagnums.length; l < len2; i = ++l) {
      num = bagnums[i];
      if (num > progress) {
        results.push(bagimgs[i].attr('src', "/image/parispb/bags-" + num + "-todo.png"));
      } else if (bagnums[i + 1] > progress) {
        results.push(bagimgs[i].attr('src', "/image/parispb/bags-" + num + "-doing.png"));
      } else {
        results.push(bagimgs[i].attr('src', "/image/parispb/bags-" + num + "-done.png"));
      }
    }
    return results;
  };

  $(function() {
    var error;
    try {
      refresh(100);
      return $('#vote-form').submit(function() {
        if ($('input#user-name').val().length <= 0) {
          alert("请输入有效的姓名!");
          return false;
        }
        if (!$('input#user-phone').val().match(/[0-9]{11}/i)) {
          alert("请输入有效的手机号码!");
          return false;
        }
        $.post($(this).attr('action'), $(this).serialize(), function(data) {
          return refresh(data['count']);
        });
        return false;
      });
    } catch (_error) {
      error = _error;
      return alert(error);
    }
  });

}).call(this);