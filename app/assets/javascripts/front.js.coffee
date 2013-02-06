speed = 1

`function swap_nodes(a, b) {
    var asibling= a.next()===b? a : a.next();
    a.insertBefore(b);
    b.insertBefore(asibling);}`

blank_tweet = ->
  tweet = $('.tweet').eq(0)
  tweet.addClass('blank')
  tweet.children('.text').eq(0).html('')
  tweet.children('.image').eq(0).attr('src', '')
  tweet.attr('tweet_id', '')

update_tweet = ->
  tweet = $('.tweet').eq(0)
  $.getJSON('update_tweet/' + tweet.attr('tweet_id'), (resp) ->
    tweet.children('.text').eq(0).html(resp.text)
    tweet.children('.image').eq(0).attr('src', resp.image)
    tweet.attr('tweet_id', resp.tweet_id))

swap = (tweet1, tweet2) ->
  tweet1.animate({top: tweet2.css('top'), left: tweet2.css('left')}, 1618 / speed, -> $('#animator').dequeue())
  tweet2.animate({top: tweet1.css('top'), left: tweet1.css('left')}, 1000 / speed, ->
    swap_nodes(tweet1, tweet2))

fill = ->
  blank = $('.blank:last')
  range = $('.tweet').slice(1, $('.tweet').index($('.blank:last')) + 1)
  swap( range.eq(-1), range.eq(-2) )

fill_whole = ->
  blank = $('.blank')

#dev aides
swap_off = (place) ->
  tweets = $(".tweet")
  tweet1 = tweets.eq(0)
  tweet2 = tweets.eq(place)
  swap tweet1, tweet2

cycle = ->
  tweets = $('.tweet')
  $.each(tweets, (index, tweet) ->
    next_tweet = tweets.eq( (index + 1) % tweets.length )
    console.log index, tweet, next_tweet
    $(tweet).queue( -> $(this).animate({top: next_tweet.css('top'), left: next_tweet.css('left')}, 1000))
  )
  tweets.each (i) ->
    tweets.eq(i).dequeue()

    
$ ->
  tweets = $('.tweet')
  tweets.each ->
    $(this).css( 'top', $(this).offset().top)
    $(this).css( 'left', $(this).offset().left)
  tweets.each ->
    $(this).css 'position', 'absolute'
    $(this).children('.index').html(tweets.index($(this)))
  cycle()
  $('#cycle').click( -> cycle() )

