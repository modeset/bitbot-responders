# encoding: UTF-8
require 'net/http'
require 'nokogiri'

class NicknameResponder < Bitbot::Responder
  include Bitbot::Responder::Wit

  category 'Miscellaneous'
  help 'misc:nickname <world>', description: 'Gives you a nickname for a given world (e.g. pirate, wutang, blues, potter, hacker)',
    examples: ['what\'s my hacker nickname?', 'if I were in harry potter, what would my nick name be?']

  WORLDS = {
    pirate: {uri: 'http://mess.be/pirate-names-male.php', response: 'Arrr! Yer pirate name be {{nick}}', selector: '.normalText font b'},
    wutang: {uri: 'http://mess.be/inickgenwuname.php', response: 'Your Wu-Tang Clan name is {{nick}}', selector: 'center b font:not(.normalText)'},
    blues:  {uri: 'http://mess.be/inickgenbluesmalename.php', response: 'Welcome to the Crossroads, {{nick}}', selector: 'center > .boldText'},
    potter: {uri: 'http://mess.be/harry-potter-names-male.php', response: 'Here is your wizarding name: {{nick}}', selector: 'center .normalText font b'},
    hacker: {uri: 'http://mess.be/inickgenhacker.php', response: 'Welcome to the Matrix, {{nick}}', selector: 'center > p.normalText > b'},
  }

  intent 'nickname', :nickname, entities: {nickname_world: nil}
  route :nickname, /^misc:nickname\s+(.*)$/i do |world_type|
    world = WORLDS[world_type.to_sym] or raise(Bitbot::Response, "I don't know of this \"#{world_type}\" world.")
    respond_with(world[:response].gsub('{{nick}}', nickname_for_world(world)))
  end

  private

  def nickname_for_world(world)
    res = Net::HTTP.post_form(URI.parse(world[:uri]), {realname: message.user_name})
    nick = Nokogiri::HTML(res.body).css(world[:selector]).map { |el| el.text }.join(' ')
    nick.gsub(/\n/, ' ').gsub(/\s+/, ' ').gsub(/^\s|\s$/, '')
  end

end
