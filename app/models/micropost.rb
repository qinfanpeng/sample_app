# -*- coding: utf-8 -*-
class Micropost < ActiveRecord::Base
  attr_accessible :content
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  belongs_to :user
  default_scope order: "microposts.created_at DESC" # 相当与定义了一类方法，应用与所有查询的附件条件
end
