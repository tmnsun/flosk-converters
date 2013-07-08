#encoding: utf-8

require "rubygems"
require "sequel"

db_from = Sequel.mysql(:host => 'localhost', :user => 'root', :database => 'blesk72r_joomla')
db_to = Sequel.postgres(:host=>'localhost', :user=>'sun', :database=>'flosk_development')

categories = {
	1 => "salon",
	2 => "tyumen",
	3 => "world"
}

new_categories = {
 	"salon" => db_to[:news_categories].where(:name => "salon").first[:id],
 	"tyumen" => db_to[:news_categories].where(:name => "tyumen").first[:id],
 	"world" => db_to[:news_categories].where(:name => "world").first[:id],
}

news = db_to[:news]

db_from[:jos_blesk_news].each do |news_item|
	puts news_item[:pretext]

	news.insert(
		:title => news_item[:title],
		:announce => news_item[:pretext].to_s,
		:body => news_item[:text].to_s,
		:created_at => news_item[:add_date],
		:updated_at => news_item[:add_date],
		:news_category_id => new_categories[categories[news_item[:part]]],
		:old_image => news_item[:preimg],
	)
end