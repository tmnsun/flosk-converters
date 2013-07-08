#encoding: utf-8

require "rubygems"
require "sequel"

db_from = Sequel.mysql(:host => 'localhost', :user => 'root', :database => 'blesk72r_joomla')
db_to = Sequel.postgres(:host=>'localhost', :user=>'sun', :database=>'flosk_development')


articles = db_to[:articles]

db_from[:jos_blesk_articles].each do |article|
	articles.insert(
		:title => article[:title],
		:subtitle => article[:subtitle],
		:announce => article[:pretext].to_s,
		:body => article[:text].to_s,
		:created_at => article[:add_date],
		:updated_at => article[:add_date],
		:old_image => article[:preimg],
		:old_gallery => article[:gallery],
		:author => article[:autor],
		:slug => article[:sub_name]
	)
end