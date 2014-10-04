$(function() {
  $('.emotion').click(function() {
    var how = document.getElementById('how');
    how.value += $(this).text();
  });

  $('#btn-tweet').click(function() {
    // 別ウインドウで開くようにする
    this.target = '_blank'

    // <textarea>要素の内容を取得し投稿内容を作成
    var tweet = {
      text: document.getElementById('what').value + document.getElementById('how').value,
      hashtags: 'WhatHow'
    };
    // 投稿内容のパラメータをquery stringに変換し、URLを作成
    // ex) https://twitter.com/intent/tweet?text=TweetText&hashtags=WhatHow
    var url = 'https://twitter.com/intent/tweet?' + $.param(tweet);
    this.href = url;
  });

});
