Bitbot Responders
=================

[![Build Status](https://img.shields.io/travis/modeset/bitbot-responders.svg)](https://travis-ci.org/modeset/bitbot-responders)
[![Code Climate](https://img.shields.io/codeclimate/github/modeset/bitbot-responders.svg)](https://codeclimate.com/github/modeset/bitbot-responders)
[![Test Coverage](https://img.shields.io/codeclimate/coverage/github/modeset/bitbot-responders.svg)](https://codeclimate.com/github/modeset/bitbot-responders)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)

This is a collection of Bitbot responders intended for the
[Bitbot](https://github.com/modeset/bitbot) Rack Slack bot.

These responders utilize [Wit.ai](http://wit.ai) natural language processing to route intents to
various responders.

- **help**<br/>
  You're looking at it<br/><br/>
- **misc:nickname <world>**<br/>
  Gives you a nickname for a given world (e.g. pirate, wutang, blues, potter, hacker)<br/>
  **Examples:** *what's my hacker nickname?*, *if I were in harry potter, what would my nick name be?*<br/><br/>
- **misc:zen**<br/>
  Responds with a zen message<br/>
  **Examples:** *give me zen.*, *zen me.*<br/><br/>
- **misc:catfact**<br/>
  Provides a random cat fact from my massive trivia database<br/>
  **Examples:** *cat fact?*, *I hate cats.*, *what should I know about cats?*<br/><br/>
- **misc:magic8ball**<br/>
  Ask the almighty 8-ball for an answer to your question<br/>
  **Examples:** *8ball me.*, *magic 8 ball says?*<br/><br/>
- **misc:fortune**<br/>
  Reaches into the worlds aura and spirit to provide a fortune<br/>
  **Examples:** *fortune me.*, *what's my fortune?*, *give me a fortune cookie.*<br/><br/>
- **misc:cointoss**<br/>
  Flips a coin and provides the result<br/>
  **Examples:** *heads or tails?*, *flip a coin.*, *coin toss.*<br/><br/>
- **misc:achievement username <text>**<br/>
  Displays the achievement award to the user<br/>
  **Examples:** *give @jejacks0n a badge for "Being Awesome."*, *@cacheflowe deserves a "Participation" achievement.*<br/><br/>
- **misc:quote**<br/>
  Provides a random quote<br/>
  **Examples:** *give me a quote.*, *inspiration?*, *enlighten me.*<br/><br/>
- **misc:cards**<br/>
  Provides a random cards against humanity question and answer card.<br/>
  **Examples:** *cards against humanity.*, *give me some cards.*<br/><br/>
- **general:isitup <domain>**<br/>
  Checks to see if a domain is up.<br/>
  **Examples:** *is ello.co up?*, *is ello.co down?*<br/><br/>
- **general:password <length>**<br/>
  Generates a readable password<br/>
  **Examples:** *I need a password.*, *generate a password for me.*<br/><br/>
- **general:standup**<br/>
  Responds with list of what everyone is working on.<br/>
  **Examples:** *what are people working on?*, *what's @jejacks0n working on today?*<br/><br/>
- **general:timer <seconds>**<br/>
  Creates a timer that will alert you when it's done<br/>
  **Examples:** *set a timer for 4 minutes.*, *timebox this to 30 minutes.*<br/><br/>
- **heroku:status**<br/>
  Returns the current Heroku status for app operations and tools<br/>
  **Examples:** *heroku status?*, *what's the status of heroku?*<br/><br/>
- **heroku:issues**<br/>
  Returns a list of the most recent 5 issues<br/>
  **Examples:** *heroku issues?*, *is heroku reporting any issues?*<br/><br/>
- **weather:conditions <location>**<br/>
  Displays current conditions for a given location<br/>
  **Examples:** *Denver CO weather*, *weather for Denver CO*, *current conditions for Denver*<br/><br/>
- **weather:forecast <location>**<br/>
  Fetches a weather forecast for a given location<br/>
  **Examples:** *what's the forecast for Denver CO?*, *Denver CO forecast*<br/><br/>
- **weather:moon <location>**<br/>
  Displays the moon phase information for a given location<br/>
  **Examples:** *Denver CO moon*, *moon for Denver CO*, *moon phase for Denver*<br/><br/>


## License

Licensed under the [MIT License](http://creativecommons.org/licenses/MIT/)

Copyright 2014 [Mode Set](https://github.com/modeset)


## Make Code Not War
![crest](https://secure.gravatar.com/avatar/aa8ea677b07f626479fd280049b0e19f?s=75)
